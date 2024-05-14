import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_order/database/database.dart';
import 'package:work_order/enum/work_order.dart';
import 'package:work_order/models/work_order.dart';

class WorkOrderRepository extends ChangeNotifier {
  final List<WorkOrder> _workOrders = [];    

  UnmodifiableListView<WorkOrder> get workOrders => UnmodifiableListView(_workOrders);

  WorkOrderRepository() {
    notifyListeners();
  }
  
  
  saveWorkOrder(WorkOrder workOrder) async {
    await DatabaseHelper.instance.insert({
      'id': workOrder.id,
      'title': workOrder.title,
      'description': workOrder.description,
      'status': Status.open.toString(),
      'number': workOrder.number,
      'createdAt': workOrder.createdAt.toIso8601String(),
      'updatedAt': workOrder.updatedAt.toIso8601String(),
      'deleted': false,
    });
    notifyListeners();
  }

  Future<List<WorkOrder>> getWorkOrders(showDeleted, showWoClosed) async {
    final workOrders = await DatabaseHelper.instance.queryAllRows();
    List<WorkOrder> filteredWorkOrders = workOrders.map((wo) => WorkOrder(
      id: wo['id'].toString(),
      title: wo['title'],
      description: wo['description'],
      status: wo['status'] == Status.open.toString() ? Status.open : Status.closed,
      number: wo['number'],
      createdAt: DateTime.parse(wo['createdAt']),
      updatedAt: DateTime.parse(wo['updatedAt']),
      deleted: wo['deleted'] == 1,
    )).toList();

    if (showWoClosed) {
      return filteredWorkOrders.where((wo) => wo.status == Status.closed).toList();
    } else {
      return filteredWorkOrders.where((wo) => wo.deleted == showDeleted).toList();
    }
  }

  Future<void> updateWorkOrder(WorkOrder workOrder, String title, String description) async {
    WorkOrder updatedWorkOrder = WorkOrder(
      id: workOrder.id,
      title: title,
      description: description,
      status: workOrder.status,
      number: workOrder.number,
      createdAt: workOrder.createdAt,
      updatedAt: DateTime.now(),
      deleted: workOrder.deleted,
    );

    await DatabaseHelper.instance.update(updatedWorkOrder);
    notifyListeners();
  }

  Future<void> closeWorkOrder(WorkOrder workOrder) async {
    WorkOrder updatedWorkOrder = WorkOrder(
      id: workOrder.id,
      title: workOrder.title,
      description: workOrder.description,
      status: Status.closed,
      number: workOrder.number,
      createdAt: workOrder.createdAt,
      updatedAt: DateTime.now(),
      deleted: workOrder.deleted,
    );

    await DatabaseHelper.instance.update(updatedWorkOrder);
    notifyListeners();
  }

  Future<void> deleteWorkOrder(WorkOrder workOrder) async {
    WorkOrder updatedWorkOrder = WorkOrder(
      id: workOrder.id,
      title: workOrder.title,
      description: workOrder.description,
      status: workOrder.status,
      number: workOrder.number,
      createdAt: workOrder.createdAt,
      updatedAt: DateTime.now(),
      deleted: true,
    );

    await DatabaseHelper.instance.update(updatedWorkOrder);
    notifyListeners();
  }

  Future<void> restoreWorkOrder(WorkOrder workOrder) async {
    WorkOrder updatedWorkOrder = WorkOrder(
      id: workOrder.id,
      title: workOrder.title,
      description: workOrder.description,
      status: workOrder.status,
      number: workOrder.number,
      createdAt: workOrder.createdAt,
      updatedAt: DateTime.now(),
      deleted: false,
    );

    await DatabaseHelper.instance.update(updatedWorkOrder);
    notifyListeners();
  }
}
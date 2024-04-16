import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:work_order/enum/work_order.dart';
import 'package:work_order/models/work_order.dart';

class WorkOrderRepository extends ChangeNotifier {
  final List<WorkOrder> _workOrders = [];    

  UnmodifiableListView<WorkOrder> get workOrders => UnmodifiableListView(_workOrders);

  WorkOrderRepository() {
    _workOrders.addAll(
      [
        WorkOrder(
          id: '1',
          title: 'cleaning glass ',
          description: 'use vanish',
          status: Status.open,
          number: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deleted: false,
        ),
        WorkOrder(
          id: '2',
          title: 'cleaning shoes ',
          description: 'wear clean shoes',
          status: Status.open,
          number: 2,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deleted: false,
        ),
        WorkOrder(
          id: '3',
          title: 'pay bill',
          description: 'pay by ticket',
          status: Status.open,
          number: 3,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deleted: false,
        ),
        WorkOrder(
          id: '4',
          title: 'hat cleaning',
          description: 'use hat cleaner',
          status: Status.closed,
          number: 4,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deleted: false,
        ),
      ],
    );
    notifyListeners();
  }
  
  saveWorkOrder(WorkOrder workOrder) {
    _workOrders.add(workOrder);
    notifyListeners();
  }

  List<WorkOrder> getWorkOrders(bool showDeleted, bool showWoClosed) {
    if (showWoClosed) {
      return workOrders.where((wo) => wo.status == Status.closed).toList();
    } else {
      return workOrders.where((wo) => wo.deleted == showDeleted).toList();
    }
  }

  deleteWorkOrder(WorkOrder workOrder) {
    final oldWorkOrder = _workOrders.firstWhere(
      (wo) => wo.id == workOrder.id,
    );

    final woIndex = _workOrders.indexOf(oldWorkOrder);

    _workOrders.replaceRange(woIndex, woIndex + 1, [
      WorkOrder(
        id: workOrder.id,
        title: workOrder.title ,
        description: workOrder.description,
        status: workOrder.status,
        number: workOrder.number,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        deleted: true,
      )
    ]);
    notifyListeners();
  }

  restoreWorkOrder(WorkOrder workOrder) {
    final oldWorkOrder = _workOrders.firstWhere(
      (wo) => wo.id == workOrder.id,
    );

    final woIndex = _workOrders.indexOf(oldWorkOrder);

    _workOrders.replaceRange(woIndex, woIndex + 1, [
      WorkOrder(
        id: workOrder.id,
        title: workOrder.title ,
        description: workOrder.description,
        status: workOrder.status,
        number: workOrder.number,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        deleted: false,
      )
    ]);
    notifyListeners();
  }

  updateWorkOrder(WorkOrder workOrder, String title, String description) {
    final oldWorkOrder = _workOrders.firstWhere(
      (wo) => wo.id == workOrder.id,
    );

    final woIndex = _workOrders.indexOf(oldWorkOrder);

    _workOrders.replaceRange(woIndex, woIndex + 1, [
      WorkOrder(
        id: workOrder.id,
        title: title,
        description: description,
        status: workOrder.status,
        number: workOrder.number,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        deleted: workOrder.deleted,
      )
    ]);
    notifyListeners();
  }
}
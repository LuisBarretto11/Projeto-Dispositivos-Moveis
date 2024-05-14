import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_order/enum/work_order.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/repositories/work_order_repository.dart';

class AddWorkOrderPage extends StatefulWidget {
  const AddWorkOrderPage({super.key});

  @override
  State<AddWorkOrderPage> createState() => _AddWorkOrderPageState();
}

class _AddWorkOrderPageState extends State<AddWorkOrderPage> {
  final _formKey = GlobalKey<FormState>();

  final _workOrderStatus = Status.open;
  final _workOrderNumber = Random().nextInt(100);
  final _workOrderId = Random().nextInt(10000).toString();
  final _workOrderTitle = TextEditingController();
  final _workOrderDescription = TextEditingController();
  
  saveWorkOrder() {
    if (_formKey.currentState!.validate()) {
      final workOrderRepository = context.read<WorkOrderRepository>();

      workOrderRepository.saveWorkOrder(
        WorkOrder(
          id: _workOrderId,
          title: _workOrderTitle.text,
          description: _workOrderDescription.text,
          status: _workOrderStatus,
          number: _workOrderNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deleted: false,
        ),
      );    
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextButton.icon(
              onPressed: () => saveWorkOrder(),
              icon: const Icon(Icons.check_circle),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: TextFormField(
                  controller: _workOrderTitle,
                  validator: (value) {
                    if (value!.isEmpty) return 'Write a title';
                    if (value.length < 5) return 'Write 5 character';
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Title', style: TextStyle(fontSize: 18)),                 
                  ),
                ),
              ),             
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _workOrderDescription,
                  validator: (value) {
                    if (value!.isEmpty) return 'Write a description';
                    return null;
                  },
                  minLines: 5,
                  maxLines: 40,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description...',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

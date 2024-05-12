import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/repositories/work_order_repository.dart';
import 'package:work_order/theme/custom_black_theme.dart';

class WorkOrderDetailsPage extends StatelessWidget {
  final WorkOrder workOrder;
  final _workOrderTitle = TextEditingController();
  final _workOrderDescription = TextEditingController();

  WorkOrderDetailsPage({super.key, required this.workOrder}) {
    _workOrderTitle.text = workOrder.title;
    _workOrderDescription.text = workOrder.description;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () {
        context.read<WorkOrderRepository>().updateWorkOrder(
              workOrder,
              _workOrderTitle.text,
              _workOrderDescription.text,
            );
        return Future.value(true);
      },
      child: Hero(
        tag: 'workOrder-${workOrder.hashCode}',
        child: Material(
          color: isDark ? CustomBlackTheme.black : Colors.red[300],
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: isDark ? Colors.green[900] : Colors.pink[100],
              ),
            ),
            child: ListView(
              children: [
                AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (workOrder.deleted) {
                          context.read<WorkOrderRepository>().restoreWorkOrder(workOrder);
                        } else {
                          context.read<WorkOrderRepository>().deleteWorkOrder(workOrder);
                        }
                        Navigator.of(context).pop();
                      },
                      icon: !workOrder.deleted
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete, size: 20),
                              Icon(Icons.close, size: 20),
                            ],
                          )
                        : const Icon(Icons.restore),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    cursorColor: Colors.deepPurple,
                    controller: _workOrderTitle,
                    minLines: 1,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Divider(height: 36),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    cursorColor: Colors.brown,
                    controller: _workOrderDescription,
                    minLines: 1,
                    maxLines: 60,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Divider(height: 36),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Status: ${workOrder.status.toString().split('.').last}',
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Number: ${workOrder.number.toString()}',
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Deleted: ${workOrder.deleted}',
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
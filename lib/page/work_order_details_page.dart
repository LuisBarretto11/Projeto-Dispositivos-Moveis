import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/repositories/work_order_repository.dart';
import 'package:work_order/theme/custom_black_theme.dart';

class WorkOrderDetailsPage extends StatelessWidget {
  // WorkOrder workOrder;
  final WorkOrder workOrder;
  final _workOrderTitle = TextEditingController();
  final _workOrderDescription = TextEditingController();

  WorkOrderDetailsPage({super.key, required this.workOrder}) {
    _workOrderTitle.text = workOrder.title;
    _workOrderDescription.text = workOrder.description;
  }

  // final _form = GlobalKey<FormState>();

  // String description = '';  

  // salvar() {
  //   if (_form.currentState!.validate()) {
  //     // Salvar a compra

  //     Navigator.pop(context);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Work Order saved!'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

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
                      icon: Icon(!workOrder.deleted ? Icons.delete : Icons.restore),
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

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('${widget.workOrder.title} (#${widget.workOrder.number})'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(24),
    //     child: Column(
    //       children: [
    //         // const Padding(
    //         //   padding: EdgeInsets.only(bottom: 5),
    //         //   child: Row(
    //         //     children: [
    //         //       Column(
    //         //         children: [
    //         //           Text('Description:', style: TextStyle(
    //         //             fontSize: 22,
    //         //             fontWeight: FontWeight.w500,
    //         //           )),                  
    //         //         ],
    //         //       ),                  
    //         //     ],
    //         //   ),
    //         // ),            
    //         Form(
    //           key: _form,
    //           child: TextFormField(
    //             controller: TextEditingController(text: widget.workOrder.description),
    //             style: const TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.w400,
    //             ),
    //             decoration: const InputDecoration(
    //               border: OutlineInputBorder(),
    //               labelText: 'Description',              
    //             ),
    //             keyboardType: TextInputType.text,
    //             validator: (value) {
    //               if (value!.isEmpty) {
    //                 return 'Please enter a description';
    //               } else if (value.length < 2) {
    //                 return 'Please enter a longer description';
    //               }
    //               return null;
    //             },
    //             onChanged: (value) {
    //               setState(() {
    //                 widget.workOrder.description = value;
    //               });
    //             }
    //           ),
    //         ),
    //         Container(
    //           alignment: Alignment.bottomCenter,
    //           margin: const EdgeInsets.only(top: 24),
    //           child: ElevatedButton(
    //             onPressed: salvar,
    //             child: const Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Icon(Icons.save),
    //                 Padding(
    //                   padding: EdgeInsets.all(10),
    //                   child: Text('Save', style: TextStyle(fontSize: 20)),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
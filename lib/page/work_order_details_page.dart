import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/repositories/work_order_repository.dart';
import 'package:work_order/theme/custom_black_theme.dart';
import 'camera_screen.dart';
import 'dart:io';

class WorkOrderDetailsPage extends StatefulWidget {
  final WorkOrder workOrder;

  WorkOrderDetailsPage({Key? key, required this.workOrder}) : super(key: key);

  @override
  _WorkOrderDetailsPageState createState() => _WorkOrderDetailsPageState();
}

class _WorkOrderDetailsPageState extends State<WorkOrderDetailsPage> {
  final _workOrderTitle = TextEditingController();
  final _workOrderDescription = TextEditingController();
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _workOrderTitle.text = widget.workOrder.title;
    _workOrderDescription.text = widget.workOrder.description;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () {
        context.read<WorkOrderRepository>().updateWorkOrder(
              widget.workOrder,
              _workOrderTitle.text,
              _workOrderDescription.text,
            );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                if (widget.workOrder.deleted) {
                  context.read<WorkOrderRepository>().restoreWorkOrder(widget.workOrder);
                } else {
                  context.read<WorkOrderRepository>().deleteWorkOrder(widget.workOrder);
                }
                Navigator.of(context).pop();
              },
              icon: Icon(!widget.workOrder.deleted ? Icons.delete : Icons.restore),
            ),
          ],
        ),
        body: Hero(
          tag: 'workOrder-${widget.workOrder.hashCode}',
          child: Material(
            color: isDark ? CustomBlackTheme.black : Colors.red[300],
            child: Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: isDark ? Colors.green[900] : Colors.pink[100],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  TextFormField(
                    cursorColor: Colors.deepPurple,
                    controller: _workOrderTitle,
                    minLines: 1,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(height: 36),
                  TextFormField(
                    cursorColor: Colors.brown,
                    controller: _workOrderDescription,
                    minLines: 1,
                    maxLines: 60,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Status: ${widget.workOrder.status.toString().split('.').last}',
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Number: ${widget.workOrder.number.toString()}',
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Deleted: ${widget.workOrder.deleted}',
                    ),
                  ),
                  if (_capturedImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.file(_capturedImage!),
                    ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            File? image = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraScreen(
                  onFile: (file) {
                    setState(() {
                      _capturedImage = file;
                    });
                  },
                ),
              ),
            );
          },
          child: Icon(Icons.camera),
        ),
      ),
    );
  }
}

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
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:work_order/enum/work_order.dart';
import 'package:work_order/main.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/page/add_work_order_page.dart';
import 'package:work_order/page/work_order_details_page.dart';
import 'package:work_order/repositories/work_order_repository.dart';
import 'package:work_order/theme/buttom_navigation_widget.dart';
import 'package:work_order/widget/work_order_card.dart';

class WorkOrderPage extends StatefulWidget {
  const WorkOrderPage({super.key});

  @override
  State<WorkOrderPage> createState() => _WorkOrderPageState();
}

class _WorkOrderPageState extends State<WorkOrderPage> {
  final WorkOrderRepository workOrderRepository = WorkOrderRepository();
  List<WorkOrder> workOrders = [];
  bool showDeleted = false;
  bool showWoClosed = false;
  int numColumns = 2;   

  workOrderDetails(WorkOrder workOrder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkOrderDetailsPage(workOrder: workOrder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workOrdersRepository = context.watch<WorkOrderRepository>();
    workOrders = workOrdersRepository.getWorkOrders(showDeleted, showWoClosed);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          showDeleted ? 'Deleted (${workOrders.length})' : showWoClosed ? 'Work Orders Closed' : 'Work Orders (${workOrders.length})',
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => numColumns = (numColumns == 1) ? 2 : 1),
            icon: Icon(numColumns == 2 ? Icons.view_agenda_rounded : Icons.grid_view_rounded),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'picture',
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(),
                      body: Hero(
                        tag: 'picture',
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.asset('images/response.jpeg'),
                          ),
                        ),
                      ),
                    )
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset('images/response.jpeg'),
                ),
              ),
            ),
          ),
        ],
      ),
       body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MasonryGridView.count(
          crossAxisCount: numColumns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: workOrders.length,
          itemBuilder: (context, index) => WorkOrderCard(workOrder: workOrders[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddWorkOrderPage(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomNavigationWidget(
        buttons: [
          IconButton(
            tooltip: '',
            icon: Icon(showDeleted ? Icons.home_outlined : Icons.lightbulb),
            onPressed: () => setState(() { showDeleted = false; showWoClosed = false;}),
          ),
          IconButton(
            tooltip: '',
            icon: Icon(showDeleted ? Icons.delete : Icons.delete_outlined),
            onPressed: () => setState(() { showDeleted = true; showWoClosed = false;}),
          ),
          IconButton(
            tooltip: '',
            icon: const Icon(Icons.search),
            onPressed: () => {}, // search work order by title
          ),
          IconButton(
            tooltip: '',
            icon: Icon(showWoClosed ? Icons.closed_caption : Icons.closed_caption_outlined),
            onPressed: () => setState(() { showDeleted = false; showWoClosed = true;}),
          ),
        ],
      ),      
    );
  }
}
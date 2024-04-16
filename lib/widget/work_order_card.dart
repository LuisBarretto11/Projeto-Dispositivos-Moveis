import 'package:flutter/material.dart';
import 'package:work_order/models/work_order.dart';
import 'package:work_order/page/work_order_details_page.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;

  const WorkOrderCard({super.key, required this.workOrder});

  _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkOrderDetailsPage(workOrder: workOrder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'workOrder-${workOrder.hashCode}',
      child: Card(
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.blue : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () => _openDetails(context),
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.amber.withOpacity(.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workOrder.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  workOrder.description,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),        
              ],
            ),
          ),
        ),
      ),
    );
  }
}

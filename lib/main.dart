import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_order/my_app.dart';
import 'package:work_order/repositories/work_order_repository.dart';

class Title1 {
  String value = 'Deleted';
}

void main() {
   runApp(
    MultiProvider(
      providers: [
        Provider<Title1>(create: (_) => Title1()),
        ChangeNotifierProvider(create: (_) => WorkOrderRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

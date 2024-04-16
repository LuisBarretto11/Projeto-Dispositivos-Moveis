import 'package:flutter/material.dart';
import 'package:work_order/page/work_order_page.dart';
import 'package:work_order/theme/custom_black_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Work Order',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     useMaterial3: false,
    //   ),
    //   home: const WorkOrderPage(),
    // );

    const brightness = Brightness.light;

    return MaterialApp(
      title: 'Work Order',
      debugShowCheckedModeBanner: false,
      theme: CustomBlackTheme.getThemeData(brightness: brightness),
      home: const WorkOrderPage(),
    );
  }
}
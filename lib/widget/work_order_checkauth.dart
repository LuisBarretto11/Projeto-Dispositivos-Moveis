import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:work_order/page/work_order_page.dart';
import 'package:work_order/page/work_order_login.dart';
import 'package:work_order/services/auth_service.dart';

class CheckAuth extends StatelessWidget{


  Widget build(BuildContext context){
    return Obx(() => AuthService.to.userIsAuthenticated.value ? WorkOrderPage() : LoginPage());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_order/database/database.dart';
import 'package:work_order/models/work_order.dart';
import 'package:get/get.dart';


class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      userIsAuthenticated.value = user != null;
    });
  }

  User? get user => _firebaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  showSnack(String titulo, String erro) {
    Get.snackbar(
      titulo,
      erro,
      backgroundColor: Colors.red[0],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack('Erro ao registrar', e.toString());
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showSnack('Erro no Login!', e.toString());
    }
  }

  logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Erro ao sair!', e.toString());
    }
  }
}
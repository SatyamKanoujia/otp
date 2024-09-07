import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  AuthProvider() {
    checkLoginStatus();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString('phoneNumber') != null;
    notifyListeners();
  }

  Future<void> loginUser(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
    _isLoggedIn = false;
    notifyListeners();
  }
}

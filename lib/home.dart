// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('phoneNumber');
    setState(() {
      phoneNumber = storedNumber;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
    setState(() {
      phoneNumber = null;  
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const PhoneHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
        child: phoneNumber != null
            ? Text(
                "$phoneNumber",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            : const Text(
                "No phone number found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,  
        tooltip: 'Logout',
        child: const Icon(Icons.logout_outlined),
      ),
    );
  }
}

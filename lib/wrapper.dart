import 'package:flutter/material.dart';
import 'package:otp/auth_provider.dart';
import 'package:otp/home.dart';
import 'package:otp/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isLoggedIn ? const HomePage() : const PhoneHome();
  }
}

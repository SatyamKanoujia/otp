import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:otp/wrapper.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}

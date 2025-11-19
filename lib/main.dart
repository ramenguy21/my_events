import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyEvents',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      initialRoute: '/auth',
      getPages: [
        GetPage(name: '/auth', page: () => const AuthScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}

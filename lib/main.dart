import 'package:flutter/material.dart';
import 'package:task10_form/Pages/register_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Form',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: RegisterFormPage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intrapos_mobile/core/di/dependency.dart';

void main() {
  initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.red),
      home: Scaffold(
        body: Center(
          child: Text('Haiiii'),
        ),
      ),
    );
  }
}

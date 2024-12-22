import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intrapos_mobile/core/di/dependency.dart';
import 'package:intrapos_mobile/core/widget/loading_app_widget.dart';
import 'package:intrapos_mobile/core/widget/error_app_widget.dart';
import 'package:intrapos_mobile/app/presentation/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
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
        body: LoginScreen(),
      ),
    );
  }
}

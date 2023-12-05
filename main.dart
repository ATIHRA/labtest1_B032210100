import 'package:flutter/material.dart';
import 'BMI_Calculate.dart';
import 'Controller/sqlite_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that the binding is initialized
  await SQLiteDB().init(); // Call init to retrieve data from SQLite database
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

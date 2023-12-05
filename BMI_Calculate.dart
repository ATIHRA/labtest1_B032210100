import 'package:flutter/material.dart';
import 'dart:math';
import 'Controller/sqlite_db.dart';

void main() {
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

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController(); // Added BMI controller
  String gender = 'Male';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Fullname',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: heightController,
              decoration: InputDecoration(
                labelText: 'height in cm; 170',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: 'weight in KG',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: bmiController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'BMI Value',
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: 'Male',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              Text('Male'),
              SizedBox(width: 100),
              Radio(
                value: 'Female',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              Text('Female'),
            ],
          ),
          ElevatedButton(
            onPressed: _calculateBMI,
            child: Text('Calculate BMI and Save'),
          ),

          Text(
            result,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _calculateBMI() {
    String name = nameController.text;
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    double bmi = weight / pow((height/ 100),2);
    String bmiCategory = _getBMICategory(bmi);

    setState(() {
      result = '''
       
       $gender $bmiCategory
      ''';
      bmiController.text = bmi.toStringAsFixed(2);
      SQLiteDB().insert('bmi', {
        'username': name,
        'weight': weight,
        'height': height,
        'gender': gender,
        'bmi_status': bmiCategory,
      });
    });
  }


  String _getBMICategory(double bmi) {
    if (gender == 'Male') {
      if (bmi < 18.5) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 18.5 && bmi < 25) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 25 && bmi < 30) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    } else {
      // For female
      if (bmi < 16) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 16 && bmi < 22) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 22 && bmi < 27) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    }
  }
}


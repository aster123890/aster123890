// EditBMIScreen.dart
import 'package:flutter/material.dart';

class EditBMIScreen extends StatefulWidget {
  @override
  _EditBMIScreenState createState() => _EditBMIScreenState();
}

class _EditBMIScreenState extends State<EditBMIScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmi = 0;
  String bmiCategory = '';

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        if (_bmi < 18.5) {
          bmiCategory = "Underweight";
        } else if (_bmi < 24.9) {
          bmiCategory = "Normal weight";
        } else if (_bmi < 29.9) {
          bmiCategory = "Overweight";
        } else {
          bmiCategory = "Obesity";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(_bmi),
        ),
        title: const Text('Edit BMI', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('Calculate BMI Level'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Set Weight',
                          suffixText: 'KG',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Set Height',
                          suffixText: 'CM',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _calculateBMI();
                        Navigator.of(context).pop(_bmi);
                      },
                      child: const Text('Calculate'),//Move to the end of arguments
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Edit BMI'),
        ),
      ),
    );
  }
}

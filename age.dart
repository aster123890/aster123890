import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _ageController = TextEditingController();
  bool _isAgeEntered = false;

  final Color logoBlue = const Color.fromARGB(255, 11, 69, 144);
  final Color gold = const Color(0xFFCD8032); // Gold color for the NEXT button.

  void _onAgeChanged() {
    setState(() {
      final age = int.tryParse(_ageController.text);
      _isAgeEntered = age != null && age >= 13 && age <= 99;
    });
  }

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_onAgeChanged);
  }

  @override
  void dispose() {
    _ageController.removeListener(_onAgeChanged);
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Logo at the Top Center
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image(
                    image:
                        const AssetImage('lib/images/intellislim_logo2_1.png'),
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                ),
              ),

              const SizedBox(height: 30), // Space between logo and question

              // Age Question
              const Text(
                'What’s your age?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                  height: 24), // Space between question and input field

              // Age Input Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Years',
                    border: const OutlineInputBorder(),
                    errorText:
                        (_ageController.text.isNotEmpty && !_isAgeEntered)
                            ? 'Please enter a valid age (13-99)'
                            : null,
                  ),
                ),
              ),

              const Spacer(), // Push the NEXT button to the bottom

              // NEXT Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _isAgeEntered
                      ? () {
                          Navigator.pushNamed(context, '/height');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold, // Gold color for the NEXT button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.3, // Responsive width
                      vertical: 18,
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30), // Space to avoid system bar overlap
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BiologicalScreen extends StatefulWidget {
  @override
  _BiologicalScreenState createState() => _BiologicalScreenState();
}

class _BiologicalScreenState extends State<BiologicalScreen> {
  String? _selectedGender;

  // Blue color from your specification.
  final Color logoBlue = const Color.fromARGB(255, 11, 69, 144);
  final Color gold = const Color(0xFFCD8032); // Gold color for the NEXT button.

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

              // Gender Selection Question
              const Text(
                'What’s your biological sex?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                  height: 24), // Space between question and gender buttons

              // Gender Selection Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genderButton('Male', isSelected: _selectedGender == 'Male'),
                  const SizedBox(width: 16),
                  genderButton('Female',
                      isSelected: _selectedGender == 'Female'),
                ],
              ),

              const Spacer(), // Push the NEXT button to the bottom

              // NEXT Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _selectedGender != null
                      ? () {
                          Navigator.pushNamed(context, '/age');
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

  Widget genderButton(String gender, {required bool isSelected}) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        backgroundColor:
            isSelected ? logoBlue : Colors.white, // Blue when selected
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      ),
      child: Text(
        gender,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

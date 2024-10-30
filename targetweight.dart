import 'package:flutter/material.dart';

class TargetWeightScreen extends StatefulWidget {
  @override
  _TargetWeightScreenState createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  final TextEditingController _targetWeightController = TextEditingController();
  bool _isTargetWeightEntered = false;

  final Color logoBlue = const Color.fromARGB(255, 11, 69, 144);
  final Color gold = const Color(0xFFCD8032); // Gold color for the NEXT button.

  void _onTargetWeightChanged() {
    setState(() {
      final targetWeight = int.tryParse(_targetWeightController.text);
      _isTargetWeightEntered =
          targetWeight != null && targetWeight >= 10 && targetWeight <= 300;
    });
  }

  @override
  void initState() {
    super.initState();
    _targetWeightController.addListener(_onTargetWeightChanged);
  }

  @override
  void dispose() {
    _targetWeightController.removeListener(_onTargetWeightChanged);
    _targetWeightController.dispose();
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

              // Target Weight Question
              const Text(
                'What’s your target weight?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                  height: 24), // Space between question and input field

              // Target Weight Input Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  controller: _targetWeightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'KG',
                    border: const OutlineInputBorder(),
                    errorText: (_targetWeightController.text.isNotEmpty &&
                            !_isTargetWeightEntered)
                        ? 'Please enter a valid target weight (10-300 kg)'
                        : null,
                  ),
                ),
              ),

              const Spacer(), // Push the NEXT button to the bottom

              // NEXT Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _isTargetWeightEntered
                      ? () {
                          Navigator.pushNamed(context, '/home');
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

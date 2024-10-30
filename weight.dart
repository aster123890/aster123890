import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final TextEditingController _weightController = TextEditingController();
  bool _isWeightEntered = false;

  final Color logoBlue = const Color.fromARGB(255, 11, 69, 144);
  final Color gold = const Color(0xFFCD8032); // Gold color for the NEXT button.

  void _onWeightChanged() {
    setState(() {
      final weight = int.tryParse(_weightController.text);
      _isWeightEntered = weight != null && weight >= 10 && weight <= 300;
    });
  }

  @override
  void initState() {
    super.initState();
    _weightController.addListener(_onWeightChanged);
  }

  @override
  void dispose() {
    _weightController.removeListener(_onWeightChanged);
    _weightController.dispose();
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

              // Weight Question
              const Text(
                'What’s your current weight?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                  height: 24), // Space between question and input field

              // Weight Input Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'KG',
                    border: const OutlineInputBorder(),
                    errorText:
                        (_weightController.text.isNotEmpty && !_isWeightEntered)
                            ? 'Please enter a valid weight (10-300 kg)'
                            : null,
                  ),
                ),
              ),

              const Spacer(), // Push the NEXT button to the bottom

              // NEXT Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _isWeightEntered
                      ? () {
                          Navigator.pushNamed(context, '/targetWeight');
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

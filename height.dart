import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final TextEditingController _heightController = TextEditingController();
  bool _isHeightEntered = false;

  final Color logoBlue = const Color.fromARGB(255, 11, 69, 144);
  final Color gold = const Color(0xFFCD8032); // Gold color for the NEXT button.

  void _onHeightChanged() {
    setState(() {
      final height = int.tryParse(_heightController.text);
      _isHeightEntered = height != null && height >= 100 && height <= 300;
    });
  }

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_onHeightChanged);
  }

  @override
  void dispose() {
    _heightController.removeListener(_onHeightChanged);
    _heightController.dispose();
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

              // Height Question
              const Text(
                'How tall are you?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                  height: 24), // Space between question and input field

              // Height Input Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'CM',
                    border: const OutlineInputBorder(),
                    errorText:
                        (_heightController.text.isNotEmpty && !_isHeightEntered)
                            ? 'Please enter a valid height (100-300 cm)'
                            : null,
                  ),
                ),
              ),

              const Spacer(), // Push the NEXT button to the bottom

              // NEXT Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _isHeightEntered
                      ? () {
                          Navigator.pushNamed(context, '/weight');
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

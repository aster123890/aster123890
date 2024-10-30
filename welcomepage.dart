import 'package:flutter/material.dart';
import 'package:intellislim_app/screens/signedin.dart';
import 'package:intellislim_app/components/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'lib/images/IntelliSlim_logo1.png',
                  height: 150,
                ),
              ),

              const SizedBox(height: 48),

              // Title
              const Text(
                'Just Do It',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 24),

              // Subtitle
              const Text(
                'Lets get healthy with IntelliSlim',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 200),

              // Start now button
              MyButton(
                text: 'Let\'s Get Started!',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignedIn(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

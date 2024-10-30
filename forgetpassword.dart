import 'package:flutter/material.dart';
import 'package:intellislim_app/components/buttons.dart';
import 'package:intellislim_app/components/textfield_username.dart';
import 'package:intellislim_app/screens/resetpass.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

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
                padding: const EdgeInsets.all(20.0),
                child: Image(
                  image: const AssetImage('lib/images/intellislim_logo2_1.png'),
                  height: MediaQuery.of(context).size.height * 0.24,
                ),
              ),
              const SizedBox(height: 5),

              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              const Text(
                'Please enter your username and the email used during registration to reset your password.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Username TextField
              LoginTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 15),

              // Email TextField
              LoginTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 30),

              // Submit Button
              MyButton(
                text: 'Submit',
                onPressed: () {
                  // Validate input fields
                  String username = usernameController.text.trim();
                  String email = emailController.text.trim();
                  String emailPattern = r'^[^@]+@[^@]+\.[^@]+';

                  // Check if fields are empty
                  if (username.isEmpty || email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please fill in all fields")),
                    );
                    return; // Exit the function if fields are empty
                  }

                  // Check if email is valid
                  if (!RegExp(emailPattern).hasMatch(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter a valid email")),
                    );
                    return; // Exit the function if email is invalid
                  }

                  // Simulate sending OTP via email
                  //Required API and db
                  print('Sending OTP to $email');

                  // Navigate to ResetPasswordPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Cancel Button
              MyButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

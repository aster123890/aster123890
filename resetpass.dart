import 'package:flutter/material.dart';
import 'package:intellislim_app/components/buttons.dart';
import 'package:intellislim_app/components/textfield_username.dart';
import 'package:intellislim_app/screens/signedin.dart';

class ResetPasswordPage extends StatelessWidget {
  // Text editing controllers for user input
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ResetPasswordPage({super.key});

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
              const SizedBox(height: 10),

              const Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // OTP TextField
              LoginTextField(
                controller: otpController,
                hintText: 'OTP',
                obscureText: false,
              ),
              const SizedBox(height: 15),

              // New Password TextField
              LoginTextField(
                controller: newPasswordController,
                hintText: 'New Password',
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // Confirm Password TextField
              LoginTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Instructional message
              const Text(
                'Enter the OTP you received via email and set a new password.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Submit Button
              MyButton(
                text: 'Submit',
                onPressed: () {
                  // Validate input fields
                  if (newPasswordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty ||
                      otpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please fill in all fields")),
                    );
                  } else if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    // Show success message on password reset
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Password Reset Successful'),
                        content: const Text(
                            'Your password has been reset successfully.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigate to Sign In Page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignedIn()),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Show error message if passwords do not match
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                  }
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

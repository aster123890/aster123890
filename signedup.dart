import 'package:flutter/material.dart';
import 'package:intellislim_app/components/textfield_username.dart';
import 'package:intellislim_app/components/buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Function to submit the form
  void _submitForm() {
    if (_passwordController.text == _confirmPasswordController.text) {
      // Normally here you would handle registration
      // No backend, so simulate success
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have signed up successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to HomePageScreen if successful
                Navigator.pushNamed(context, '/biological');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Show error if passwords do not match
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Password Mismatch'),
          content: const Text('The passwords do not match. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Image(
                    image:
                        const AssetImage('lib/images/intellislim_logo2_1.png'),
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                ),

                // Sign Up
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),

                // Email field
                LoginTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                // Username field
                LoginTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                // Password field
                LoginTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 5),

                // Password requirements in a single line
                const Text(
                  '• At least 8 characters • One uppercase letter • One number',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),

                // Confirm Password field
                LoginTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // Sign Up button
                MyButton(
                  text: 'Sign Up',
                  onPressed: _submitForm,
                ),
                const SizedBox(height: 20),

                // Already have an account? Sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to Sign In screen
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

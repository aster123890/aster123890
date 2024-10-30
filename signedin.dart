import 'package:flutter/material.dart';
import 'package:intellislim_app/components/buttons.dart';
import 'package:intellislim_app/components/icons_tile.dart';
import 'package:intellislim_app/components/textfield_username.dart';
import 'package:intellislim_app/screens/forgetpassword.dart';
import 'package:intellislim_app/screens/homepage.dart';
import 'package:intellislim_app/screens/signedup.dart';


class SignedIn extends StatelessWidget {
  SignedIn({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Logo
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image(
                  image: const AssetImage('lib/images/intellislim_logo2_1.png'),
                  height: MediaQuery.of(context).size.height * 0.24,
                ),
              ),

              // Welcome Text
              const Text(
                'Welcome Back to IntelliSlim.\nWe\'ve been missing you!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // Username text field
              LoginTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Password text field
              LoginTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Forgot Password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 227, 25, 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //sign in button
              MyButton(
                text: 'Sign In',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Google + Facebook icons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconsTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 10),
                  IconsTile(imagePath: 'lib/images/facebook2.png'),
                  SizedBox(width: 10),
                ],
              ),

              const SizedBox(height: 15),

              // Not a member? Register Now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    ),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

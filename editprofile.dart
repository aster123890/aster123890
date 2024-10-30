import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _phoneNumber = ''; // New field for phone number
  String _location = ''; // New field for location
  String _bio = ''; // New field for bio
  bool _isLoading = false; // To track the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username TextField
              _buildTextField(
                label: 'Username',
                initialValue: _username,
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Increased spacing

              // Email TextField
              _buildTextField(
                label: 'Email',
                initialValue: _email,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Increased spacing

              // Phone Number TextField
              _buildTextField(
                label: 'Phone Number',
                initialValue: _phoneNumber,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Increased spacing

              // Location TextField
              _buildTextField(
                label: 'Location',
                initialValue: _location,
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Increased spacing

              // Bio TextField
              _buildTextField(
                label: 'Bio',
                initialValue: _bio,
                onChanged: (value) {
                  setState(() {
                    _bio = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bio';
                  }
                  return null;
                },
                maxLines: 3, // Allow multiple lines for bio
              ),
              const SizedBox(height: 24),

              // Loading Indicator or Buttons
              _isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildElevatedButton(
                          label: 'Save Changes',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true; // Start loading
                              });

                              // Simulate a network call
                              Future.delayed(const Duration(seconds: 2), () {
                                // Show success message using a snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Profile updated successfully!")),
                                );

                                // Stop loading
                                setState(() {
                                  _isLoading = false;
                                });

                                Navigator.pop(
                                    context); // Go back to previous screen
                              });
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _username = '';
                              _email = '';
                              _phoneNumber = '';
                              _location = '';
                              _bio = '';
                            });
                          },
                          child: const Text(
                            'Clear Fields',
                            style: TextStyle(
                                color: Colors.red), // Color change for emphasis
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

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
    required String? Function(String?) validator,
    int? maxLines, // New parameter to set maximum lines for bio
  }) {
    return Card(
      elevation: 8, // Increased elevation for a bolder shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12), // Rounded corners for input field
          ),
          prefixIcon: const Icon(Icons.person), // Default icon
        ),
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines, // Apply maxLines
      ),
    );
  }

  Widget _buildElevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners for button
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 16), // Increased font size for readability
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:intellislim_app/screens/editprofile.dart';

class ProfilePage extends StatefulWidget {
  final String username; // Add username as a parameter

  const ProfilePage({super.key, required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // Image file for the profile picture
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  final String _userEmail = "user123@gmail.com"; // Placeholder for email
  final String _userBio =
      "This is a short bio about the user."; // Placeholder for bio
  final String _userPhone = "123-456-7890"; // Placeholder for phone number
  final String _userLocation = "City, Country"; // Placeholder for location

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Update the profile image
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/images/intelliSlim_logo2_1.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Center(
            child: Text('Profile', style: TextStyle(color: Colors.blue))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'editprofile':
                  Navigator.pushNamed(context, '/edit_profile');
                  break;
                case 'setreminder':
                  Navigator.pushNamed(context, '/setReminder');
                  break;
                case 'delete':
                  _showDeleteConfirmationDialog();
                  break;
                case 'logout':
                  _showLogoutConfirmationDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Edit Profile',
                'Set Reminder',
                'Delete Account',
                'Logout'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase().replaceAll(' ', ''),
                  child: Text(
                    choice,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 1, 18, 67),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _buildProfileBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/logpage');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Add padding for better layout
      child: Center(
        // Center the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const SizedBox(height: 20), // Add spacing from the top of the page

            // Display Profile Picture with Edit Icon at the top
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(
                            _profileImage!) // Display picked image if available
                        : const AssetImage(
                                'lib/images/IntelliSlim_logo1.png') // Set default icon
                            as ImageProvider,
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        color: Color.fromARGB(
                            255, 1, 18, 67), // Dark blue edit icon
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Display User Details with Icons
            _buildUserDetailRow(Icons.person, 'Name: ${widget.username}'),
            _buildUserDetailRow(Icons.email, 'Email: $_userEmail'),
            _buildUserDetailRow(Icons.phone, 'Phone: $_userPhone'),
            _buildUserDetailRow(Icons.location_on, 'Location: $_userLocation'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _userBio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the row
        children: [
          Icon(icon, color: const Color.fromARGB(255, 1, 18, 67)), // Icon
          const SizedBox(width: 10), // Spacing between icon and text
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 1, 18, 67),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Simulate logout action
                Navigator.of(context)
                    .pushReplacementNamed('/'); // Navigate to WelcomePage
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account Confirmation"),
          content: const Text("Are you sure you want to delete your account?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Simulate account deletion
                // Show success message using a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Your account has been successfully deleted."),
                  ),
                );

                // Close the dialog and navigate to the Welcome page after a delay
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushReplacementNamed(
                      '/welcome'); // Navigate to WelcomePage
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

// screens/set_reminder_screen.dart
import 'package:flutter/material.dart';

class SetReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.local_drink),
              title: const Text('Water Reminder'),
              subtitle: const Text('Set a water reminder'),
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Fasting Reminder'),
              subtitle: const Text('Set a fasting reminder'),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(Icons.directions_run),
              title: const Text('Workout Reminder'),
              subtitle: const Text('Set a workout reminder'),
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}

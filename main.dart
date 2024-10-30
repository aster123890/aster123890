import 'package:flutter/material.dart';
import 'package:intellislim_app/screens/age.dart';
import 'package:intellislim_app/screens/biological.dart';
import 'package:intellislim_app/screens/bmi.dart';
import 'package:intellislim_app/screens/diary.dart';
import 'package:intellislim_app/screens/editprofile.dart';
import 'package:intellislim_app/screens/fasting.dart';
import 'package:intellislim_app/screens/height.dart';
import 'package:intellislim_app/screens/homepage.dart';
import 'package:intellislim_app/screens/log.dart';
import 'package:intellislim_app/screens/pedometer.dart';
import 'package:intellislim_app/screens/profilepage.dart';
import 'package:intellislim_app/screens/reminder.dart';
import 'package:intellislim_app/screens/targetweight.dart';
import 'package:intellislim_app/screens/water.dart';
import 'package:intellislim_app/screens/weight.dart';
import 'screens/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliSlim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/biological': (context) => BiologicalScreen(),
        '/age': (context) => AgeScreen(),
        '/height': (context) => HeightScreen(),
        '/weight': (context) => WeightScreen(),
        '/targetWeight': (context) => TargetWeightScreen(),
        '/home': (context) => HomePage(),
        '/fasting': (context) => FastingScreen(),
        '/pedometer': (context) => PedometerPage(),
        '/waterIntake': (context) => WaterIntakeScreen(),
        '/editBMI': (context) => EditBMIScreen(),
        '/profile': (context) => const ProfilePage(username: "user123"),
        '/edit_profile': (context) => EditProfilePage(),
        '/logpage': (context) => LogsPage(),
        '/setReminder': (context) => SetReminderScreen(),
        '/writeDiary': (context) => DiaryPage(),
      },
    );
  }
}

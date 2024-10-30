import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FastingScreen extends StatefulWidget {
  @override
  _FastingScreenState createState() => _FastingScreenState();
}

class _FastingScreenState extends State<FastingScreen> {
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();
  bool _isTracking = false;

  void _startTracking() {
    setState(() {
      _startTime = DateTime.now();
      _isTracking = true;
    });
  }

  void _endTracking() {
    setState(() {
      _endTime = DateTime.now();
      _isTracking = false;
    });
  }

  Duration _calculateDuration() {
    if (_isTracking) {
      return DateTime.now().difference(_startTime);
    } else {
      return _endTime.difference(_startTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = _calculateDuration();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Track Your Fasting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: _isTracking
                              ? null
                              : duration.inSeconds / (24 * 60 * 60),
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.shade300,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'TIME',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isTracking ? null : _startTracking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isTracking ? _endTracking : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'End',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

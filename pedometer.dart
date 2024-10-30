import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:fl_chart/fl_chart.dart';

class PedometerPage extends StatefulWidget {
  @override
  _PedometerPageState createState() => _PedometerPageState();
}

class _PedometerPageState extends State<PedometerPage> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 1500;
  double _distance = 2.29; // Distance in kilometers
  double _calories = 103.48; // Estimated calories burned
  int _activeMinutes = 47; // Example active minutes
  final List<FlSpot> _stepData = [];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _initializePedometer();

    // Prepopulate step data with some sample data
    _stepData.addAll([
      FlSpot(0, 0), // Day 1
      FlSpot(1, 1500), // Day 2
      FlSpot(2, 3000), // Day 3
      FlSpot(3, 4500), // Day 4
      FlSpot(4, 6000), // Day 5
      FlSpot(5, 8000), // Day 6
      FlSpot(6, 10000), // Day 7
    ]);
  }

  void _initializePedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
      _distance = _calculateDistance(_steps);
      _calories = _calculateCalories(_steps);

      // Add new data points for graphing
      _index++;
      _stepData.add(FlSpot(_index.toDouble(), _steps.toDouble()));
    });
  }

  void onStepCountError(error) {
    print('Pedometer Error: $error');
  }

  double _calculateDistance(int steps) {
    return steps * 0.00078;
  }

  double _calculateCalories(int steps) {
    return steps * 0.04;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Step Tracker',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Rectangular step indicator
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity, // Full width
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Steps',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_steps',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Target: 10000 Steps',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _steps / 10000,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue, size: 30),
                    const SizedBox(height: 8),
                    Text('$_distance km',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.local_fire_department,
                        color: Colors.red, size: 30),
                    const SizedBox(height: 8),
                    Text('${_calories.toStringAsFixed(2)} kcal',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.orange, size: 30),
                    const SizedBox(height: 8),
                    Text('$_activeMinutes min',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Graph for steps over time
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Day ${value.toInt() + 1}',
                              style: const TextStyle(fontSize: 12));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}',
                              style: const TextStyle(fontSize: 12));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: _stepData
                      .map((data) => BarChartGroupData(
                            x: data.x.toInt(),
                            barRods: [
                              BarChartRodData(
                                toY: data.y,
                                color: Colors.orange,
                                width: 16,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LogsPage extends StatelessWidget {
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
            child: Text('Activity Log', style: TextStyle(color: Colors.blue))),
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
                case 'logout':
                  _showLogoutConfirmationDialog(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit Profile', 'Set Reminder', 'Logout'}
                  .map((String choice) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LogCard(
                title: 'Calories Burned (per day)',
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      for (int i = 0; i < 7; i++)
                        BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: (i + 4) * 10.0,
                              color:
                                  Colors.orangeAccent, // Lighten the bar color
                            ),
                          ],
                        ),
                    ],
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            return Text('Day ${value.toInt() + 1}',
                                style: const TextStyle(color: Colors.white));
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LogCard(
                title: 'Water Intake (per day)',
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            return Text('Day ${value.toInt() + 1}',
                                style: const TextStyle(color: Colors.white));
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int i = 0; i < 7; i++)
                            FlSpot(i.toDouble(), (i + 3) * 10.0),
                        ],
                        isCurved: false,
                        color: Colors
                            .lightBlueAccent, // Lighten the color to match the design
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LogCard(
                title: 'Total Fasts (per day)',
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            return Text('Day ${value.toInt() + 1}',
                                style: const TextStyle(color: Colors.white));
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int i = 0; i < 7; i++)
                            FlSpot(i.toDouble(), (i + 5) * 10.0),
                        ],
                        isCurved: false,
                        color: Colors
                            .lightBlueAccent, // Consistent lightened color scheme
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class LogCard extends StatelessWidget {
  final String title;
  final Widget child;

  const LogCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors
          .indigoAccent, // Lighten card background color for better contrast
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

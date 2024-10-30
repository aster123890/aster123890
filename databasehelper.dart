import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // Initialize your database settings
  final _settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '', // Ensure this matches your MySQL password
    db: 'intellislim_db',
  );

  // Method to get connection
  Future<MySqlConnection> getConnection() async {
    return await MySqlConnection.connect(_settings);
  }

  // Fetch user data by username
  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final conn = await getConnection();
    try {
      var results = await conn.query(
        'SELECT username, email FROM users WHERE username = ?',
        [username],
      );
      if (results.isNotEmpty) {
        var row = results.first;
        return {
          'username': row['username'],
          'email': row['email'],
        };
      }
    } catch (e) {
      print('Error fetching user data: $e'); // Log the error for debugging
    } finally {
      await conn.close();
    }
    return {};
  }
}

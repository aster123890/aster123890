<?php
$servername = "localhost";
$username = "root"; // Default username for XAMPP
$password = ""; // Default password for XAMPP
$dbname = "intellislim_db";

// Create connection with XAMPP
$conn = new mysqli($servername, $username, $password, $dbname);

// Check for the connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]);
    exit; // Stop execution if connection fails
}

// Get data from POST request
$user_email = isset($_POST['email']) ? $_POST['email'] : '';
$user_name = isset($_POST['username']) ? $_POST['username'] : '';
$user_password = isset($_POST['password']) ? $_POST['password'] : '';

// Simple SQL Injection prevention
$user_email = $conn->real_escape_string($user_email);
$user_name = $conn->real_escape_string($user_name);
$user_password = $conn->real_escape_string($user_password);

// Check if username or email already exists
$checkUserSql = "SELECT * FROM users WHERE username = '$user_name' OR email = '$user_email'";
$result = $conn->query($checkUserSql);
if ($result->num_rows > 0) {
    echo json_encode(["status" => "error", "message" => "Username or email already exists."]);
    exit; // Stop execution if user exists
}

// Hash the password for security
$hashed_password = password_hash($user_password, PASSWORD_DEFAULT);

// Insert user data into the database
$sql = "INSERT INTO users (username, email, password) VALUES ('$user_name', '$user_email', '$hashed_password')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "New record created successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . $sql . "<br>" . $conn->error]);
}

$conn->close();
?>

<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database credentials
$host = "localhost";  // Change if using a remote server
$user = "root";       // Default XAMPP MySQL username
$pass = "";           // Default XAMPP MySQL password (empty)
$db   = "poll";       // Your database name

// Create a connection using MySQLi
$conn = mysqli_connect($host, $user, $pass, $db);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
} else {
    echo "Database Connected Successfully!";
}
?>

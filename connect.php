<?php

//Connection details
$host = 'localhost';
$user = 'root';
$pass = '';
$dbms = 'comp3391_19012712';

// Create connection

$conn = mysqli_connect($host,$user,$pass,$dbms);

//Check connection if connection successful
if(!$conn)
{
	
	
//Display message if connection unsuccessful
die("Connection error: " . mysqli_connect_error ());
}

//Optional - display message if connection successful
//echo "Connected successfully";
?>
	

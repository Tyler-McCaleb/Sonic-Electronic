<!-- Contains user, host, and database settings for a connection to Xampp's MySQL server using default settings for Xampp root user. -->

<?php

$host       = "localhost";                   // Add the name of your local mysql server
$username   = "root";                        // Add the name of the user that has access to create databases on your server
$password   = "";                            // Enter the password for this user   
$dbname     = "SonicDB";
$dsn        = "mysql:host=$host;dbname=$dbname";
$options    = array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);


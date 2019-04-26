<?php


require "config.php";

try {
$connection = new PDO("mysql:host=$host", $username, $password, $options);
$sql = 'DROP DATABASE ' . $dbname;
$connection->exec($sql);

echo "Database and table users deleted successfully.";

} catch(PDOException $error){
    echo $sql . "<br>" . $error->getMessage();
}

?>

<?php include "templates/footer.php"; ?>
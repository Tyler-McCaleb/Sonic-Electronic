
<!-- Creates the database on the MySQL server based on the information stored in init.sql -->

<?php


require "config.php";

try {
$connection = new PDO("mysql:host=$host", $username, $password, $options);
$sql = file_get_contents("data\init.sql");
$connection->exec($sql);

echo "Database and table users created successfully.";

} catch(PDOException $error){
    echo $sql . "<br>" . $error->getMessage();
}
?>

<?php include "templates/footer.php"; ?>
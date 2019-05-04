
<!-- Destroys the database from the MySQL server -->

<?php include "templates/header.php"; ?>

<?php


require "config.php";

try {
$connection = new PDO("mysql:host=$host", $username, $password, $options);
$sql = 'DROP DATABASE IF EXISTS ' . $dbname;
$connection->exec($sql); ?>

<h1 align="center"><?php echo "$dbname and related tables were deleted successfully.";?></h1>

<?php } catch(PDOException $error){
    echo $sql . "<br>" . $error->getMessage();
}

?>

<div>
    <?php include "templates/footer.php"; ?>
</div>

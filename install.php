
<!-- Creates the database on the MySQL server based on the information stored in init.sql -->

<?php include "templates/header.php"; ?>

<?php


require "config.php";

try {
$connection = new PDO("mysql:host=$host", $username, $password, $options);
$sql = file_get_contents("data\init.sql");
$connection->exec($sql); ?>


<h1 align="center"><?php echo "$dbname and related tables were created successfully";?></h1>

<?php } catch(PDOException $error){
    echo $sql . "<br>" . $error->getMessage();
}
?>

<div>
    <?php include "templates/footer.php"; ?>
</div>


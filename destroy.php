
<!-- Destroys the database from the MySQL server -->

<?php


require "config.php";

try {
$connection = new PDO("mysql:host=$host", $username, $password, $options);
$sql = 'DROP DATABASE IF EXISTS ' . $dbname;
$connection->exec($sql);

echo "$dbname and related tables were deleted successfully.";

} catch(PDOException $error){
    echo $sql . "<br>" . $error->getMessage();
}

?>

<div>
    <?php include "templates/footer.php"; ?>
</div>

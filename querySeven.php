
<?php include "templates/header.php"; ?>

<?php

/*
  Generate the bill for each customer for the path month
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the querery
    $sql = "SELECT c.name, SUM(p.price)
    FROM customer NATURAL JOIN receives AS cr, package p, contents c
    WHERE (cr.package_id = p.package_id AND cr.package_id = c.package_id);"
            

    // Prepare the statement
    $statement = $connection->prepare($sql);
    $statement->bindParam(':location', $location, PDO::PARAM_STR); // bind :location in the query to the variable $location  (Just an example to show binding parameter, may not be needed in actual code)
    $statement->execute();    // execute the statement

    // save all the data from the statemet into the result
    $result = $statement->fetchAll();
      
} 

catch(PDOException $error)
{
    echo $sql . "<br>" . $error->getMessage();
}

?>


<?php include "templates/footer.php"; ?>



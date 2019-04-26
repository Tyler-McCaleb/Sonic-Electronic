
<?php include "templates/header.php"; ?>

<?php

/*
  Find those products that are out-of-stock at ever store in california
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the querery
    $sql = "SELECT 'desired information'
    FROM 'table name'
    WHERE 'conditions'"
            

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
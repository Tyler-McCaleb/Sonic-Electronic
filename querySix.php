
<?php include "templates/header.php"; ?>
<head>
   <link rel="stylesheet" href="css/style.css">
</head>


<?php

/*
  Find those packages that were not delivered with the promised time
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the querery
    $sql = "SELECT *
    FROM SonicDB.package;";
            
    // Prepare the statement
    $statement = $connection->prepare($sql);
    $statement->execute();    // execute the statement

    // save all the data from the statemet into the result
    $result = $statement->fetchAll();
      
} 

catch(PDOException $error)
{
    echo $sql . "<br>" . $error->getMessage();
}

?>

<!-- If there are results put them into a table -->
<?php
    if ($result && $statement->rowCount() > 0) { ?>
        <h2>Products that were not delivered on time</h2>
        <h3>Package Information</h3>
        <table id="resultTable">
            <tr>
                <th id="resultHeader">ID</th>
                <th id="resultheader">Price</th>
                <th id="resultHeader">Transaction #</th>
            </tr>
            <?php foreach ($result as $row) { ?>
                <tr>
                    <?php
                    $due = new DateTime(escape($row["due_date"]));
                    $received = new DateTime(escape($row["receive_date"]));                         
                    ?>
                    <?php if ($received > $due) { ?>
                    <td id="resultData"><?php echo escape($row["package_id"]); ?></td>
                    <td id="resultData"><?php echo escape($row["price"]); ?></td>
                    <td id="resultData"><?php echo escape($row["transaction_number"]); ?></td>
                    <?php } ?>
                </tr>
            <?php } ?>
        </table>
        <?php } else { ?>
            > No Packages were delivered after the due date.
        <?php } ?>

<?php include "templates/footer.php"; ?>



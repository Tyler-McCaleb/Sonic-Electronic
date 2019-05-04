
<?php include "templates/header.php"; ?>
<html>

</html>
<?php

/*
  Find those products that are out-of-stock at every store in california
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the querery
    $sql = "SELECT item_id, product_name, quantity, region
            FROM product NATURAL JOIN inventory
            WHERE quantity = 0 AND region = 'California'
            GROUP BY item_id
            ORDER BY item_id DESC";
            

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
    <h2 align="center">Products that are out of stock in California</h2>
    <h3 align="center">Product Information</h3>
    <table id="resultTable" align="center">
        <tr>
            <th id="resultHeader">ID</th>
            <th id="resultHeader">Name</th>
            <th id="resultHeader">Quantity</th>
            <th id="resultHeader">Region</th>
        </tr>
        <?php foreach ($result as $row) { ?>
        <tr>
            <td id="resultHeader"><?php echo escape($row["item_id"]); ?></td>
            <td id="resultHeader"><?php echo escape($row["product_name"]); ?></td>
            <td id="resultHeader"><?php echo escape($row["quantity"]); ?></td>
            <td id="resultHeader"><?php echo escape($row["region"]); ?></td>
        </tr>
        <?php } ?>
    </table>
    <?php } else { ?>
        There are no products out of stock in California.
<?php } ?>

<?php include "templates/footer.php"; ?>

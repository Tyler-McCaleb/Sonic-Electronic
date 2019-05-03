
<?php include "templates/header.php"; ?>

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
    $sql = "SELECT item_id, product_name, SUM(quantity), region
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
    <h2>Products that are out of stock in California</h2>
    <table>
    <thead>
    <tr>
    <th>Results:</th>
    </tr>
<   /thead>
    <tbody>
        <?php foreach ($result as $row) { ?>
        <tr>
        <?php
            $due = new DateTime(escape($row["due_date"]));
            $received = new DateTime(escape($row["receive_date"]));
            ?>
        <?php if ($received > $due) { ?>
        <td><?php echo escape($row["item_id"]); ?></td>
        <td><?php echo escape($row["product_name"]); ?></td>
        <td><?php echo escape($row["quantity"]); ?></td>
        <td><?php echo escape($row["region"]); ?></td>
        <?php } ?>
        </tr>
        <?php } ?>
    </tbody>
    </table>
    <?php } else { ?>
        There are no products out of stock in California.
<?php } ?>

<?php include "templates/footer.php"; ?>

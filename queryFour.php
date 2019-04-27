
<?php include "templates/header.php"; ?>

<?php

/*
  Find the top 2 products by unit sales in the past year
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the query
    $sql = "SELECT item_id, product_name, SUM(quantity)
    FROM product
    group by item_id
    ORDER BY SUM(quantity) desc
    LIMIT 2";


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
        <h2>Product ID's of the Top 2 Products Sold by Quantity:</h2>
        <table>
            <thead>
                <tr>
                    <th>Results:</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($result as $row) { ?>
                    <tr>
                        <td><?php echo escape($row["item_id"]); ?></td>
                        <td><?php echo escape($row["product_name"]); ?></td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
        <?php } else { ?>
            > No Items Found
        <?php } ?>


<?php include "templates/footer.php"; ?>
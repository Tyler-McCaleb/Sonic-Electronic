
<?php include "templates/header.php"; ?>

<?php

/*
    Assume the package shipped by USPS with tracking number 123456
    is reported to have been destroyed in an accident.  Find the contact information
    for the customer.  Also, find the contents of that shipment and create a new shipment
    of replacement items.
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the query
    $sql = "SELECT item_id, product_name, sum(quantity*price)
    FROM product
    GROUP BY item_id
    ORDER BY SUM(quantity * price) desc
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



<?php
    if ($result && $statement->rowCount() > 0) { ?>
        <h2>Product ID's of the Top 2 Products Sold by Dollar Amount:</h2>
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
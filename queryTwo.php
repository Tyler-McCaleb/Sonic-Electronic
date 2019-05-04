
<?php include "templates/header.php"; ?>


<?php

/*
  Find the customer who has bought the most (by price) in the past year.
*/

try 
{
    require "config.php";
    require "common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the query
    $sql = "SELECT customer_name
    FROM customer, package
    ORDER BY price desc
    LIMIT 1";
            

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
        <h2>Customer with the Highest Amount Spent</h2>
        <table>
            <thead>
                <tr>
                    <th>Customer Name</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($result as $row) { ?>
                    <tr>
                        <td><?php echo escape($row["customer_name"]); ?></td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
        <?php } else { ?>
            > No Customer Found
        <?php } ?>


<?php include "templates/footer.php"; ?>

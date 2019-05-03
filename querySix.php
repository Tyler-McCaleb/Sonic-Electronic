
<?php include "templates/header.php"; ?>

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
        <table>
            <thead>
                <tr>
                    <th>Results:</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($result as $row) { ?>
                    <tr>
                        <?php
                        $due = new DateTime(escape($row["due_date"]));
                        $received = new DateTime(escape($row["received_date"]));                         
                        ?>
                        <?php if ($received > $due) { ?>
                        <td><?php echo escape($row["package_id"]); ?></td>
                        <td><?php echo escape($row["price"]); ?></td>
                        <td><?php echo escape($row["transaction_number"]); ?></td>
                        <?php } ?>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
        <?php } else { ?>
            > No Packages were delivered after the due date.
        <?php } ?>

<?php include "templates/footer.php"; ?>



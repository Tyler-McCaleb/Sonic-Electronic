
<?php include "templates/header.php"; ?>



<!--
    Assume the package shipped by USPS with tracking number 123456
    is reported to have been destroyed in an accident.  Find the contact information
    for the customer.  Also, find the contents of that shipment and create a new shipment of replacement items.
-->

<html>
<h2>Replace Destroyed Package</h2>

</html>

<?php

    require "config.php";
    require "common.php";

try 
{

    if (isset($_POST['submit']))
    { 
        // Set up connection
        $connection = new PDO($dsn, $username, $password, $options);

        // create the query
        $sql_email = "SELECT email
        FROM receives
        WHERE (package_id = ".$_POST["package_id"];
        $sql_email = $sql_email.");";

        // Prepare the statement
        $statement = $connection->prepare($sql_email);
        $statement->execute();    // execute the statement

        // save all the data from the statemet into the result
        $email_result = $statement->fetchAll();
        
        // Get the customer infomration
        $sql_customerinfo = "SELECT *
        FROM customer
        WHERE (email = '";
        foreach ($email_result as $row)
        {
            $sql_customerinfo = $sql_customerinfo.escape($row["email"]);
        }
        $sql_customerinfo = $sql_customerinfo."');";
        $statement = $connection->prepare($sql_customerinfo);
        $statement->execute();
        $customer = $statement->fetchAll();
        
        // Get Package Information
        $sql_packageinfo = "SELECT *
        FROM package
        WHERE package_id = ".$_POST["package_id"].";";
        $statement = $connection->prepare($sql_packageinfo);
        $statement->execute();
        $old_package = $statement->fetchAll();
        
        foreach($old_package as $row)
        {
            $transaction = escape($row["transaction_number"]);
        }
        
        // Create the new package 
        $sql_newPackage = "INSERT INTO SONICDB.package (price, transaction_number, receive_date, due_date)
        VALUES (";
        foreach ($old_package as $row)
        {
            $sql_newPackage = $sql_newPackage.escape($row["price"]);
            $sql_newPackage = $sql_newPackage.", ";
            $sql_newPackage = $sql_newPackage.escape($row["transaction_number"]);
            $sql_newPackage = $sql_newPackage.", '";
            $sql_newPackage = $sql_newPackage.escape($row["receive_date"]);
            $sql_newPackage = $sql_newPackage."', '";
            $sql_newPackage = $sql_newPackage.escape($row["due_date"]);
        }
        $sql_newPackage = $sql_newPackage."');";
        $statement = $connection->prepare($sql_newPackage);
        $statement->execute();
        
        
        //*************************** WORKING ****************************
        
        // Delete the relation between the old package and the customer
        $sql_deleteReceives = "DELETE FROM SonicDB.receives
        WHERE (package_id = ";
        foreach($old_package as $row)
        {
            $sql_deleteReceives = $sql_deleteReceives.escape($row["package_id"]);    
        }
        $sql_deleteReceives = $sql_deleteReceives.");";
        $statement = $connection->prepare($sql_deleteReceives);
        $statement->execute(); 

        
        // Delete the lost package
        $sql_deletePackage = "DELETE FROM SonicDB.package
        WHERE (package_id = ";
        foreach ($old_package as $row)
        {
            $sql_deletePackage = $sql_deletePackage.escape($row['package_id']);
        }
        $sql_deletePackage = $sql_deletePackage.");";
        $statement = $connection->prepare($sql_deletePackage);
        $statement->execute();
        
        
        // Create the receives to tie the new package to the customer
        $sql_packageID = "SELECT *
        FROM package 
        WHERE transaction_number = $transaction;";
        $statement = $connection->prepare($sql_packageID);
        $statement->execute();
        $ID_result = $statement->fetchAll();
        
        $sql_newReceives = "INSERT INTO SonicDB.receives (package_id, email)
        VALUES (";
        foreach ($ID_result as $row)
        {
            $sql_newReceives = $sql_newReceives.(escape($row["package_id"]));
            $sql_newReceives = $sql_newReceives.", '";
        }
        foreach($email_result as $row)
        {
            $sql_newReceives = $sql_newReceives.escape($row["email"]);
        }
            
        $sql_newReceives = $sql_newReceives."');";
        $statement = $connection->prepare($sql_newReceives);
        $statement->execute();
        
        
        // Get the information of the new package
        $sql_newPackage = "SELECT *
        FROM package
        WHERE (transaction_number = ";
        foreach ($old_package as $row)
        {
            $sql_newPackage = $sql_newPackage.escape($row["transaction_number"]);
        }
        $sql_newPackage = $sql_newPackage.");";
        $statement = $connection->prepare($sql_newPackage);
        $statement->execute();
        $new_package = $statement->fetchAll();
        
        // Display The Old and New Information
        if ($customer && $statement->rowCount() > 0) 
        { ?>
            <table>
                <thead>
                    <tr>
                        <th>Customer Information</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($customer as $row) { ?>
                    <tr>
                        <td><?php echo escape($row["customer_name"]); ?></td>
                        <td><?php echo escape($row["customer_address"]); ?></td>
                        <td><?php echo escape($row["email"]); ?></td>
                        <td><?php echo escape($row["phone"]); ?></td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>

            <table>
                <thead>
                    <tr>
                        <th>Original Package Information</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($old_package as $row) { ?>
                    <tr>
                        <td><?php echo escape($row["package_id"]); ?></td>
                        <td><?php echo escape($row["price"]); ?></td>
                        <td><?php echo escape($row["transaction_number"]); ?></td>
                        <td><?php echo escape($row["receive_date"]); ?></td>
                        <td><?php echo escape($row["due_date"]); ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>

            <table>
                <thead>
                    <tr>
                        <th>New Package Information</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($new_package as $row) { ?>
                    <tr>
                        <td><?php echo escape($row["package_id"]); ?></td>
                        <td><?php echo escape($row["price"]); ?></td>
                        <td><?php echo escape($row["transaction_number"]); ?></td>
                        <td><?php echo escape($row["receive_date"]); ?></td>
                        <td><?php echo escape($row["due_date"]); ?></td>
                     </tr>
                    <?php } ?>
                </tbody>
            </table>

        <?php } ?> 

        <!-- Display all of the package id's inside of the database for reference -->
<?php } else { ?>
        
        
        <form method="post">
	    <label for="package_id">Destroyed Package ID Number</label>
            <input type="text" name="package_id" id="package_id">

    	    <input type="submit" name="submit" value="Submit">
        </form>

<?php
        // Set up connection
        $connection = new PDO($dsn, $username, $password, $options);
        
        // Create the statement to select all of the package_ids
        $sql_packages = "SELECT package_id FROM receives;";
        $statement = $connection->prepare($sql_packages);
        $statement->execute();
        $result = $statement->fetchAll();
?>

        <!-- Display all of the packages -->
        <table>
            <thead>
                <tr>
                    <th>Package ID's</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($result as $row){ ?>
                    <tr>
                        <td><?php echo escape($row["package_id"]); ?></td>
                    </tr>
                <?php } ?>
            </tbody>
        </table> 
<?php } ?>


<?php } catch(PDOException $error) {
            
           echo $sql . "<br>" . $error->getMessage();
        } ?>

<?php include "templates/footer.php"; ?>
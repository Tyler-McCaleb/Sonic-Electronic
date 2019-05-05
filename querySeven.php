
<?php include "templates/header.php"; ?>
<head>
   <link rel="stylesheet" href="css/style.css">
</head>
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
    $sql_email_price = "SELECT r.email, price
    FROM package p, receives r
    WHERE (p.package_id = r.package_id);";        

    // Prepare the statement
    $statement = $connection->prepare($sql_email_price);
    $statement->execute();    // execute the statement
    $email_price_result = $statement->fetchAll();
      
} 

catch(PDOException $error)
{
    echo $sql . "<br>" . $error->getMessage();
}

    if($email_price_result && $statement->rowCount() >0) { ?>
    <h2 align="center">Customer Bills</h2>
    <h3 align="center">Bill Information</h3>
    <table id="resultTable" align="center">
        <tr>
            <th id ="resultHeader">Account ID</th>
            <th id="resultHeader">Bill Amount</th>
        </tr>
        <?php foreach ($email_price_result as $row) { ?>
        <tr>
            <td id="resultHeader"><?php echo escape($row["email"]); ?></td>
            <td id="resultHeader"><?php echo escape($row["price"]); ?></td>
        </tr>
        <?php } ?>
    </table>
<?php } ?>

<?php include "templates/footer.php"; ?>



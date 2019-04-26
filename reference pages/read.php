<?php

/**
  * Function to query information based on
  * a parameter: in this case, location.
  *
  */

if (isset($_POST['submit'])) {
  try {
    require "C:\Sonic Electronic/xamp\htdocs\SEdatabase/config.php";
    require "C:\Sonic Electronic/xamp\htdocs\SEdatabase\common.php";
  
    // Set up connection
    $connection = new PDO($dsn, $username, $password, $options);

    // create the querery
    $sql = "SELECT *
    FROM users
    WHERE location = :location";

    // Create a variable to capture the string entered into the form field with id = location
    $location = $_POST['location'];

    // Prepare the statement
    $statement = $connection->prepare($sql);
    $statement->bindParam(':location', $location, PDO::PARAM_STR); // bind :location in the query to the variable $location
    $statement->execute();    // execute the statement

    // save all the data from the statemet into the result
    $result = $statement->fetchAll();
  } catch(PDOException $error) {
    echo $sql . "<br>" . $error->getMessage();
  }
}
?>
<?php require "templates/header.php"; ?>

<?php
if (isset($_POST['submit'])) {
  if ($result && $statement->rowCount() > 0) { ?>
    <h2>Results</h2>

   <table>
      <thead>
<tr>
  <th>#</th>
  <th>First Name</th>
  <th>Last Name</th>
  <th>Email Address</th>
  <th>Age</th>
  <th>Location</th>
  <th>Date</th>
</tr>
      </thead>
      <tbody>
  <?php foreach ($result as $row) { ?>
      <tr>
<td><?php echo escape($row["id"]); ?></td>
<td><?php echo escape($row["firstname"]); ?></td>
<td><?php echo escape($row["lastname"]); ?></td>
<td><?php echo escape($row["email"]); ?></td>
<td><?php echo escape($row["age"]); ?></td>
<td><?php echo escape($row["location"]); ?></td>
<td><?php echo escape($row["date"]); ?> </td>
      </tr>
    <?php } ?>
      </tbody>
  </table>
  <?php } else { ?>
    > No results found for <?php echo escape($_POST['location']); ?>.
  <?php }
} ?>


<!-- Start the HTML -->
<h2>Find user based on location</h2>

<form method="post">
  <label for="location">Location</label>
  <input type="text" id="location" name="location">
  <input type="submit" name="submit" value="View Results">
</form>

<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>
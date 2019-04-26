
<?php
// If statemen that contains the sql statements (only runs when the 'submit' button is pressed)
if (isset($_POST['submit'])) {
  require "C:\Sonic Electronic/xamp\htdocs\SEdatabase\config.php";
  require "C:\Sonic Electronic/xamp\htdocs\SEdatabase\common.php";

  try {
    $connection = new PDO($dsn, $username, $password, $options);  // Sets up connection

    // Creates the values to be inserted by posting the information written in the corresponding fields
    $new_user = array(
      "firstname" => $_POST['firstname'],
      "lastname"  => $_POST['lastname'],
      "email"     => $_POST['email'],
      "age"       => $_POST['age'],
      "location"  => $_POST['location'],
      "id"        => $_POST['id']
    );

    /*
       Creates the MySQL command.
        (implode(X, Y) creates a string with all the items int the array (Y parameter) seperated by whatever
         character is placed in the X parameter)
    */
    $sql = sprintf("INSERT INTO %s (%s) values (%s)","users", implode(", ", array_keys($new_user)),
    ":" . implode(", :", array_keys($new_user))
    );

    // Prepares the sql statement that is to be sent to the connected databse
    $statement = $connection->prepare($sql);

    // Executes the sql statement
    $statement->execute($new_user);

  } catch(PDOException $error) {
    echo $sql . "<br>" . $error->getMessage();
  }

}
?>

<?php require "templates/header.php"; ?>

<!-- Prints a success statement when the sql commands executes corrently -->
<?php if (isset($_POST['submit']) && $statement) { ?>
  > <?php echo $_POST['firstname']; ?> successfully added.
<?php } ?>

<!-- A form using the post method to enter data -->
<h2>Add a user</h2>
    <form method="post">
    	<label for="firstname">First Name</label>
    	<input type="text" name="firstname" id="firstname">
    	<label for="lastname">Last Name</label>
    	<input type="text" name="lastname" id="lastname">
    	<label for="email">Email Address</label>
    	<input type="text" name="email" id="email">
    	<label for="age">Age</label>
    	<input type="text" name="age" id="age">
    	<label for="location">Location</label>
    	<input type="text" name="location" id="location">
        <label for="id">ID</label>
    	<input type="text" name="id" id="id">

    	<input type="submit" name="submit" value="Submit">
    </form>

    <a href="index.php">Back to home</a>

    <?php include "templates/footer.php"; ?>
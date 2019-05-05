# Sonic Electronic
## Database project for CSC 411, DBMS Design
### Creates a database for a mock electronics company and executes sample queries on it.
#### Created by Tyler McCaleb, Ian Phillips, and Zachary Torricelli

# Setup and Configuration
Step 1. Download the XAMPP MySQL server. XAMPP download link: https://www.apachefriends.org/index.html

Step 2. Download and unzip the Sonic-Electronic-master file folder

Step 3. Navigate to you installed xampp and find the xampp folder

Step 4. Open the xampp folder then look for the htdocs folder

Step 5. Place the Sonic-Electronic-master folder in the htdocs folder

Step 6. Run XAMPP and turn on the MySQL and Apache servers

Step 7. Open a web browser. Place this link in the address bar: localhost/Sonic-Electronic-master/index.php

Step 8. If all was setup correctly, you should see the Sonic Electronic home page

Step 9. Scroll down and select Create Database

Step 10. After creation, run all the queries to test by selecting the Query # you would like 

# Sample Queries
1. SELECT email
        FROM receives
        WHERE (package_id = ".$_POST["package_id"];
        $sql_email = $sql_email.");

2. SELECT customer_name
    FROM customer, package
    ORDER BY price desc
    LIMIT 1";

3. SELECT item_id, product_name, sum(quantity*price) as total
    FROM product
    GROUP BY item_id
    ORDER BY total desc
    LIMIT 2";

4. SELECT item_id, product_name, SUM(quantity) as total
    FROM product
    group by item_id
    ORDER BY total desc
    LIMIT 2";

5. SELECT item_id, product_name, quantity, region
            FROM product NATURAL JOIN inventory
            WHERE quantity = 0 AND region = 'California'
            GROUP BY item_id
            ORDER BY item_id DESC";

6. SELECT *
    FROM SonicDB.package;";

7. SELECT r.email, price
    FROM package p, receives r
    WHERE (p.package_id = r.package_id);";

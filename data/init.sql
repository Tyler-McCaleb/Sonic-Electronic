/* Create the database */
CREATE DATABASE IF NOT EXISTS SonicDB;

  /* Using the database start creating tables */
  use SonicDB;

  CREATE TABLE SonicDB.manufacturer (
    manufacturer_id     INT(5) NOT NULL,
    manufacturer_name   VARCHAR(30),
    sales               VARCHAR(30),
    PRIMARY KEY (manufacturer_id)
  );

  CREATE TABLE SonicDB.shipper(
    transaction_number  INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    PRIMARY KEY (transaction_number)
  );

  CREATE TABLE SonicDB.product(
    manufacturer_id     INT(5) NOT NULL,
    item_id             INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    price               DECIMAL(5,2),
    product_name        VARCHAR(30),
    PRIMARY KEY (item_id)
  );

  CREATE TABLE SonicDB.package(
    package_id          INT(6) NOT NULL,
    price               DECIMAL(5,2),
    transaction_number  INT(5) NOT NULL,
    email               VARCHAR(30),
    PRIMARY KEY (package_id)
  );

  CREATE TABLE SonicDB.customer(
    email             VARCHAR(30) NOT NULL,
    customer_name     VARCHAR(30),
    customer_address  VARCHAR(30),
    phone             BIGINT,
    package_id        INT(5),
    PRIMARY KEY (email)
  );

  CREATE TABLE SonicDB.inventory(
    store_number      INT(5) NOT NULL,
    product_category  VARCHAR(30),
    season            VARCHAR(30),
    region            VARCHAR(30),
    PRIMARY KEY (store_number)
  );



  /********************************** RELATIONAL TABLES ********************/
  CREATE TABLE SonicDB.stocks(
    manufacturer_id       INT(5) NOT NULL,
    transaction_number    INT(5) NOT NULL,
    PRIMARY KEY (manufacturer_id, transaction_number),
    FOREIGN KEY (manufacturer_id) REFERENCES SonicDB.manufacturer(manufacturer_id),
    FOREIGN KEY (transaction_number) REFERENCES SonicDB.shipper(transaction_number)
  );

  CREATE TABLE SonicDB.ships(
    transaction_number  INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    PRIMARY KEY (transaction_number, package_id),
    FOREIGN KEY (transaction_number) REFERENCES SonicDB.shipper (transaction_number),
    FOREIGN KEY (package_id) REFERENCES SonicDB.package (package_id)
  );

  CREATE TABLE SonicDB.tracks(
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (manufacturer_id)
  );

  CREATE TABLE SonicDB.reorders(
    package_id          INT(5) NOT NULL,
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (package_id, manufacturer_id),
    FOREIGN KEY (package_id) REFERENCES SonicDB.package (package_id),
    FOREIGN KEY (manufacturer_id) REFERENCES SonicDB.manufacturer (manufacturer_id)
  );

  CREATE TABLE SonicDB.contents(
    package_id          INT(5) NOT NULL,
    item_id             INT(5) NOT NULL,
    PRIMARY KEY (package_id, item_id),
    FOREIGN KEY (package_id) REFERENCES SonicDB.package (package_id),
    FOREIGN KEY (item_id) REFERENCES SonicDB.product (item_id)
  );
  
  CREATE TABLE SonicDB.receives(
    package_id          INT(5) NOT NULL,
    email               VARCHAR(30) NOT NULL,
    PRIMARY KEY (package_id, email),
    FOREIGN KEY (package_id) REFERENCES SonicDB.package (package_id),
    FOREIGN KEY (email) REFERENCES SonicDB.customer(email)
  );
  
  /***** ADD INFORMATION TO THE DATABASE (Just test data currently) **************/
  /* Customers */
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('Jane@gmail.com', 'Jane Smith', 'Howard Avenue', 2283458907);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('Jill@gmail.com', 'Jill Smith', 'Sixth Avenue', 2263647519);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('Jennifer@gmail.com', 'Jennifer Smith', 'Seventh Avenue', 2263841964);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('Jaz@gmail.com', 'Jaz Smith', 'Eight Avenue', 2541087634);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('Martricia@gmail.com', 'Marty Rice', 'Twelve Street', 2541568734);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('gurlwashyourface@gmail.com', 'Dana Moore', 'Maury Street', 2723087634);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('monicabranica@gmail.com', 'Brah Monica', 'Sicko Mode Row', 2543768734);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('chaching@gmail.com', 'Will Smith', 'Belair Avenue', 2544095634);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('georgie@gmail.com', 'Will Float', 'Baker Street', 2543687634);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('juniper@gmail.com', 'June Smith', '60 Avenue', 2541098764);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('jacethe@gmail.com', 'Mind Sculptor', 'Plane Street', 2534267634);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('johnnie@gmail.com', 'Johnnie Blake', 'Camp Avenue', 2576890634);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('marysue@gmail.com', 'Mary Scul', 'Place Street', 2534245034);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('corben@gmail.com', 'La Venue', 'Drop Street', 2523456634);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('syrio@gmail.com', 'Syrio Forel', 'Not Today Road', 2534765034);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('fenky@gmail.com', 'Fen Key', 'Row Row Row', 2534560634);

  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('future@gmail.com', 'Marty Moore', 'Plane Place', 2534098734);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('betsoff@gmail.com', 'Anne Bet', 'Hello Road', 2513567634);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('hope@gmail.com', 'Chastity Hope', 'Jesus Street', 2555557634);
  
  INSERT INTO SonicDB.customer(email, customer_name, customer_address, phone)
  VALUES ('supdawg@gmail.com', 'What Is', 'Change Street', 2511267634);
  
  /* Manufacturer's */

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10001, 'Sony', 'Everything Pretty Much');
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10002, 'Microsoft', 'Operating Systems');
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10003, 'Dell', "Stuff Installed you no need");
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10004, 'Acer', 'It is kinda alright');
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10001, 'Trio', 'Home Entertainment');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10001, 'Flicker', 'Cameras');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10001, 'Journey', 'Health Monitors');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (15551, 'Super', 'Jetpacks');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (13331, 'Jeanius', 'Smart Jeans');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (18901, 'Armor ON', 'Conductive Workout Shirts');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (15601, 'Sixi', 'Digital Pen');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (15501, 'Jira', 'Computer Protection');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES 12001, 'Borkio', 'Woofy Robo Dog');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10033, 'Minos', 'Labyrinth Simulator');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10022, 'Lexicon', 'Map Interface');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (18001, 'Brony', 'Digital Horse Companions');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10201, 'Geneus', 'Smart Glasses');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10011, 'Asio', 'Telescopes');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10051, 'Lexio', 'Keyboards');

  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (11000, 'Apple', 'Ipods');
  /*Products*/
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10001, 20001, 30001, 100000, 100.00, 'Television');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10002, 20002, 30002, 5, 100.00, 'Ipad');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10003, 20003, 30003, 4, 400.00, 'Personal Computer');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10004, 20004, 30004, 3, 300.00, 'USB Cable');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10005, 20005, 30005, 2, 200.00, 'Speaker');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10006, 20006, 30006, 1, 100.00, 'Keyboard');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (13637, 23637, 33607, 36, 36.00, 'Smart Watch');
  
  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (14247, 22427, 32427, 20, 200.00, 'SSD');
  
    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (15407, 25407, 35407, 54, 54.00, 'RAM');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (11307, 13007, 31207, 12, 120.00, 'GPS');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (19897, 29897, 39897, 8, 80.00, 'Mousepad');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (19997, 29997, 39997, 9, 90.00, 'Gaming Mouse');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10078, 20078, 30067, 5, 700.00, 'Rocket Skateboard');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10022, 20022, 32207, 2, 10000.00, 'Moon Boots');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10607, 26007, 30607, 6, 660.00, 'Cyborg');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10907, 20067, 30337, 30, 100.00, 'Speakers');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10111, 11107, 11107, 50, 50.00, 'Monitor');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10567, 20890, 30456, 10, 345.00, 'Robo Dog');

    INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10333, 20456, 32207, 45, 10.00, 'Glasses');

  INSERT INTO SonicDB.product(manufacturer_id, item_id, package_id, quantity, price, product_name)
  VALUES (10045, 32307, 30337, 25, 6000.00, 'Telescope');
  /**************** Testing **************************/
  /* Packages */
  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123456, 400.00, 40001, 2019-05-12, 2019-04-12);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, recieve_date, due_date)
  VALUES (123457, 500.00, 40002, 2019-05-13, 2019-04-13);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123458, 600.00, 40003, 2019-05-14, 2019-04-14);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123459, 700.00, 40004, 2019-05-15, 2019-04-15);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123460, 800.00, 40005, 2019-05-16, 2019-04-16);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123461, 900.00, 40006, 2019-05-17, 2019-04-17);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123462, 1000.00, 40007, 2019-05-18, 2019-04-18);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123463, 1100.00, 40008, 2019-05-19, 2019-04-19);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123464, 1200.00, 40009, 2019-05-20, 2019-04-20);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123465, 1300.00, 40010, 2019-05-21, 2019-04-21);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123466, 1400.00, 40011, 2019-05-22, 2019-04-22);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123467, 1500.00, 40012, 2019-05-22, 2019-06-22);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123468, 1600.00, 40013, 2019-05-23, 2019-06-23);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123469, 1700.00, 40014, 2019-05-24, 2019-06-24);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123470, 1800.00, 40015, 2019-05-25, 2019-06-25);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123471, 1900.00, 40016, 2019-05-26, 2019-06-26);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123472, 2000.00, 40017, 2019-05-27, 2019-06-27);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123473, 2100.00, 40018, 2019-05-28, 2019-06-28);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123474, 2200.00, 40019, 2019-05-29, 2019-06-29);

  INSERT INTO SonicDB.package (package_id, price, transaction_number, receive_date, due_date)
  VALUES (123475, 2300.00, 40020, 2019-05-30, 2019-06-30);
  



  /* Receives */
  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123456, 'Jane@gmail.com');
  
  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123457, 'Jill@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123458, 'Jennifer@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123459, 'Jaz@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123460, 'Martricia@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123461, 'gurlwashyourface@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123462, 'Monicabranica@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123463, 'chaching@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123464, 'georgie@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123465, 'juniper@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123466, 'jacethe@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123467, 'johnnie@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123468, 'marysue@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123469, 'corben@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123470, 'syrio@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123471, 'fenky@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123472, 'future@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123473, 'betsoff@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123474, 'hope@gmail.com');

  INSERT INTO SonicDB.receives (package_id, email)
  VALUES (123475, 'supdawg@gmail.com');
  


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
    PRIMARY KEY (package_id)
  );

  CREATE TABLE SonicDB.customer(
    email             VARCHAR(30) NOT NULL,
    customer_name     VARCHAR(30),
    customer_address  VARCHAR(30),
    phone             INT(10),
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
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id),
    FOREIGN KEY (transaction_number) REFERENCES shipper(transaction_number)
  );

  CREATE TABLE SonicDB.ships(
    transaction_number  INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    PRIMARY KEY (transaction_number, package_id),
    FOREIGN KEY (transaction_number) REFERENCES shipper (transaction_number),
    FOREIGN KEY (package_id) REFERENCES package (package_id)
  );

  CREATE TABLE SonicDB.tracks(
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (manufacturer_id)
  );

  CREATE TABLE SonicDB.reorders(
    package_id          INT(5) NOT NULL,
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (package_id, manufacturer_id),
    FOREIGN KEY (package_id) REFERENCES package (package_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (manufacturer_id)
  );

  CREATE TABLE SonicDB.contents(
    package_id          INT(5) NOT NULL,
    item_id             INT(5) NOT NULL,
    PRIMARY KEY (package_id, item_id),
    FOREIGN KEY (package_id) REFERENCES package (package_id),
    FOREIGN KEY (item_id) REFERENCES product (item_id)
  );
  
  CREATE TABLE SonicDB.receives(
    package_id          INT(5) NOT NULL,
    email               VARCHAR(30) NOT NULL,
    PRIMARY KEY (package_id, email),
    FOREIGN KEY (package_id) REFERENCES package (package_id),
    FOREIGN KEY (email) REFERENCES customer(email)
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
  
  /* Manufacturer's */
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10001, 'Sony', 'Everything Pretty Much');
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10002, 'Microsoft', 'Operating Systems');
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10003, 'Dell', "Stuff Installed you no need");
  
  INSERT INTO SonicDB.manufacturer(manufacturer_id, manufacturer_name, sales)
  VALUES (10004, 'Acer', 'It is kinda alright');
  
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
  VALUES (10007, 20007, 30007, 0, 600.00, 'Headset');
  
  /* Packages */
  INSERT INTO SonicDB.package (package_id, price, transaction_number)
  VALUES (123456, 400.00, 40001);
  


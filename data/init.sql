/* Create the database */
CREATE DATABASE IF NOT EXISTS SonicDB;

  /* Using the database start creating tables */
  use SonicDB;

  CREATE TABLE SonicDB.manufacturer (
    manufacturer_id      INT(5) NOT NULL AUTO_INCREMENT,
    manufacturer_name   VARCHAR(30),
    sales               VARCHAR(30),
    PRIMARY KEY (manufacturer_id)
  );

  CREATE TABLE SonicDB.shipper(
    transaction_number  INT(5) NOT NULL AUTO_INCREMENT,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    PRIMARY KEY (transaction_number)
  );

  CREATE TABLE SonicDB.product(
    manufacturer_id     INT(5) NOT NULL,
    item_id             INT(5) NOT NULL AUTO_INCREMENT,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    price               DECIMAL(5,2),
    PRIMARY KEY (item_id)
  );

  CREATE TABLE SonicDB.package(
    package_id        INT(5) NOT NULL AUTO_INCREMENT,
    price             DECIMAL(5,2),
    transaction_id    INT(5) NOT NULL,
    PRIMARY KEY (package_id)
  );

  CREATE TABLE SonicDB.customer(
    email             VARCHAR(30),
    customer_name     VARCHAR(30),
    customer_address  VARCHAR(30),
    phone             INT(10),
    PRIMARY KEY (email)
  );

  CREATE TABLE SonicDB.inventory(
    store_number      INT(5) NOT NULL AUTO_INCREMENT,
    product_category  VARCHAR(30),
    season            VARCHAR(30),
    region            VARCHAR(30),
    PRIMARY KEY (store_number)
  );



  /********************************** RELATIONAL TABLES NOT WORKING CURRENTLY ********************/
  CREATE TABLE SonicDB.stocks(
    manufacturer_id    INT(5) NOT NULL,
    transaction_id    INT(5) NOT NULL,
    PRIMARY KEY (manufacturer_id, transaction_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (manufacturer_id),
    FOREIGN KEY (transaction_id) REFERENCES shipper (transaction_id)
  );

  CREATE TABLE SonicDB.ships(
    transaction_number  INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    PRIMARY KEY (transaction_number, package_id),
    FOREIGN KEY (transaction_id) REFERENCES shipper (transaction_id),
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


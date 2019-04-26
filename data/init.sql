CREATE DATABASE SonicDB;

  use SonicDB;

  CREATE TABLE manufacturer (
    manufactuer_id      INT(5) NOT NULL AUTO_INCREMENT,
    manufacturer_name   VARCHAR,
    sales               VARCHAR,
    PRIMARY KEY (manufactuer_id)
  );

  CREATE TABLE shipper(
    transaction_number  INT(5) NOT NULL AUTO_INCREMENT,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    PRIMARY KEY (transaction_number)
  );

  CREATE TABLE product(
    manufacturer_id     INT(5) NOT NULL,
    item_id             INT(5) NOT NULL AUTO_INCREMENT,
    package_id          INT(5) NOT NULL,
    quantity            INT(5),
    price               MONEY,
    PRIMARY KEY (item_id)
  );

  CREATE TABLE package(
    package_id        INT(5) NOT NULL AUTO_INCREMENT,
    price             MONEY,
    transaction_id    INT(5) NOT NULL,
    PRIMARY KEY (package_id)
  );

  CREATE TABLE customer(
    email             VARCHAR,
    customer_name     VARCHAR,
    customer_address  VARCHAR,
    phone             INT(10),
    PRIMARY KEY (email)
  );

  CREATE TABLE inventory(
    store_number      INT(5) NOT NULL AUTO_INCREMENT,
    product_category  VARCHAR,
    season            VARCHAR,
    region            VARCHAR,
    PRIMARY KEY (store_number)
  );

  CREATE TABLE stocks(
    manufactuer_id    INT(5) NOT NULL,
    transaction_id    INT(5) NOT NULL,
    PRIMARY KEY (manufactuer_id),
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (manufactuer_id),
    FOREIGN KEY (transaction_id) REFERENCES shipper (transaction_id)
  );

  CREATE TABLE ships(
    transaction_number  INT(5) NOT NULL,
    package_id          INT(5) NOT NULL,
    PRIMARY KEY (transaction_number),
    PRIMARY KEY (package_id),
    FOREIGN KEY (transaction_id) REFERENCES shipper (transaction_id),
    FOREIGN KEY (package_id) REFERENCES package (package_id)
  );

  CREATE TABLE tracks(
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (manufacturer_id)
  );

  CREATE TABLE reorders(
    package_id          INT(5) NOT NULL,
    manufacturer_id     INT(5) NOT NULL,
    PRIMARY KEY (package_id),
    PRIMARY KEY (manufacturer_id),
    FOREIGN KEY (package_id) REFERENCES package (package_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (manufacture_id)
  );

  CREATE TABLE contents(
    package_id          INT(5) NOT NULL,
    item_id             INT(5) NOT NULL,
    PRIMARY KEY (package_id),
    PRIMARY KEY (item_id),
    FOREIGN KEY (package_id) REFERENCES package (package_id),
    FOREIGN KEY (item_id) REFERENCES product (item_id)
  );


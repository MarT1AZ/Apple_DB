DROP DATABASE AppleECommerce;
CREATE DATABASE IF NOT EXISTS AppleECommerce;
use AppleECommerce;

CREATE TABLE IF NOT EXISTS Apple_account(
Account_ID INT UNIQUE NOT NULL,
Email VARCHAR(50) UNIQUE NOT NULL,
Phone_number CHAR(12) NOT NULL,
Login_verification_method VARCHAR(6) NOT NULL,
country VARCHAR(40) NOT NULL,
name VARCHAR(60) NOT NULL,
address VARCHAR(100) NOT NULL,
password CHAR(32) UNIQUE NOT NULL,
CONSTRAINT pk_acc PRIMARY KEY (Account_ID),
CONSTRAINT chk_login_verification_method CHECK (Login_verification_method in ('OTP', 'device', 'Email')),
CONSTRAINT chk_Account_ID CHECK (Account_ID > 0)
);

CREATE TABLE IF NOT EXISTS Physical_store(
store_number INT UNIQUE NOT NULL,
address VARCHAR(100) NOT NULL,
name VARCHAR(50) NOT NULL,
CONSTRAINT pk_store PRIMARY KEY (store_number)
);

CREATE TABLE IF NOT EXISTS ProductLine(
product_line_name VARCHAR(50) UNIQUE NOT NULL,
description VARCHAR(200),
CONSTRAINT pk_pline PRIMARY KEY (product_line_name)
);


-- Purchase record (record number, delivery option, confirm payment method, 
-- Account ID, store number)

CREATE TABLE IF NOT EXISTS Ongoing_order(
order_number INT UNIQUE NOT NULL,
delivery_option VARCHAR(17) NOT NULL,
unconfirm_payment_method VARCHAR(11) NOT NULL,
Account_ID INT NOT NULL,
store_number INT NOT NULL,
CONSTRAINT fk_ord_apple_acc FOREIGN KEY (Account_ID) REFERENCES Apple_account(Account_ID),
CONSTRAINT fk_ord_phy_store FOREIGN KEY (store_number) REFERENCES Physical_store(store_number),
CONSTRAINT pk_ongo_order PRIMARY KEY (order_number),
CONSTRAINT chk_ord_deli_opt CHECK (delivery_option IN ('pick-up','standard-delivery')),
CONSTRAINT chk_ucpm CHECK (unconfirm_payment_method IN ('ATM','credit card')),
CONSTRAINT chk_ord_num CHECK (order_number > 0)
);

CREATE TABLE IF NOT EXISTS Purchase_record(
record_number INT UNIQUE NOT NULL,
delivery_option VARCHAR(17) NOT NULL,
confirm_payment_method VARCHAR(11) NOT NULL,
Account_ID INT NOT NULL,
store_number INT NOT NULL,
CONSTRAINT fk_pur_apple_acc FOREIGN KEY (Account_ID) REFERENCES Apple_account(Account_ID),
CONSTRAINT fk_pur_phy_store FOREIGN KEY (store_number) REFERENCES Physical_store(store_number),
CONSTRAINT pk_purc_rec PRIMARY KEY (record_number),
CONSTRAINT chk_pur_deli_opt CHECK (delivery_option IN ('pick-up','standard-delivery')),
CONSTRAINT chk_cpm CHECK (confirm_payment_method IN ('ATM','credit card')),
CONSTRAINT chk_rec_num CHECK (record_number > 0)
);

CREATE TABLE IF NOT EXISTS Week_day(
opening_time DATETIME NOT NULL,
closing_time DATETIME NOT NULL,
day_name VARCHAR(9) UNIQUE NOT NULL,
store_number INT  NOT NULL,
CONSTRAINT pk_day PRIMARY KEY (store_number,day_name),
CONSTRAINT fk_store FOREIGN KEY (store_number) REFERENCES Physical_store(store_number),
CONSTRAINT ck_dayname CHECK (day_name IN ('tuesday', 'wednesday', 
											'thursday', 'friday', 
											'saturda', 'sunday'))
);


-- Product ( product number, number of item in inventory, description, 
-- product type, name, product line name, Product.product_number)

CREATE TABLE IF NOT EXISTS Product(
product_number INT UNIQUE NOT NULL,
number_of_item_in_inventory INT,
description VARCHAR(200),
product_type VARCHAR(30),
name VARCHAR(40) UNIQUE NOT NULL,
product_line_name VARCHAR(50) NOT NULL,
product_compat_number INT,
CONSTRAINT pk_product PRIMARY KEY (product_number),
CONSTRAINT fk_compat_product FOREIGN KEY (product_compat_number) REFERENCES Product(product_number),
CONSTRAINT ck_prod_num CHECK (product_number > 0),
CONSTRAINT ck_num_inv CHECK (number_of_item_in_inventory >= 0)
);

-- Include (product number, record number, unit ordered)
-- Consist of (product number, order number, unit ordered)
-- Is_Close_To (Account_ID,store number)

CREATE TABLE IF NOT EXISTS Include(
product_number INT NOT NULL,
record_number INT NOT NULL,
unit_ordered INT NOT NULL,
CONSTRAINT fk_inc_prod FOREIGN KEY (product_number) REFERENCES Product(product_number),
CONSTRAINT fk_inc_rec FOREIGN KEY (record_number) REFERENCES Purchase_record(record_number),
CONSTRAINT ck_inc_unit CHECK(unit_ordered > 0)
);


CREATE TABLE IF NOT EXISTS Consist_of(
product_number INT NOT NULL,
order_number INT NOT NULL,
unit_ordered INT NOT NULL,
CONSTRAINT fk_con_prod FOREIGN KEY (product_number) REFERENCES Product(product_number),
CONSTRAINT fk_con_order FOREIGN KEY (order_number) REFERENCES Ongoing_order(order_number),
CONSTRAINT ck_con_unit CHECK(unit_ordered > 0)
);

CREATE TABLE IF NOT EXISTS Is_Close_To(
Account_ID INT NOT NULL,
store_number INT NOT NULL,
CONSTRAINT fk_acc_id FOREIGN KEY (Account_ID) REFERENCES Apple_account(Account_ID),
CONSTRAINT fk_phy_store FOREIGN KEY (store_number) REFERENCES Physical_store(store_number)
);



DROP DATABASE AppleECommerce;
CREATE DATABASE IF NOT EXISTS AppleECommerce
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_0900_as_cs;
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
opening_time TIME NOT NULL,
closing_time TIME NOT NULL,
day_name VARCHAR(9) NOT NULL,
store_number INT  NOT NULL,
CONSTRAINT pk_day PRIMARY KEY (store_number,day_name),
CONSTRAINT fk_store FOREIGN KEY (store_number) REFERENCES Physical_store(store_number),
CONSTRAINT ck_dayname CHECK (day_name IN ('monday','tuesday', 'wednesday', 
											'thursday', 'friday', 
											'saturday', 'sunday'))
);


CREATE TABLE IF NOT EXISTS ProductLine(
line_id INT UNIQUE NOT NULL,
product_line_name VARCHAR(20) UNIQUE NOT NULL,
description VARCHAR(400),
CONSTRAINT pk_pline PRIMARY KEY (product_line_name),
CONSTRAINT ck_line_id CHECK (line_id >= 0)
);

CREATE TABLE IF NOT EXISTS Product(
product_number INT UNIQUE NOT NULL,
number_of_item_in_inventory INT,
description VARCHAR(350),
product_type VARCHAR(30),
name VARCHAR(60) UNIQUE NOT NULL,
line_id INT NOT NULL,
installment_price DECIMAL(6,2) DEFAULT NULL,
price INT NOT NULL,
CONSTRAINT pk_product PRIMARY KEY (product_number),
CONSTRAINT ck_prod_num CHECK (product_number > 0),
CONSTRAINT ck_num_inv CHECK (number_of_item_in_inventory >= 0),
CONSTRAINT ck_price CHECK (price > 0),
CONSTRAINT ck_isn_price CHECK (installment_price > 0),
CONSTRAINT fk_line_id FOREIGN KEY (line_id) REFERENCES ProductLine(line_id)
);



CREATE TABLE IF NOT EXISTS Compatability(
product_number INT NOT NULL,
accessory_number INT NOT NULL,
CONSTRAINT fk_compat_product FOREIGN KEY (product_number) REFERENCES Product(product_number),
CONSTRAINT fk_compat_accessory FOREIGN KEY (accessory_number) REFERENCES Product(product_number)
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



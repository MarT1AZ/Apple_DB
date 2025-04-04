use AppleECommerce;


# locate my.ini in C:\ProgramData\MySQL\MySQL Server 8.0
# set "secure_file_priv" variable to "" first
# save my.ini at any directory expect C:\ProgramData\MySQL\MySQL Server 8.0
# copy the my.ini and replace it inside the directory C:\ProgramData\MySQL\MySQL Server 8.0
# if it ask for permission, give it

# Go to Service
# Search for 'MySQL80'
# right click and stop it
# right click then start it

# put all the data inside the variable C:\ProgramData\MySQL\MySQL Server 8.0\Data\appleecommerce\


LOAD DATA INFILE 'Apple_account.csv' INTO TABLE Apple_account
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'Product_line.csv' INTO TABLE ProductLine
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'Physical_store.csv' INTO TABLE Physical_store
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'is_close_to.csv' INTO TABLE Is_Close_to
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'Week_day.csv' INTO TABLE Week_day
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'product.csv' INTO TABLE Product
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'product_type.csv' INTO TABLE Product_type
FIELDS TERMINATED BY ','
IGNORE 1 LINES;



LOAD DATA INFILE 'compatability.csv' INTO TABLE Compatability
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'Purchase_record.csv' INTO TABLE Purchase_record
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'Ongoing_order.csv' INTO TABLE Ongoing_order
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'consist_of.csv' INTO TABLE Consist_of
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'include.csv' INTO TABLE Include
FIELDS TERMINATED BY ','
IGNORE 1 LINES;



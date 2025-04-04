use AppleECommerce;

# Branch category
SELECT COUNT(*) AS 'number of entry in Physical store table' FROM physical_store;

# Client category
SELECT COUNT(*) AS 'number of entry in Apple_account table' FROM apple_account;

# view/transaction category
SELECT COUNT(*) 'number of entry in purchase_record table' FROM purchase_record;
SELECT COUNT(*) AS 'number of entry in ongoing_order table' FROM ongoing_order;
SELECT COUNT(*) 'number of entry in consist_of table' FROM consist_of;
SELECT COUNT(*) AS 'number of entry in include table' FROM include;

# other category
SELECT COUNT(*) AS 'number of entry in week_day table' FROM week_day;
SELECT COUNT(*) AS 'number of entry in is_close_to table' FROM is_close_to;
SELECT COUNT(*) AS 'number of entry in productline table' FROM productline;
SELECT COUNT(*) AS 'number of entry in product_type table' FROM product_type;
SELECT COUNT(*) 'number of entry in product table' FROM product;
SELECT COUNT(*) 'number of entry in compatability table' FROM compatability;

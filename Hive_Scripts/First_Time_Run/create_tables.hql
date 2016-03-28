--Create staging tables

CREATE TABLE db_ecommerce.customer_stg (customerid INT, domaincode STRING, dob TIMESTAMP, gender STRING, sizes INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.order_stg (ordernumber INT, variantid INT, customerid INT, quantity INT, unitprice FLOAT, ordercreationdate TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.productref_stg (variantid INT, productcolorid INT, productid INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.catalogue_stg (productcolorid INT, genderlabel STRING, suppliercolorlabel STRING, seasonlabel STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.variant_stg (variantid INT, minsize INT, maxsize INT, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;


--Create weather information tables

CREATE TABLE db_ecommerce.forecast_stg (date STRING, code_postal STRING, latitude FLOAT, longitude FLOAT, summary STRING, temperature_min FLOAT, temperature_max FLOAT,  day_forecast_icon STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.france_departments_stg (departement STRING, code_postal STRING, commune STRING, longitude FLOAT, latitude FLOAT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.departement_code_nom_stg (departement STRING, departement_nom STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
tblproperties ("skip.header.line.count"="1");
STORED AS TEXTFILE;


-- Create intermediate tables


CREATE TABLE db_ecommerce.customer_intermediate (ordernumber INT, variantid INT, customerid INT, quantity INT, unitprice FLOAT, ordercreationdate TIMESTAMP,gender STRING, sizes INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.product_intermediate (variantid INT, productcolorid INT, productid INT, genderlabel STRING, suppliercolorlabel STRING, seasonlabel STRING, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.customer_master (customerid INT, genderlabel STRING, sizes STRING, ordercreationdate TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.product_master (productid INT, unitprice FLOAT, quantity INT, customerid INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.customer_gender_count (customerid INT, genderlabel STRING, buy_count INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_gender (customerid INT, genderlabel STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_gender_freq (customerid INT, genderlabel STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_gender_classify (customerid INT, info INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_dominant_gender (customerid INT, genderlabel STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.customer_size_count (customerid INT, sizes STRING, b_count INT )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_size (customerid INT, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_size_freq (customerid INT, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_size_classify (customerid INT, info INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

CREATE TABLE db_ecommerce.customer_dominant_size (customerid INT, sizes STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.customer_last_purchase (customerid INT, lastdate TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;



-- Create aggrigate tables

CREATE TABLE db_ecommerce.product (productid INT, total_amount_sold FLOAT, total_quantity_sold FLOAT, number_of_distinct_customers INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.weather (date STRING, departement_nom STRING, departement STRING, commune STRING, code_postal STRING, longitude FLOAT, latitude FLOAT, temperature_min FLOAT, temperature_max FLOAT, summary STRING, day_forecast_icon STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;


CREATE TABLE db_ecommerce.customer (customerid INT, dominant_gender STRING, dominant_size STRING, last_purchase_date TIMESTAMP)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

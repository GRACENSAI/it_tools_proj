LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Customer.csv' OVERWRITE INTO TABLE `db_ecommerce.customer_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Order.csv' INTO TABLE `db_ecommerce.order_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Product_Reference.csv' OVERWRITE INTO TABLE `db_ecommerce.productref_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Catalogue.csv' OVERWRITE INTO TABLE `db_ecommerce.catalogue_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Weather_Stage/weather_forecast.csv' INTO TABLE `db_ecommerce.forecast_stg`;


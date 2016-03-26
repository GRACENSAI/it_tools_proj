LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Customer.csv' INTO TABLE `db_ecommerce.customer_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Order.csv' INTO TABLE `db_ecommerce.order_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Product_Reference.csv' INTO TABLE `db_ecommerce.productref_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Data_Stage/Catalogue.csv' INTO TABLE `db_ecommerce.catalogue_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Daily_Weather_Stage/weather_forecast.csv' INTO TABLE `db_ecommerce.forecast_stg`;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Static_Data/Variant.csv' INTO TABLE `db_ecommerce.variant_stg`

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Static_Data/departments_lat_log.csv' INTO TABLE `db_ecommerce.france_departments_stg`

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/it_tools_project/Static_Data/departement_code_nom.csv' INTO TABLE `db_ecommerce.departement_code_nom_stg`


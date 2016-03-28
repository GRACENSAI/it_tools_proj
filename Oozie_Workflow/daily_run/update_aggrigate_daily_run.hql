-- Customer

TRUNCATE TABLE db_ecommerce.customer;

INSERT INTO TABLE db_ecommerce.customer
select a.customerid , a.genderlabel, b.sizes, c.lastdate
from db_ecommerce.customer_dominant_gender a join db_ecommerce.customer_dominant_size b on (a.customerid = b.customerid)
join db_ecommerce.customer_last_purchase c on  (a.customerid = c.customerid);


-- Product

TRUNCATE TABLE db_ecommerce.product

INSERT INTO TABLE db_ecommerce.product
SELECT productid, SUM(unitprice), COUNT(quantity), COUNT(DISTINCT(customerid))
FROM db_ecommerce.product_master
GROUP BY productid;

-- Weather

TRUNCATE TABLE db_ecommerce.weather

INSERT INTO db_ecommerce.weather
SELECT b.date, c.departement_nom , a.departement, a.commune, b.code_postal, a.longitude, a.latitude, b.temperature_min, b.temperature_max, b.summary, b.day_forecast_icon 
FROM db_ecommerce.france_departments_stg a JOIN db_ecommerce.forecast_stg b 
ON (a.latitude = b.latitude AND a.longitude = b.longitude) 
JOIN db_ecommerce.departement_code_nom c ON (a.departement = c.departement)

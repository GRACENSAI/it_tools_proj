TRUNCATE TABLE db_ecommerce.product

INSERT INTO TABLE db_ecommerce.product
SELECT productid, SUM(unitprice), COUNT(quantity), COUNT(DISTINCT(customerid))
FROM product_master
GROUP BY productid;


TRUNCATE TABLE db_ecommerce.weather

INSERT INTO db_ecommerce.weather
SELECT b.date, c.departement_nom , a.departement, a.commune, b.code_postal, a.longitude, a.latitude, b.temperature_min, b.temperature_max, b.summary, b.day_forecast_icon 
FROM db_ecommerce.france_departments_stg a JOIN db_ecommerce.forecast_stg b 
ON (a.latitude = b.latitude AND a.longitude = b.longitude) 
JOIN db_ecommerce.departement_code_nom c ON (a.departement = c.departement)

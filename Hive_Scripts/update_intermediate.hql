TRUNCATE TABLE db_ecommerce.customer_intermediate

INSERT INTO TABLE db_ecommerce.customer_intermediate
SELECT a.ordernumber, a.variantid, a.customerid, a.quantity, a.unitprice, a.ordercreationdate, b.gender, b.sizes
FROM db_ecommerce.order_stg a LEFT OUTER JOIN db_ecommerce.customer_stg b
ON (a.customerid=b.customerid);


TRUNCATE TABLE db_ecommerce.product_intermediate

INSERT INTO TABLE db_ecommerce.product_intermediate
SELECT a.variantid, a.productcolorid, a.productid, b.genderlabel, b.suppliercolorlabel, b.seasonlabel, c.sizes
FROM db_ecommerce.productref_stg a RIGHT OUTER JOIN db_ecommerce.catalogue_stg b ON (a.productcolorid=b.productcolorid)
JOIN db_ecommerce.variant_stg c ON (a.variantid=c.variantid);


TRUNCATE TABLE db_ecommerce.customer_master

INSERT INTO TABLE db_ecommerce.customer_master
SELECT a.customerid, b.genderlabel, b.sizes, a.ordercreationdate
FROM customer_intermediate a LEFT OUTER JOIN product_intermediate b 
ON (a.variantid=b.variantid);


TRUNCATE TABLE db_ecommerce.product_master

INSERT INTO TABLE db_ecommerce.product_master
SELECT b.productid, a.unitprice, a.quantity, a.customerid
FROM customer_intermediate a LEFT OUTER JOIN product_intermediate b 
ON (a.variantid=b.variantid);




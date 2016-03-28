-- Intermediate and Masters

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
FROM db_ecommerce.customer_intermediate a LEFT OUTER JOIN db_ecommerce.product_intermediate b 
ON (a.variantid=b.variantid);


TRUNCATE TABLE db_ecommerce.product_master

INSERT INTO TABLE db_ecommerce.product_master
SELECT b.productid, a.unitprice, a.quantity, a.customerid
FROM db_ecommerce.customer_intermediate a LEFT OUTER JOIN db_ecommerce.product_intermediate b 
ON (a.variantid=b.variantid);


-- Last purchase

TRUNCATE TABLE db_ecommerce.customer_last_purchase;

INSERT INTO TABLE db_ecommerce.customer_last_purchase
SELECT customerid,MAX(ordercreationdate) as ordercreationdate
FROM db_ecommerce.customer_master
GROUP BY customerid;

-- Gender

TRUNCATE TABLE db_ecommerce.customer_gender_count;

INSERT INTO TABLE db_ecommerce.customer_gender_count
SELECT customerid, genderlabel, COUNT(genderlabel) as buy_count
FROM db_ecommerce.customer_master
GROUP BY customerid,genderlabel
ORDER BY customerid, buy_count;


TRUNCATE TABLE db_ecommerce.customer_gender

INSERT INTO TABLE db_ecommerce.customer_gender
SELECT a.customerid, a.genderlabel
FROM db_ecommerce.customer_gender_count a
INNER JOIN (
    SELECT customerid, MAX(buy_count) as buy_count
    FROM db_ecommerce.customer_gender_count
    GROUP BY customerid
) b ON a.customerid = b.customerid AND a.buy_count = b.buy_count;


TRUNCATE TABLE db_ecommerce.customer_gender_freq;

INSERT INTO TABLE db_ecommerce.customer_gender_freq
select t1.customerid,max(t1.genderlabel) as most_frequent_duration
 from 
 (select customerid, genderlabel, count(*) as frequency
       from db_ecommerce.customer_master
       group by customerid, genderlabel) t1
 inner join 
 (select t2.customerid,max(t2.frequency) as max_frequency
 from (select customerid, genderlabel, count(*) as frequency
       from db_ecommerce.customer_master
       group by customerid, genderlabel) t2
 group by t2.customerid) t3 
   on t3.customerid = t1.customerid and t1.frequency = t3.max_frequency
 group by t1.customerid
 order by customerid;



TRUNCATE TABLE db_ecommerce.customer_gender_classify;

INSERT INTO TABLE db_ecommerce.customer_gender_classify
Select customerid, (if ((count(a.genderlabel) >1) , 1, 0))
From db_ecommerce.customer_gender a
group by a.customerid;


TRUNCATE TABLE db_ecommerce.customer_dominant_gender;

INSERT INTO TABLE db_ecommerce.customer_dominant_gender
SELECT t1.cid, if((t1.gender=""), t2.gender, t1.gender)
from
(
  select DISTINCT a.customerid cid, if((a.info=0), b.genderlabel, "") as gender
  from db_ecommerce.customer_gender_classify a, db_ecommerce.customer_gender b
  where a.customerid = b.customerid
  ) t1
JOIN
(
  select a.customerid cid, if((a.info=0), "" ,c.genderlabel) as gender 
  from db_ecommerce.customer_gender_classify a, db_ecommerce.customer_gender_freq c
  where a.customerid = c.customerid
  ) t2
  on t1.cid = t2.cid;


-- Size

TRUNCATE TABLE db_ecommerce.customer_size_count;

INSERT INTO TABLE db_ecommerce.customer_size_count
SELECT customerid, sizes, COUNT(sizes) as b_count
FROM db_ecommerce.customer_master
GROUP BY customerid,sizes
ORDER BY customerid, b_count;

TRUNCATE TABLE db_ecommerce.customer_size

INSERT INTO TABLE db_ecommerce.customer_size
SELECT a.customerid, a.sizes
FROM db_ecommerce.customer_size_count a
INNER JOIN (
    SELECT customerid, MAX(b_count) as b_count
    FROM db_ecommerce.customer_size_count
    GROUP BY customerid
) b ON a.customerid = b.customerid AND a.b_count = b.b_count;


TRUNCATE TABLE db_ecommerce.customer_size_freq;

INSERT INTO TABLE db_ecommerce.customer_size_freq
select t1.customerid,max(t1.sizes) as most_frequent_size
 from 
 (select customerid, sizes, count(*) as frequency
       from db_ecommerce.customer_master
       group by customerid, sizes) t1
 inner join 
 (select t2.customerid,max(t2.frequency) as max_frequency
 from (select customerid, sizes, count(*) as frequency
       from db_ecommerce.customer_master
       group by customerid, sizes) t2
 group by t2.customerid) t3 
   on t3.customerid = t1.customerid and t1.frequency = t3.max_frequency
 group by t1.customerid
 order by customerid;


TRUNCATE TABLE db_ecommerce.customer_size_classify;

INSERT INTO TABLE db_ecommerce.customer_size_classify
Select customerid, (if ((count(a.sizes) >1) , 1, 0))
From db_ecommerce.customer_size a
group by a.customerid;


TRUNCATE TABLE db_ecommerce.customer_dominant_size;

INSERT INTO TABLE db_ecommerce.customer_dominant_size
SELECT t1.cid, if((t1.sizes=""), t2.sizes, t1.sizes)
from
(
  select DISTINCT a.customerid cid, if((a.info=0), b.sizes, "") as sizes
  from db_ecommerce.customer_size_classify a, db_ecommerce.customer_size b
  where a.customerid = b.customerid
  ) t1
JOIN
(
  select a.customerid cid, if((a.info=0), "" ,c.sizes) as sizes 
  from db_ecommerce.customer_size_classify a, db_ecommerce.customer_size_freq c
  where a.customerid = c.customerid
  ) t2
  on t1.cid = t2.cid;

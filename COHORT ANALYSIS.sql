SELECT 
* from public.online_retail_data

-- cohort analysis 



-- 1) Order cohort
with cte1 as
(select 
invoiceno,
invoicedate,
customerid,
round((unitprice::numeric*quantity),2) as revenue
from public.online_retail_data),
cte2 as
(
select
*,
to_char(min(invoicedate) over (partition by customerid order by invoicedate)::DATE,'yyyy-mm-01') as customer_first_purchase,
to_char(invoicedate::date,'yyyy-mm-01') as purchase_month
from cte1
),
cte3 as 
(
select
*,
EXTRACT(YEAR FROM age(purchase_month::date, customer_first_purchase::date)) * 12 +
EXTRACT(MONTH FROM age(purchase_month::date,customer_first_purchase::date)) as month_
from cte2
)
select 
customer_first_purchase,
count(DISTINCT case when month_=0 then invoiceno else null end) as month_0,
count(DISTINCT case when month_=1 then invoiceno else null end) as month_1,
count(DISTINCT case when month_=2 then invoiceno else null end) as month_2,
count(DISTINCT case when month_=3 then invoiceno else null end) as month_3,
count(DISTINCT case when month_=4 then invoiceno else null end) as month_4,
count(DISTINCT case when month_=5 then invoiceno else null end) as month_5,
count(DISTINCT case when month_=6 then invoiceno else null end) as month_6,
count(DISTINCT case when month_=7 then invoiceno else null end) as month_7,
count(DISTINCT case when month_=8 then invoiceno else null end) as month_8,
count(DISTINCT case when month_=9 then invoiceno else null end) as month_9,
count(DISTINCT case when month_=10 then invoiceno else null end) as month_10,
count(DISTINCT case when month_=11 then invoiceno else null end) as month_11,
count(DISTINCT case when month_=12 then invoiceno else null end) as month_12

from cte3
group by 1



-- CUSTOMER COHORT
with cte1 as
(select 
invoiceno,
invoicedate,
customerid,
round((unitprice::numeric*quantity),2) as revenue
from public.online_retail_data),
cte2 as
(
select
*,
to_char(min(invoicedate) over (partition by customerid order by invoicedate)::DATE,'yyyy-mm-01') as customer_first_purchase,
to_char(invoicedate::date,'yyyy-mm-01') as purchase_month
from cte1
),
cte3 as 
(
select
*,
EXTRACT(YEAR FROM age(purchase_month::date, customer_first_purchase::date)) * 12 +
EXTRACT(MONTH FROM age(purchase_month::date,customer_first_purchase::date)) as month_
from cte2
)
select 
customer_first_purchase,
count(DISTINCT case when month_=0 then customerid else null end) as month_0,
count(DISTINCT case when month_=1 then customerid else null end) as month_1,
count(DISTINCT case when month_=2 then customerid else null end) as month_2,
count(DISTINCT case when month_=3 then customerid else null end) as month_3,
count(DISTINCT case when month_=4 then customerid else null end) as month_4,
count(DISTINCT case when month_=5 then customerid else null end) as month_5,
count(DISTINCT case when month_=6 then customerid else null end) as month_6,
count(DISTINCT case when month_=7 then customerid else null end) as month_7,
count(DISTINCT case when month_=8 then customerid else null end) as month_8,
count(DISTINCT case when month_=9 then customerid else null end) as month_9,
count(DISTINCT case when month_=10 then customerid else null end) as month_10,
count(DISTINCT case when month_=11 then customerid else null end) as month_11,
count(DISTINCT case when month_=12 then customerid else null end) as month_12
from cte3
group by 1



-- REVENUE COHORT

with cte1 as
(select 
invoiceno,
invoicedate,
customerid,
round((unitprice::numeric*quantity),2) as revenue
from public.online_retail_data),
cte2 as
(
select
*,
to_char(min(invoicedate) over (partition by customerid order by invoicedate)::DATE,'yyyy-mm-01') as customer_first_purchase,
to_char(invoicedate::date,'yyyy-mm-01') as purchase_month
from cte1
),
cte3 as 
(
select
*,
EXTRACT(YEAR FROM age(purchase_month::date, customer_first_purchase::date)) * 12 +
EXTRACT(MONTH FROM age(purchase_month::date,customer_first_purchase::date)) as month_
from cte2
)
select 
customer_first_purchase,
SUM(DISTINCT case when month_=0 then revenue  else null end) as month_0,
COALESCE(SUM(DISTINCT case when month_=1 then revenue else null end),0) as month_1,
COALESCE(SUM(DISTINCT case when month_=2 then revenue else null end),0) as month_2,
COALESCE(SUM(DISTINCT case when month_=3 then revenue else null end),0) as month_3,
COALESCE(SUM(DISTINCT case when month_=4 then revenue else null end),0) as month_4,
COALESCE(SUM(DISTINCT case when month_=5 then revenue else null end),0) as month_5,
COALESCE(SUM(DISTINCT case when month_=6 then revenue else null end),0) as month_6,
COALESCE(SUM(DISTINCT case when month_=7 then revenue else null end),0) as month_7,
COALESCE(SUM(DISTINCT case when month_=8 then revenue else null end),0) as month_8,
COALESCE(SUM(DISTINCT case when month_=9 then revenue else null end),0) as month_9,
COALESCE(SUM(DISTINCT case when month_=10 then revenue  else null end),0) as month_10,
COALESCE(SUM(DISTINCT case when month_=11 then revenue  else null end),0) as month_11,
COALESCE(SUM(DISTINCT case when month_=12 then revenue  else null end),0) as month_12

from cte3
group by 1


-- ARPC,AOV,ROI,CUSTOMER RETENTION RATE(TREND KORBO)
-- W3SCHOOLS.C0M
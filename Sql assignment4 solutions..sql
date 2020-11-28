/*-------------Task 1:- Understanding the Data-------*/


/*-------(1)Describe the data in hand in your own words -----------*/

/* This database contains all details of the Superstore inclusion of sales's transaction .This database has five tables namely they are
(1) cust_dimen
 which tells about the complete information about the customer and their region going to the columns in this table
									Customer_Name : represents the name of the customer 
                                    Cust_id       : which gives the customer ID
                                    Cust_Segment  : tells the segment of customer
                                    Province      : gives the province of customer 
                                    Region        : region of the customer
                                    
(2)prod_dimen contains
									Product_Category-------->Product category
									Product_Sub_Category --->  product Subcategory
                                    Prod_id ----------------> which gives the unique ID of products
   
(3)order_dimen contains       		Order_ID        :  tells Order ID
									Order_Date      : tells the Order Date
									Order_Priority  : which means Priority of the Order
									Ord_id          : tells the Order ID which is unique
(4) market_fact    has
									Ord_id --------- gives the Order ID
									Prod_id -------- means Product ID
									Ship_id --------- tells the Shipment ID
									Cust_id --------- gives the Customer ID
									Sales ------------ Sales fo the item 
									Discount ---------- Discount on the thing which was sold 
									Order_Quantity --------  Quantity of the order sold
									Profit -------------- Profit from the item sold
									Shipping_Cost ----------Shipping Cost of the item sold
									Product_Base_Margin---------Product Base Margin of the item which was sold

(5)shipping_dimen contains 
									Order_ID ----- tells the order ID
                                    Ship_Mode-----tells the  mode of shipping the products 
                                    Ship_id-------gives the id which id unique
									Ship_Date-----tells the date i.e, when we have  shipped 
								
  By observing these data in the tables which are there in the database we concluded that datatypes we use here are 
				  int
				  char (which is in textual format)
				  string
				  double 
				
(2) -----------/*Identify and list the Primary Keys and Foreign Keys for this dataset provided to you
(In case you don’t find either primary or foreign key, then specially mention this in your answer)---------*/
 
 1.cust_dimen - Cust_id is Primary Key and has no foreign key
 2. prod_dimen - Prod_id is Primary Key and  no foreign key is there
3. orders_dimen - Ord_id is Primary Key eventhough we has  Order_ID  
4. shipping_dimen - Shipping id is primary key and Order_ID is foreign key.
 5. market_fact - Ord_id, Prod_id, Ship_id and Cust_id are  foreign key and has No Primary Key. */




/*---------------------------Task 2:- Basic & Advanced Analysis----------*/

/*-----(1)Write a query to display the Customer_Name and Customer Segment 
using alias name “Customer Name", "Customer Segment" from table Cust_dimen.*/
select customer_name as "CUSTOMER NAME" , customer_segment as "CUSTOMER SEGMENT"
from cust_dimen;



/*------(2)Write a query to find all the details of the customer from the table cust_dimen order by desc.****/
select * from cust_dimen
order by  customer_name desc;



/*----(3)Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.*/
select order_id , order_date , order_priority
from orders_dimen
where order_priority = "high";


/*----(4)Find the total and the average sales (display total_sales and avg_sal0es)--*/
select  sum(sales) as "total_sales" , avg(sales) as "avg_sales"
 from market_fact;
 
 
 /*------(5)Write a query to get the maximum and minimum sales from maket_fact table-------*/
  select max(sales) , min(sales)
 from market_fact;
 
 
 /*----(6)Display the number of customers in each region in decreasing order of no_of_customers.
 The result should contain columns Region, no_of_customers--------*/
 select region, count(cust_id) as "no_of_customers "
 from cust_dimen
 group by region
 order by count(cust_id) desc;
 
 
 /*-----(7)Find the region having maximum customers (display the region name and max(no_of_customers)--*/
select region, count(cust_id) as' no of customer'
from cust_dimen
group by region
order by COUNT(cust_id) desc
 limit 1;  
 
 
/*-------(8)Find all the customers from Atlantic region who have everpurchased ‘TABLES’ and
 the number oftables purchased (display the customer name, no_of_tables purchased)-----*/
 select c.customer_name "customer name " , c.region "region " , p.product_sub_category "product sub category",
sum(m.order_quantity) "order quantity"
from market_fact m 
join cust_dimen c on m.cust_id = c.cust_id
join prod_dimen p on m.prod_id = p.prod_id
where c.region = "ATLANTIC" and p.product_sub_category = "TABLES"
group by c.customer_name
 order by sum(m.order_quantity);
 
 
 /*-------(9)Find all the customers from Ontario province who own Small Business. 
 (display the customer name, no of small business owners)---*/
 select customer_name "customer names", customer_segment
from cust_dimen
where province = "ontario" and customer_segment = "small business";

/* for count we have taken this query-----*/

select customer_name "customer names", count(*)"no of small busiess owners"
from cust_dimen
where province = "ontario" and customer_segment = "small business";



/*---------(10)Find the number and id of products sold in decreasing order of products 
sold (display product id, no_of_products sold) ---*/
select prod_id, sum(order_quantity) as "no_of_products sold"
from market_fact
group by prod_id
order by sum(order_quantity) desc;


/*---------(11)Display product Id and product sub category whose produt category belongs to Furniture and Technlogy.
 The result should contain columns product id, product sub category.-----*/
 select prod_id, product_sub_category , product_category
from prod_dimen
where  product_category in ("furniture","technology")
group by product_sub_category ;


/*--------(12)Display the product categories in descending order of profits (display the product category wise profits i.e.
 product_category, profits)? ------*/
 select p.product_category "product category"  ,sum( m.profit)" profit"
from market_fact m 
join prod_dimen p on m.prod_id = p.prod_id
group by product_category
order by  profit desc;



/*---------(13) Display the product category, product sub-category and the profit within each subcategory in three columns.----*/
select  product_category"product category" , product_sub_category"product sub category", sum(profit)"profit"
from market_fact m 
join prod_dimen p on m.prod_id = p.prod_id
group by product_sub_category
order by product_category;


/*---------(14)Display the order date, order quantity and the sales for the order-------*/
select o.order_date"order date" , m.order_quantity"orders", sales 
from market_fact m 
join orders_dimen o on o.ord_id = m.ord_id
order by m.order_quantity ;



/*--------(15)Display the names of the customers whose name contains the
i) Second letter as ‘R’
ii) Fourth letter as ‘D’ ------------*/
select customer_name 
from cust_dimen
where customer_name like "_R%" or customer_name like "___D%";


/*---------(16)Write a SQL query to to make a list with Cust_Id, Sales, 
Customer Name and their region where sales are between 1000 and 5000.--------*/
select c.cust_id ,m.sales , c.customer_name, c.region
from market_fact m 
join cust_dimen c on c.cust_id = m.cust_id
where m.sales between 1000 and 5000
group by c.region;


/*-----------(17)Write a SQL query to find the 3rd highest sales----------*/
select sales 
from market_fact
order by sales desc limit 2,1 ;


/*-----------(18) Where is the least profitable product subcategory shipped the most?
 For the least profitable product sub-category, display the region-wise no_of_shipments and the 
 profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
→ Note: You can hardcode the name of the least profitable product subcategory----------*/
select c.region as "region",count(m.ship_id) as "no of shipments", 
		m.profit as "profit in each region" 
from market_fact m 
		join cust_dimen c on m.cust_id = c.cust_id
        join prod_dimen p on m.prod_id = p.prod_id
where product_sub_category = (
								    select p.product_sub_category 
								    from market_fact m 
									join prod_dimen p on m.prod_id = p.prod_id
									group by product_sub_category
									order by m.profit
									limit 1) 
group by c.region
order by m.profit;











 
 
 
 
 
# How To Use Mathematical Expressions and Aggregate Functions in SQL

To practice many of the mathematical expression examples in this tutorial, you’ll need a database and table loaded with sample data. If you do not have one ready to insert, you can read the following Connecting to MySQL and Setting up a Sample Database section to learn how to create a database and table. This tutorial will refer to this sample database and table throughout.
The original copy of this exercises/tutorial can be found at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-use-mathematical-expressions-in-sql). I changed the code a bit because I was using Microsoft SQL. 

## Creating a MathDB

Create the database using the statement ``CREATE DATABASE mathDB;``

To select the mathDB database run the following USE statement:
``USE mathDB;``

```CREATE TABLE product_information (
product_id int, 
product_name varchar(30), 
product_type varchar(30), 
total_inventory int,
product_cost decimal(3, 2), 
product_retail decimal(3, 2), 
store_units int,
online_units int,
PRIMARY KEY (product_id)
); 
````

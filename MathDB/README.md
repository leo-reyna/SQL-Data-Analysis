# How To Use Mathematical Expressions and Aggregate Functions in SQL

To practice many of the mathematical expression examples in this tutorial, you’ll need a database and table loaded with sample data. This tutorial will refer to this sample database and table throughout. The steps to create it are in below copy.
The original copy of this exercises/tutorial can be found at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-use-mathematical-expressions-in-sql). I changed the code a bit because I was using Microsoft SQL.

## Creating a MathDB

Create the database using the statement ``CREATE DATABASE mathDB;``

To select the mathDB database run the following USE statement:
``USE mathDB;``
After selecting the database, create a table within it using the ``CREATE TABLE`` command. For this tutorial’s example, we’ll create a table named ``product_information`` to store inventory and sales information for a small tea shop. This table will hold the following eight columns:

* ``product_id``: represents the values of the int data type and will serve as the table’s primary key. This means each value in this column will function as a unique identifier for its respective row.
* ``product_name``: details the names of the products using the varchar data type with a maximum of 30 characters.
* ``product_type``: stores the types of products, as demonstrated by the varchar data type with a maximum of 30 characters.
* ``total_inventory``: represents how many units of each product are left in storage, using the int data type with a maximum of 200.
* ``product_cost``: displays the price of each product purchased at cost using the decimal data type with a maximum of 3 values to the left, and 2 values after the decimal point.
* ``product_retail``: stores prices for each product sold at retail, as shown by the decimal data type with a maximum of 3 values to the left, and 2 values after the decimal point.
* ``store_units``: using values of the int data type, displays how many units of the specific product are available for in-store sales inventory.
* ``online_units``: represents how many units of the specific product are available for online sales inventory using values of the int data type

Create this sample table by running the following command:

````CREATE TABLE product_information (
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

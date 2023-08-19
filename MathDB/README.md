# How To Use Mathematical Expressions and Aggregate Functions in SQL

To practice many of the mathematical expression examples in this tutorial, you’ll need a database and table loaded with sample data. This tutorial will refer to this sample database and table throughout. The steps to create it are in below copy.
The original copy of this exercises/tutorial can be found at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-use-mathematical-expressions-in-sql).

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

```text
CREATE TABLE product_information (
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
```

Insert the following records into the table:

```text
INSERT INTO product_information
    (product_id, 
    product_name, 
    product_type, 
    total_inventory, 
    product_cost, 
    product_retail, 
    store_units, 
    online_units)
VALUES
(1, 'chamomile', 'tea', 200, 5.12, 7.50, 38, 52),
(2, 'chai', 'tea', 100, 7.40, 9.00, 17, 27),
(3, 'lavender', 'tea', 200, 5.12, 7.50, 50, 112),
(4, 'english_breakfast', 'tea', 150, 5.12, 7.50, 22, 74),
(5, 'jasmine', 'tea', 150, 6.17, 7.50, 33, 92),
(6, 'matcha', 'tea', 100, 6.17, 7.50, 12, 41),
(7, 'oolong', 'tea', 75, 7.40, 9.00, 10, 29),
(8, 'tea sampler', 'tea', 50, 6.00, 8.50, 18, 25),
(9, 'ceramic teapot', 'tea item', 30, 7.00, 9.75, 8, 15),
(10, 'golden teaspoon', 'tea item', 100, 2.00, 5.00, 18, 67);
```

## Mathematical Expressions in SQL

Please note this list is not comprehensive and that many RDBMSs have a unique set of mathematical operators.

*Addition uses ``+`` symbol
*Subtraction uses the ``-`` symbol
*Multiplication uses the ``*`` symbol
*Division uses ``/`` symbol
*Modulo operations use the ``%`` symbol
*Exponentation uses ``power(x,y)``

CREATE DATABASE EMarket;

USE EMarket;

Create Table Users(
id int identity primary key,
full_name varchar(100) not null,
email varchar(100) not null,
password varchar(255) not null,
create_at DATETIME not null
);

Create Table Adresses(
id int identity primary key,
Auser_id int not null,
tittle varchar(50) not null,
adress_line varchar(255) not null,
city varchar(100) not null,
postal_code varchar(20) not null,
country varchar(100) not null,
is_default bit not null,
foreign key (Auser_id) references Users(id)
);

Create Table Orders(
id int identity primary key,
Ouser_id int not null,
Oadress_id int not null,
order_date datetime not null,
status varchar(20) not null,
total_amount decimal(10,2) not null,
foreign key (Ouser_id) references Users(id),
foreign key(Oadress_id) references Adresses(id)
);


Create Table Payments(
id int identity primary key,
Porder_id int not null,
payment_date datetime not null,
amount decimal(10,2) not null,
payment_method varchar(50) not null,
status varchar(20) not null,
foreign key (Porder_id) references Orders(id)
);

Create Table Categories (
id int identity primary key,
category_name varchar(100) not null
);

Create Table Products (
id int identity primary key,
Pcategory_id int not null,
product_name varchar(100) not null,
price decimal(10,2) not null,
stock int not null,
foreign key (Pcategory_id) references Categories(id)
);


Create Table Orderitems(
id int identity primary key,
Oorder_id int not null,
Oproduct_id int not null,
quantity int not null,
unit_price decimal(10,2)not null,
foreign key (Oorder_id) references Orders(id),
foreign key (Oproduct_id) references Products(id)
);

Create Table Reviews(
id int identity primary key,
Ruser_id int not null,
Rproduct_id int not null,
rating int not null,
comment text ,
created_at datetime not null,
foreign key (Ruser_id) references Users(id),
foreign key (Rproduct_id) references Products(id)
);

INSERT INTO Users(full_name,email,password,create_at)
VALUES('Ali Yilmaz','ayilmaz@gmail.com','alim66612',GETDATE()),
('Mehmet Kaya','mkaya@gmail.com','meh123',GETDATE()),
('Zeynep Demir','zdemir@gmail.com','zey456',GETDATE()),
('Ahmet Can','acan@gmail.com','ahm789',GETDATE()),
('Elif Yıldız','eyildiz@gmail.com','eli321',GETDATE());

INSERT INTO Categories(category_name)
VALUES('Elektronics'),
('Books'),
('Clothing');

INSERT INTO Products(Pcategory_id,product_name,price,stock)
VALUES
(1,'Laptop',35000,10),
(1,'Mouse',500,50),
(1,'Keyboard',1200,25),
(2,'SQL Book',300,40),
(3,'T-Shirt',450,60),
(3,'Jacket',2000,15);

INSERT INTO Adresses(Auser_id,tittle,adress_line,city,postal_code,country,is_default)
VALUES
(1,'Home','Street 1','Istanbul','34000','Turkey',1),
(2,'Home','Street 2','Ankara','06000','Turkey',1),
(3,'Office','Street 3','Izmir','35000','Turkey',0),
(4,'Home','Street 4','Bursa','16000','Turkey',1),
(5,'Home','Street 5','Antalya','07000','Turkey',1);

INSERT INTO Orders(Ouser_id,Oadress_id,order_date,status,total_amount)
VALUES
(1,1,GETDATE(),'Preparing',35500),
(2,2,GETDATE(),'Delivered',300),
(3,3,GETDATE(),'Preparing',2000),
(4,4,GETDATE(),'Cancelled',450),
(5,5,GETDATE(),'Delivered',1200);

INSERT INTO Orderitems(Oorder_id,Oproduct_id,quantity,unit_price)
VALUES
(1,1,1,35000),
(1,2,1,500),
(2,4,1,300),
(3,6,1,2000),
(4,5,1,450),
(5,3,1,1200);

INSERT INTO Payments(Porder_id,payment_date,amount,payment_method,status)
VALUES
(1,GETDATE(),35500,'Credit Card','Paid'),
(2,GETDATE(),300,'Cash','Paid'),
(3,GETDATE(),2000,'Credit Card','Pending'),
(4,GETDATE(),450,'Debit Card','Cancelled'),
(5,GETDATE(),1200,'Cash','Paid');

INSERT INTO Reviews(Ruser_id,Rproduct_id,rating,comment,created_at)
VALUES
(1,1,5,'Excellent laptop',GETDATE()),
(2,4,4,'Useful book',GETDATE()),
(3,6,3,'Good quality',GETDATE()),
(4,5,5,'Very comfortable',GETDATE()),
(5,3,4,'Nice keyboard',GETDATE());

SELECT *
FROM Products
WHERE price>1000;

SELECT product_name,stock
FROM Products;

SELECT *
FROM Orders
ORDER BY total_amount ASC;

SELECT *
FROM Orders 
WHERE status LIKE 'Delivered';

SELECT full_name,status
FROM Users u INNER JOIN Orders o ON
u.id=o.Ouser_id;

SELECT product_name,category_name
FROM Products p JOIN Categories c ON
p.Pcategory_id=c.id;

SELECT TOP 1 *
FROM Products
ORDER BY price DESC;

SELECT COUNT(id) AS BrojPotrebiteli
FROM Users;

SELECT *
FROM Products
WHERE price >1000;

SELECT TOP 3*
FROM Products 
ORDER BY stock DESC;

UPDATE Products
SET price = 600
WHERE product_name = 'T-Shirt' AND price = 500;

SELECT full_name,order_date,status
FROM Users u JOIN Orders o ON
u.id=o.Ouser_id;

Select product_name,category_name
FROM Products p JOIN Categories c ON
p.Pcategory_id=c.id;

SELECT u.full_name ,COUNT(o.id) AS BrojPoruchki
FROM Users u LEFT JOIN Orders o ON
u.id=o.Ouser_id
GROUP BY u.full_name;

SELECT c.category_name,COUNT(p.id) AS product_count
FROM Categories c
LEFT JOIN Products p ON c.id = p.Pcategory_id
GROUP BY c.category_name;

SELECT u.full_name , SUM(ot.quantity * ot.unit_price) AS Total_Amount
FROM Users u JOIN Orders o ON
u.id=o.Ouser_id JOIN Orderitems ot ON o.id=ot.Oorder_id
GROUP BY u.full_name;

SELECT TOP 1 *
FROM Users u JOIN Orders o ON u.id= o.Ouser_id
ORDER BY o.id DESC;

SELECT TOP 1 u.full_name,COUNT(o.id) AS order_count
FROM Users u
JOIN Orders o ON u.id = o.Ouser_id
GROUP BY u.full_name
ORDER BY COUNT(o.id) DESC;

SELECT o.id AS order_id,SUM(oi.quantity * oi.unit_price) AS real_total_amount
FROM Orders o
JOIN Orderitems oi ON o.id = oi.Oorder_id
GROUP BY o.id;

SELECT o.id AS order_id,o.total_amount AS stored_total,
SUM(oi.quantity * oi.unit_price) AS calculated_total,
(o.total_amount - SUM(oi.quantity * oi.unit_price)) AS difference
FROM Orders o
JOIN Orderitems oi ON o.id = oi.Oorder_id
GROUP BY o.id, o.total_amount;

SELECT full_name
FROM Users u JOIN Reviews r ON u.id=r.Ruser_id
WHERE r.comment IS NULL;

EXEC sp_rename 'Users.password', 'password_hash', 'COLUMN';

ALTER TABLE Users
ADD password_hash varchar(255);

ALTER TABLE Users
DROP COLUMN password;

ALTER TABLE Users 
ALTER COLUMN password_hash varchar(512);

SELECT TOP 1 p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p JOIN Orderitems oi 
ON p.id = oi.Oproduct_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

SELECT TOP 1 p.product_name ,SUM(oi.unit_price*oi.quantity) as Prime_product
FROM Products p JOIN Orderitems oi 
ON p.id=oi.Oproduct_id
GROUP BY p.product_name
ORDER BY Prime_product DESC;

SELECT p.product_name , oi.quantity
FROM Products p LEFT JOIN Orderitems oi
ON p.id=oi.Oproduct_id
WHERE oi.quantity IS NULL;

Select c.category_name , SUM(oi.unit_price * oi.quantity) as revnue
FROM Categories c JOIN Products p ON c.id=p.Pcategory_id JOIN Orderitems oi ON p.id=oi.Oproduct_id
GROUP BY c.category_name;

SELECT TOP 1 u.full_name,SUM(oi.quantity*oi.unit_price) as total_pay
FROM Users u JOIN Reviews r ON u.id=r.Ruser_id JOIN Products p ON r.Rproduct_id=p.id JOIN Orderitems oi ON p.id=oi.Oproduct_id
Group by u.full_name
Order by total_pay DESC;

SELECT c.category_name,AVG(p.price) as avg_price
FROM Categories c JOIN Products p ON c.id=p.Pcategory_id
GROUP BY c.category_name;

SELECT *
FROM Products JOIN Categories ON Products.Pcategory_id=Categories.id;

SELECT Oorder_id,COUNT(Oproduct_id) AS product_count
FROM Orderitems
GROUP BY Oorder_id
HAVING COUNT(Oproduct_id) > 1;

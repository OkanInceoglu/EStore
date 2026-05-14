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
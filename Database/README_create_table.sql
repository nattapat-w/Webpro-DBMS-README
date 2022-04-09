/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- create customer 
drop table if exists `customer`;
create table `customer`(
	`cust_id` int primary key auto_increment,
    `cust_fname` varchar(255) not null,
    `cust_lname` varchar(255) not null,
    `cust_uname` varchar(255) not null unique,
    `cust_pwd` varchar(255) not null,
    `cust_addr` text not null,
    `cust_pcode` char(5) not null,
    `cust_phone` char(10) not null,
    `cust_member` boolean not null
    );

-- create member table
drop table if exists `member`;
create table `member`(
	`customer_cust_id` int primary key,
    `cust_mail` varchar(255) not null unique,
    `point` int,
    -- customer_cust_id
    foreign key (customer_cust_id) references customer(cust_id)
    );

-- create order table
drop table if exists `order`;
create table `order`(
	`order_id` int primary key auto_increment,
    `order_amount` int not null,
    `order_price` float not null,
    `order_date` datetime not null,
    `delivery_date` date not null,
    `employee_emp_id` int not null,
    `customer_cust_id` int not null,
    foreign key (employee_emp_id) references employee(emp_id),
    foreign key (customer_cust_id) references customer(cust_id)
    );

-- create employee table
drop table if exists `employee`;
create table `employee`(
	`emp_id` int primary key auto_increment,
    `emp_fname` varchar(255) not null,
    `emp_lname` varchar(255) not null,
    `emp_phone` char(10) not null,
    `emp_uname` varchar(255) not null unique,
    `emp_pwd` varchar(255) not null
    );

-- create order_item table
drop table if exists `order_item`;
create table `order_item`(
	`item_no` int auto_increment,
    `item_quantity` int not null,
    `item_amount` float not null,
    `item_price` float not null,
    `order_order_id` int,
    `book_book_id` int not null,
    foreign key (order_order_id) references `order`(order_id),
    foreign key (book_book_id) references book(book_id),
    primary key (`item_no`,`order_order_id`)
    );

-- create book table
drop table if exists `book`;
create table `book`(
	`book_id` int primary key auto_increment,
    `book_title` varchar(255) not null,
    `book_price` float not null,
    `book_amount` int not null,
    `book_type` int not null,
    `book_cover` varchar(255) not null,
    foreign key (book_type) references `type`(type_id)
    );

-- create type table
drop table if exists `type`;
create table `type`(
	`type_id` int primary key auto_increment,
    `type_name` varchar(255) not null unique
    );

-- create author_book table
drop table if exists `author_book`;
create table `author_book`(
	`book_book_id` int,
    `aut_aut_id` int,
    foreign key (book_book_id) references book(book_id),
    foreign key (aut_aut_id) references author(aut_id),
    primary key (`book_book_id`,`aut_aut_id`)
    );

-- create author table
drop table if exists `author`;
create table `author`(
	`aut_id` int primary key auto_increment,
    `aut_pen_name` varchar(255) not null unique,
    `aut_fname` varchar(255),
    `aut_lname` varchar(255)
    );

-- create book_inflow table
drop table if exists `book_inflow`;
create table `book_inflow`(
	`inflow_no` int auto_increment,
    `inflow_price` float not null,
    `inflow_amount` int not null,
    `inflow_date` date not null,
    `book_book_id` int,
    `publisher_pub_id` int not null,
    primary key (`inflow_no`,`book_book_id`),
    foreign key (book_book_id) references book(book_id),
    foreign key (publisher_pub_id) references publisher(pub_id)
    );

-- create publisher table
drop table if exists `publisher`;
create table `publisher`(
	`pub_id` int primary key auto_increment,
    `pub_name` varchar(255) not null unique,
    `pub_phone` char(10),
    `pub_url` varchar(255) unique
    );
    
-- create book_employee table (bridge)
drop table if exists `book_employee`;
create table `book_employee`(
	`employee_emp_id` int,
    `book_book_id` int,
    `datetime` datetime not null,
    primary key (`employee_emp_id`,`book_book_id`),
    foreign key (employee_emp_id) references employee(emp_id),
    foreign key (book_book_id) references book(book_id)
    );
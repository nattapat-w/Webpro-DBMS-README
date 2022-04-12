/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-------------------------------------------------- create customer --------------------------------------------------
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

-------------------------------------------------- create member table --------------------------------------------------
drop table if exists `member`;
create table `member`(
	`customer_cust_id` int primary key,
    `cust_mail` varchar(255) not null unique,
    `point` int,
    foreign key (customer_cust_id) references customer(cust_id)
    );

-------------------------------------------------- create order table --------------------------------------------------
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

-------------------------------------------------- create employee table --------------------------------------------------
drop table if exists `employee`;
create table `employee`(
	`emp_id` int primary key auto_increment,
    `emp_fname` varchar(255) not null,
    `emp_lname` varchar(255) not null,
    `emp_phone` char(10) not null,
    `emp_uname` varchar(255) not null unique,
    `emp_pwd` varchar(255) not null
    );

-------------------------------------------------- create order_item table --------------------------------------------------
drop table if exists `order_item`;
create table `order_item`(
	`item_no` int auto_increment,
    `item_quantity` int not null,
    `item_amount` float not null default(0),
    `item_price` float not null default(0),
    `order_order_id` int,
    `book_book_id` int not null,
    foreign key (order_order_id) references `order`(order_id),
    foreign key (book_book_id) references book(book_id),
    primary key (`item_no`,`order_order_id`)
    );

-------------------------------------------------- create book table --------------------------------------------------
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

-------------------------------------------------- create type table -------------------------------------------------- 
drop table if exists `type`;
create table `type`(
	`type_id` int primary key auto_increment,
    `type_name` varchar(255) not null unique
    );

-------------------------------------------------- create author_book table --------------------------------------------------
drop table if exists `author_book`;
create table `author_book`(
	`book_book_id` int,
    `aut_aut_id` int,
    foreign key (book_book_id) references book(book_id),
    foreign key (aut_aut_id) references author(aut_id),
    primary key (`book_book_id`,`aut_aut_id`)
    );

-------------------------------------------------- create author table --------------------------------------------------
drop table if exists `author`;
create table `author`(
	`aut_id` int primary key auto_increment,
    `aut_pen_name` varchar(255) not null unique,
    `aut_fname` varchar(255),
    `aut_lname` varchar(255)
    );

-------------------------------------------------- create book_inflow table --------------------------------------------------
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

-------------------------------------------------- create publisher table --------------------------------------------------
drop table if exists `publisher`;
create table `publisher`(
	`pub_id` int primary key auto_increment,
    `pub_name` varchar(255) not null unique,
    `pub_phone` char(10),
    `pub_url` varchar(255) unique
    );
    
-------------------------------------------------- create book_employee table (bridge) --------------------------------------------------
drop table if exists `book_employee`;
create table `book_employee`(
	`employee_emp_id` int,
    `book_book_id` int,
    `datetime` datetime not null,
    primary key (`employee_emp_id`,`book_book_id`),
    foreign key (employee_emp_id) references employee(emp_id),
    foreign key (book_book_id) references book(book_id)
    );
   
   
-------------------------------------------------- insert types ---------------------------------------------
insert into `type` (type_name)
values 
        ('สยองขวัญ'),
        ('นิยาย'),
        ('การ์ตูน'),
        ('การศึกษา'),
        ('ท่องเที่ยว'),
        ('ประวัติศาสตร์'),
        ('สุขภาพ'),
        ('จิตวิทยา'),
        ('ธุรกิจ');



-------------------------------------------------- Type 1 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('ฆาตกรรมเกาะเจ้าหญิง', 290, 50, 1, '/images/ฆาตกรรมเกาะเจ้าหญิง-1.jpg'),
        ('นักสืบสื่อวิญญาณ', 355, 50, 1, '/images/นักสืบสื่อวิญญาณ-2.jpg'),
        ('ด้ายแห่งความหวัง', 319, 50, 1, '/images/ด้ายแห่งความหวัง-3.jpg'),
        ('ห้วงเหวนั้นไซร้ยากแท้หยั่งถึง', 285, 50, 1, '/images/ห้วงเหวนั้นไซร้ยากแท้หยั่งถึง-4.jpg'),
        ('นกกระจกไม่หวนคืน', 329, 50, 1, '/images/นกกระจกไม่หวนคืน-5.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('Uchida Yasuo', 'Uchida', 'Yasuo'), 
        ('Sako Aizawa', 'Sako', 'Aizawa'),
        ('Higashino Keigo', 'Higashino', 'Keigo'),
        ('อิเกอิโดะ จุง', 'อิเกอิโดะ', 'จุง'),
        ('Ichikawa Yuto', 'Ichikawa', 'Yuto');


insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('Daifuku-Lit (ไดฟุกุ-ลีท)', '024152621', 'https://www.facebook.com/DaifukuPUB/'),
        ('เจคลาส', '024266071', 'https://www.facebook.com/JClass-สำนักพิมพ์เจคลาส-1768815693405897'),
        ('แพรวสำนักพิมพ์', null, 'https://www.facebook.com/PraewPublishing/');

-------------------------------------------------- Type 2 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('คดีชุลมุนนักสืบเครื่องดูดฝุ่น', 385, 100, 2, '/images/คดีชุลมุนนักสืบเครื่องดูดฝุ่น.jpg'),
        ('แออิน รักใหม่ หัวใจเดิม', 380, 80, 2, '/images/แออิน รักใหม่ หัวใจเดิม.jpg'),
        ('วีรปริยา', 339, 70, 2, '/images/วีรปริยา.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('Andra', null, null), 
        ('ณารา', null, null),
        ('Soeda Shin', 'Soeda', 'Shin');


insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('Biblio', null, null);

-------------------------------------------------- Type 3 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('การ์ตูน Dandadan เล่ม 2', 95, 69, 3, '/images/การ์ตูน Dandadan เล่ม 2.jpg'),
        ('การ์ตูน Spy x Family เล่ม 1', 80, 20, 3, '/images/การ์ตูน Spy x Family เล่ม 1.jpg'),
        ('การ์ตูน ไขคดีกับโคนันใน 10 นาที เล่ม 1', 115, 40, 3, '/images/การ์ตูน ไขคดีกับโคนันใน 10 นาที เล่ม 1.jpg'),
        ('การ์ตูน One Piece เล่ม 99', 70, 200, 3, '/images/การ์ตูน One Piece เล่ม 99.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('Yukinobu Tatsu', 'Yukinobu', 'Tatsu'), 
        ('Tatsuya Endo', 'Tatsuya', 'Endo'),
        ('Gosho Aoyama', 'Gosho', 'Aoyama'),
        ('Eiichiro Oda', 'Eiichiro', 'Oda');


insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('นานมีบุ๊คส์, บจก.', 02754319, null),
        ('สยามอินเตอร์คอมิกส์, สนพ.', null, 'https://www.facebook.com/Siamintercomics/');


-------------------------------------------------- Type 4 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values 
        ('ฟิสิกส์ ขนมหวาน เล่มที่ 2', 237, 10, 4, '/images/ฟิสิกส์-ขนมหวาน-เล่มที่-2.jpg'), 
        ('แบบฝึกหัดเริ่มต้นเรียนจีน 2', 67, 24, 4, '/images/แบบฝึกหัดเริ่มต้นเรียนจีน-2.jpg'),
        ('ภาษาจีนระดับกลาง 2', 239, 15, 4, '/images/ภาษาจีนระดับกลาง-2.jpg'),
        ('ภาษาจีนระดับต้น 1 (ฉบับปรับปรุง)', 256, 8, 4, '/images/ภาษาจีนระดับต้น-1.jpg'),
        ('ฝึกจับใจความ', 202, 35, 4, '/images/ฝึกจับใจความ.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values 
        ('ชวลิต เลาหอุดมพันธ์', 'ชวลิต', 'เลาหอุดมพันธ์'), 
        ('เหยิน จิ่งเหวิน', 'เหยิน', 'จิ่งเหวิน'),
        ('มณีรัตน์ สุกโชติรัตน์', 'มณีรัตน์', 'สุกโชติรัตน์');


insert into `publisher` (pub_name, pub_phone, pub_url)
values 
        ('ศูนย์หนังสือจุฬา', '022189868', 'https://www.chulabook.com'),
        ('ซีเอ็ด ยูเคชั่น บมจ.', '028268535', 'https://www.se-ed.com'),
        ('นานมี บุ๊คส์ บ.จ.ก.', '026623000', 'https://www.nanmeebooks.com');



-------------------------------------------------- Type 5 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values 
        ('ตามติดชีวิตอินเดีย', 251, 17, 5, '/images/ตามติดชีวิตอินเดีย.jpg'),
        ('คู่มือเอาชีวิตรอด', 750, 20, 5, '/images/คู่มือเอาชีวิตรอด.jpg'),
        ('โตเกียวไม่มีขา', 217, 40, 5, '/images/โตเกียวไม่มีขา.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values 
        ('ชี้ดาบ', 'ธีรนัย', 'โสตถิปิณฑะ'), 
        ('โคลินโท เวลส์', 'โคลินโท', 'เวลส์'),
        ('นิ้วกลม', 'สราวุธ', 'เฮ้งสวัสดิ์');


insert into `publisher` (pub_name, pub_phone, pub_url)
values 
        ('ชี้ดาบ', '0978616423', 'https://chidahp.page365.net'),
        ('วารา', '025423476', 'https://www.facebook.com/WaraPublishing'),
        ('KOOB', '0983928551', 'https://roundfinger.com');



-------------------------------------------------- Type 6 ---------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values 
        ('ประวัติศาสตร์ไทย', 283, 13, 6, '/images/ประวัติศาสตร์ไทย.jpg'),
        ('ประวัติศาสตร์เกาหลี', 299, 33, 6, '/images/ประวัติศาสตร์เกาหลี.jpg'),
        ('ประวัติศาสตร์ญี่ปุ่น', 217, 23, 6, '/images/ประวัติศาสตร์ญี่ปุ่น'),
        ('จดหมายเหตุของคณะบาทหลวงฝรั่งเศส', 593, 2, 6, '/images/จดหมายเหตุของคณะบาทหลวงฝรั่งเศส.jpg');


insert into `author` (aut_pen_name, aut_fname, aut_lname)
values 
        ('รงรอง วงศ์โอบอ้อม', 'รงรอง', 'วงศ์โอบอ้อม'), 
        ('บาทหลวงโลเน',null,null),
        ('อรุณ อมาตยกุล', 'อรุณ', 'อมาตยกุล');


insert into `publisher` (pub_name, pub_phone, pub_url)
values 
        ('TORCH', '028759055', null),
        ('ศรีปัญญา', '0815306631',null);



-------------------------------------------------- Type 7 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('อาหารคือยาที่ดีที่สุดของมนุษยชาติ', 199, 20, 7, '/images/อาหารคือยาที่ดีที่สุดของมนุษยชาติ-1.jpg'),
        ('พุงยุบ โรคหาย Diet For Change', 200, 19, 7, '/images/พุงยุบโรคหาย-2.jpg'),
        ('HEALTY PROJECT โครงการยกเครื่องสุขภาพดีจนรู้สึกได้ใน 4 สัปดาห์', 220, 2, 7, '/images/โครงการยกเครื่องสุขภาพดี-3.jpg');

insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('ธีระวุฒิ ปัญญา', 'ธีระวุฒิ', 'ปัญญา'), 
        ('ไรวินท์ รมย์ธีรา', 'ไรวินท์', 'รมย์ธีรา'),
        ('MADAME GURU', null, null);

insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('เพชรประกาย', '0863047038', 'https://www.phetpraguy.com/'),
        ('About book', '0984539366', 'https://www.facebook.com/aboutbookpublishing/'),
        ('Mini bear', null, null);


-------------------------------------------------- Type 8 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('101 Mindset เริ่มต้นนับหนึ่ง สู่สถานะเหนือระดับ (พิมพ์ครั้งที่ 2)', 295, 21, 8, '/images/101mindset-1.jpg'),
        ('หยั่งรู้ใจคนในทุกสถานการณ์', 195, 40, 8, '/images/หยั่งรู้ใจคนในทุกสถานการณ์-2.jpg'),
        ('นับหนึ่งถึงสำเร็จ HOW I BUILT THIS', 350, 50, 8, '/images/นับหนึ่งถึงสำเร็จ-3.jpg'),
        ('ฉันไม่ใช่ผู้ใหญ่ ฉันแค่อายุ 30', 265, 15, 8, '/images/ฉันแค่อายุ30-4.jpg');

insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('จักรภพ อินทรวงศ์', 'จักรภพ', 'อินทรวงศ์'), 
        ('Speaker', null, null),
        ('GuyRaz', 'Guy', 'Raz'),
        ('นีน่า คิม', 'นีน่า', 'คิม');

insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('เนชั่นบุ๊คส์', '020915922', 'https://www.facebook.com/NationBooksFanPage/'),
        ('Bloom', 0909096478, 'https://www.facebook.com/Bloomread/');


-------------------------------------------------- Type 9 --------------------------------------------------

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values
        ('เศรษฐีชั่วพริบตา Instant Millionaires (ปกแข็ง)', 650, 26, 9, '/images/เศรษฐีชั่วพริบตา-1.jpg'),
        ('กำไรต้องมาก่อน PROFIT FIRST', 285, 12, 9, '/images/กำไรต้องมาก่อน-2.jpg'),
        ('ทำธุรกิจให้ปังด้วยพลังการตลาดออนไลน์แล้วขายดี 24 ชั่วโมง', 245, 54, 9, '/images/ทำธุรกิจให้ปังด้วยพลังการตลาดออนไลน์-3.jpg');

insert into `author` (aut_pen_name, aut_fname, aut_lname)
values
        ('Max Gunther', 'Max', 'Gunther'), 
        ('จิตร ภูมิศักดิ์', 'จิตร', 'ภูมิศักดิ์'),
        ('เกียรติรัตน์ จินดามณี', 'เกียรติรัตน์', 'จินดามณี');

insert into `publisher` (pub_name, pub_phone, pub_url)
values
        ('แอร์โรว์ มัลติมีเดีย', '025736572', 'https://www.facebook.com/arrowclassicbooks/'),
        ('MD', null, null);


-------------------------------------------------- insert employee ---------------------------------------------

insert into employee (emp_fname, emp_lname, emp_phone, emp_uname, emp_pwd)
values 	('กนกนันทร์','สุเชาว์อินทร์','0811617970','SKanoknun',MD5('Shoppass1')),
        ('กมลชญา','ประเสริฐสิน','0873668880','PKamonchaya',MD5('Shoppass2')),
        ('เกรียงไกร','ปัญญาพงศธร','0849149827','PKringkrai',MD5('Shoppass3')),
        ('โกวิทย์','พิทยาบูรณ์','0864702511','PKowit',MD5('Shoppass4')),
        ('เกรียงศักดิ์','รักษ์ศรีทอง','0800699615','RKriangsak',MD5('Shoppass5')),
        ('คงคา','ชื่นจิต','0890609994','CKongka',MD5('Shoppass6')),
        ('จรินทร์','เก่งสงวนสิทธิ์','0852518580','KJarin',MD5('Shoppass7')),
        ('จารุวัฒน์','วงศ์จอม','0851831971','WJaruwat',MD5('Shoppass8')),
        ('เฉลิม','เพชรรัตน์','0896655593','PCharem',MD5('Shoppass9')),
        ('ณัฏฐา','สุภาสนันท์','0878866400','SNatta',MD5('Shoppass10')),
        ('ณัฐภัทร','พลอยสุภา','0818708102','PNattapat',MD5('Shoppass11')),
        ('ชูศักดิ์','สบานแย้ม','0840415309','SChusak',MD5('Shoppass12')),
        ('ชาญชัย','คมานิคม','0818411109','KChanchai',MD5('Shoppass13')),
        ('ชินวัต','ทองปรีชา','0866845396','TChinnawat',MD5('Shoppass14')),
        ('บรรเลง','ชูชาติ','0897244760','CBanleng',MD5('Shoppass15')),
        ('ปาจรีย์','ศรีสมบัติ','0870654352','SPajare',MD5('Shoppass16')),
        ('นายปัญญา','ใช้เฮ็ง','0828758271','CPanya',MD5('Shoppass17')),
        ('สิริพงษ์','กุลสุขรังสรรค์','0873167039','KSiripong',MD5('Shoppass18')),
        ('สังคม','คัดเชียงแสน','0926017970','KSangkom',MD5('Shoppass19')),
        ('สุวรรณ','ช่วยนุกูล','0851709793','CSuwan',MD5('Shoppass20')),
        ('โสภิดา','เกื้อหนองขุน','0890160084','KSopida',MD5('Shoppass21')),
        ('วิทยา','เขียวรอด','0821200689','KWitya',MD5('Shoppass22')),
        ('วิชัย','จูห้อง','0921328093','JWichai',MD5('Shoppass23')),
        ('อุไร','บุญเยี่ยม','0287191575','BUrai',MD5('Shoppass24')),
        ('นางอาภรณ์','ใหม่มงคล','0294346652','MArporn',MD5('Shoppass25')),
        ('นายอนวัช','สัตตบุศย์','0883311649','SAnawach',MD5('Shoppass26')),
        ('นายอนุชา','ตั้งพาณิชย์','0862460847','TAnucha',MD5('Shoppass27')),
        ('นายอานวย','ปองนาน','0253821760','PAnuay',MD5('Shoppass28')),
        ('นายสนอง','มะลัยขวัญ','0231877590','MSanong',MD5('Shoppass29')),
        ('นายสมมาฏฐ์','โพธิ' ,'0818391810','PSommart',MD5('Shoppass30'));


-------------------------------------------------- insert customer ---------------------------------------------

INSERT INTO customer
VALUES 
                (1, 'นางสาวอภิญญา', 'แสงจันทร์', 'Apinya', MD5('password1'), '52/39 ต.ปากเกร็ด อ.ปากเกร็ด จ.นนทบุรี', '11120', '0850002422', 1),
                (2, 'อภิชาติ', 'แสนอาจ', 'Apichart', MD5('password2'), '129 หมู่ที่ 8 ต.ตองโงบ อ.โคกสีสมบูรณ์ จ.สกลนคร', '47280', '0842653060', 1),
                (3, 'สุพัตรา', 'ทองกลม', 'Supartra', MD5('password3'), '1 หมู่ที่ 12 ต.หนองหมี อ.ราษีไศล จ.ศรีษะเกษ33160', '33160', '0868523317', 0),
                (4, 'สิริศา ', 'นิลราช', 'Sirisa', MD5('password4'), '75/158 ต.ในเมือง อ.เมือง จ.ขอนแก่น', '40000', '0874639562', 0),
                (5, 'สมปราชญ์', 'นาวาเรือน', 'Sompart', MD5('password5'), '239 หมู่ที่ 6 ต.วังสะพุง อ.วังสะพุง จ.เลย', '42130', '0897173006', 0),
                (6, 'วารุณี', 'กาทํามา', 'Varune', MD5('password6'), '86 หมู่ที่ 1 ต.โนนป่า อ.พล จ.ขอนแก่น', '40120', '0847899791', 1),
                (7, 'รัฐภูมิ', 'สิงหคํามา', 'Rattapoom', MD5('password7'), '159/54 ถ.ชาตะผดงุต.ในเมือง อ.เมือง จ.ขอนแก่น', '40000', '0817085963', 1),
                (8, 'ภาคภูมิ', 'ภาคมฤค', 'Parkpoum', MD5('password8'), '3/1 ซ.28 ถ.รณชยัชาญยุทธ อ.เมือง จ.ร้อยเอ็ด', '21130', '0816705345', 1),
                (9, 'ปัทมาภรณ์', 'รัตนประดับ', 'Patmapron', MD5('password9'), '98 หมู่ที่ 3 ถ.ศรีสวัสดิ์ อ.ประโคนชัย จ.บุรีรัมย์', '31140', '0898427990', 0),
                (10, 'นัฐพงษ์', 'เหมะธุลิน', 'Nattapon', MD5('password10'), 'อาคารสวัสดกิารทหารซ.บ.ก.สูงสุด เขตจตุจักร กรุงเทพฯ', '10900', '0842658639', 0),
                (11, 'ธงธวัฒน์', 'บัวระภา', 'Tontawat', MD5('password11'), '109 หมู่ที่ 1 ต.เขาหลวง อ.วังสะพุง จ.เลย', '42130', '0847836799', 1),
                (12, 'ทรงพล', 'พรทอง ', 'Sonpon', MD5('password12'), '89 หมู่ที่ 10 ต.นากอก อ.นิคมคําสร้อย จ.มุกดาหาร', '49130', '0835996554', 0),
                (13, 'ณัฐพร', 'เจนฬุวัน', 'Nattapron', MD5('password13'), '68/7 ซ.ประดิพันธ์ 25 ถ.ประดิพันธ์ สามเสนใน พญาไท กรุงเทพฯ', '10400', '0894778688', 0),
                (14, 'จตพุร', 'สร้อยนาค', 'Jatupron', MD5('password14'), '7/3 หมู่ที่ 3 อ.ปราสาท จ.บุรีรัมย์', '32140', '0832898657', 1),
                (15, 'อติเทพ', 'สินอํานวย', 'Atitept', MD5('password15'), '131 หมู่ที่ 1 ต.บ้านดู่ อ.อาจสามารถ จ.ร้อยเอ็ด', '45160', '0848875244', 1),
                (16, 'ววิภาพร', 'กล้าไพรี', 'Vavipron', MD5('password16'), '19/1 หมู่ที่ 6 ต.บุ้งคล้า อ.เมือง จ.ชยัภูมิ', '36000', '0857636963', 0);
        

-------------------------------------------------- insert member ---------------------------------------------

INSERT INTO member
VALUES 
		(1, 'Apinya12@gmail.com', 18),
		(2, 'Apichart51@gmail.com', 102),
		(6, 'Varune13@gmail.com', 19),
		(7, 'Rattapoom31@gmail.com', 50),
		(8, 'Parkpoum44@gmail.com', 96),
		(11, 'Tontawat75@gmail.com', 86),
		(14, 'Jatupron41@gmail.com', 20),
		(15, 'Atitept21@gmail.com', 128);
        

-------------------------------------------------- insert author_book ---------------------------------------------

insert into author_book (book_book_id, aut_aut_id)
value
		(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
		(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),
		(21,21),(22,22),(23,23),(24,24),(25,25),(26,26),(27,27),(28,28),(29,29),(30,30),
		(31,31),(32,32),(33,33),(34,34);


-------------------------------------------------- insert book_employee ---------------------------------------------

insert into book_employee (employee_emp_id,book_book_id,`datetime`)
value
		(22,30, '2021-08-24 14:30:23'),
		(13,20,'2020-10-11 02:07:57'),
		(21,20, '2021-02-03 05:23:15'),
		(21,27, '2020-10-20 05:39:00'),
		(6,30, '2020-05-27 21:11:51'),
		(11,21, '2021-04-14 02:08:47'),
		(17,13, '2020-11-17 04:14:57'),
		(27,23, '2021-03-18 23:54:58'),
		(6,25, '2021-02-04 19:56:33'),
		(27,10, '2020-07-08 13:04:27'),
		(8,20, '2020-12-20 14:39:11'),
		(16,22, '2020-12-19 19:09:09'),
		(11,9, '2020-08-07 12:54:47'),
		(15,20, '2020-10-07 16:13:02'),
		(1,5, '2020-09-16 03:27:22'),
		(6,14, '2020-11-29 01:44:19'),
		(8,31, '2021-02-06 07:26:04'),
		(10,33, '2020-06-10 17:03:58'),
		(24,27, '2020-07-30 00:08:10'),
		(22,18, '2021-03-25 06:35:32');


-------------------------------------------------- insert book_employee ---------------------------------------------

insert into book_inflow (inflow_price,inflow_amount,inflow_date,book_book_id,publisher_pub_id)
value
		(500,3,'2021-08-24',30,1),
        (250,10,'2021-03-25',2,2),
        (500,30,'2021-04-03',2,2),
        (350,20,'2020-10-07',10,15),
        (256,14,'2021-02-04',22,14),
        (400,13,'2020-10-20',5,8),
        (700,40,'2020-07-30',9,18),
        (350,20,'2020-11-07',10,15),
        (450,12,'2020-10-20',4,3),
        (450,12,'2020-12-20',4,3),
        (264,2,'2021-02-04',10,15);
        

-------------------------------------------------- insert order_item ---------------------------------------------

insert into order_item (item_quantity, item_amount,item_price, order_order_id, book_book_id)
value
		(2, 2 * 290, 290, 1, 1),
        (2, 2 * 355, 355, 1, 2),
        (2, 2 * 319, 319, 2, 3),
        (2, 2 * 285, 285, 2, 4),
        (2, 2 * 355, 355, 3, 2),
        (2, 2 * 285, 285, 3, 4),
        (2, 2 * 80, 80, 4, 10),
        (2, 2 * 115, 115, 4, 11),
        (2, 2 * 355, 355, 5, 2),
        (2, 2 * 80, 80, 5, 10),
        (2, 2 * 750, 750, 6, 19),
        (2, 2 * 217, 217, 6, 20),
        (2, 2 * 70, 70, 6, 12);
        
        
-------------------------------------------------- insert order_item ---------------------------------------------

insert into `order` (order_id,order_amount,order_price,order_date,delivery_date,employee_emp_id,customer_cust_id)
value
		(1, 4, (2*290) + (2*355), '2021-01-01', '2021-01-02', 1, 1),
        (2, 4, (2*319) + (2*285), '2021-01-03', '2021-01-04', 1, 3),
        (3, 4, (2*355) + (2*285), '2021-01-05', '2021-01-06', 4, 6),
        (4, 4, (2*80) + (2*115), '2021-02-01', '2021-02-02', 7, 9),
        (5, 4, (2*355) + (2*80), '2021-03-01', '2021-03-02', 4, 15),
        (6, 6, (2*750) + (2*217) + (2*70), '2021-04-10', '2021-04-11', 9, 1);
        
        
        
        
        
        
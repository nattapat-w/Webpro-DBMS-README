-- Type 4 --

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



-- Type 5 --

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values 
('ตามติดชีวิตอินเดีย', 251, 17, 5, '/images/ตามติดชีวิตอินเดีย.jpg'),
('คู่มือเอาชีวิตรอด', 750, 3, 5, '/images/คู่มือเอาชีวิตรอด.jpg'),
('โตเกียวไม่มีขา', 217, 9, 5, '/images/โตเกียวไม่มีขา.jpg');


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



-- Type 6 ---

insert into `book` (book_title, book_price, book_amount, book_type, book_cover)
values 
('ประวัติศาสตร์ไทย', 283, 8, 6, '/images/ประวัติศาสตร์ไทย.jpg'),
('ประวัติศาสตร์เกาหลี', 299, 4, 6, '/images/ประวัติศาสตร์เกาหลี.jpg'),
('ประวัติศาสตร์ญี่ปุ่น', 217, 9, 6, '/images/ประวัติศาสตร์ญี่ปุ่น'),
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
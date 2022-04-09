-- Type 1 --

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

-- Type 2 --

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

-- Type 3 --

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
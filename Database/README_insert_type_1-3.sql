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
('Uchida', 'Uchida', 'Yasuo'), 
('Sako', 'Sako', 'Aizawa'),
('Higashino', 'Higashino', 'Keigo'),
('อิเกอิโดะ', 'อิเกอิโดะ', 'จุง'),
('Ichikawa', 'Ichikawa', 'Yuto');


insert into `publisher` (pub_name, pub_phone, pub_url)
values
('Daifuku-Lit (ไดฟุกุ-ลีท)', '0024152621', 'https://www.facebook.com/DaifukuPUB/'),
('เจคลาส', '0024266071', 'https://www.facebook.com/JClass-สำนักพิมพ์เจคลาส-1768815693405897'),
('แพรวสำนักพิมพ์', '0123456789', 'https://www.facebook.com/PraewPublishing/');
-- แสดงข้อมูลหนังสือที่มีจำนวนเหลือน้อยกว่า 20 เล่ม และ ราคาน้อยกว่า 250 บาท

select book_id, book_title, book_amount, book_price
from book
where book_amount < 20 and book_price < 250;
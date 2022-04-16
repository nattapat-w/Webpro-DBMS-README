-- แสดงจำนวนหนังสือที่ชื่อไม่ซ้ำกันในแต่ละประเภท

select  type_id, type_name, count(book_id)
from book b 
join type t 
on (b.book_type = t.type_id)
group by type_id
-- รายงานแสดงจำนวนหนังสือและยอดขายหนังสือของผู้แต่งหนังสือแต่ละคน

select aut_pen_name as `Pen Name`, sum(item_quantity) as `Book Sold`, sum(item_amount) as `Sold Amount`
from author a 

join author_book ab 
on (a.aut_id = ab.aut_aut_id)

join book b 
on (ab.book_book_id = b.book_id)

join order_item o 
on (b.book_id = o.book_book_id)

group by a.aut_id
order by `Sold Amount` desc;
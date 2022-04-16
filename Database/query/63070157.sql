-- แสดงชื่อประเภทหนังสือและจำนวนที่ขายออกได้มากที่สุด

select type_name as `Type Name`, max(q) as `Sold`
from(
    select sum(item_quantity) as q, type_name
    from order_item o 
    join book b 
    on (o.book_book_id = b.book_id)
    join type t 
    on (b.book_type = t.type_id)
    group by book_type
) sub
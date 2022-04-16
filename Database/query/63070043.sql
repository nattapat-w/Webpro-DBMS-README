-- แสดงชื่อ นามสกุล เบอร์โทร อีเมลและแต้มสะสมของลูกค้าที่เป็นสมาชิก ที่มีแต้มมากกว่า 50

select cust_fname, cust_lname, cust_phone, cust_mail, point
from customer c 
join member m 
on (c.cust_id = m.customer_cust_id)
where m.point > 50;
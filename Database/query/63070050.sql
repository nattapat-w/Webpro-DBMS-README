-- แสดงชื่อ-นามสกุล ราคาคำสั่งซื้อและเวลาที่ทำการสั่งซื้อของลูกค้าที่มีพนักงานชื่อ "กนกนันทร์" ดูแลอยู่

select concat(cust_fname, ' ', cust_lname) as Customer,
        order_price,order_date
from customer c 
join `order` o
on (c.cust_id = o.customer_cust_id)
join employee e 
on (o.employee_emp_id = e.emp_id)
where emp_fname = 'กนกนันทร์';
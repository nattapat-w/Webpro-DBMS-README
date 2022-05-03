const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const { isLoggedIn } = require('../middlewares');

router = express.Router();

router.get('/order/:user_id', isLoggedIn, async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            "SELECT * FROM `order` WHERE customer_cust_id = ?;",
            [req.params.user_id]
        )
        return res.json(rows);
    } catch (err) {
        return res.status(500).json(err)
    }
});

router.post('/order', isLoggedIn, async function (req, res, next) {
    try {
        const [rows, fields] = await pool.query(
            "INSERT INTO `order` (`order_amount`, `order_price`, `order_date`, `delivery_date` ,`employee_emp_id`, `customer_cust_id`)"+
             "VALUES (?, ?, CURRENT_TIMESTAMP, CURDATE() + INTERVAL 2 DAY, 1, ?);",
            [req.body.order_amount, req.body.order_price, req.body.customer_cust_id]
        )
        const orderId = rows.insertId;
        // console.log(orderId);
        res.json(orderId);
    } catch (err) {
        return res.status(500).json(err)
    }
});

router.post('/order/item', isLoggedIn, async function (req, res, next) {
    console.log(req.body.item_quantity);
    console.log(req.body.item_amount);
    console.log(req.body.item_price);
    console.log(req.body.order_id);
    console.log(req.body.book_id);
    try {
        const [rows1, fields1] = await pool.query(
            "INSERT INTO `order_item` (`item_quantity`, `item_amount`, `item_price`, `order_order_id` ,`book_book_id`)"+
             "VALUES (?, ?, ?, ?, ?);",
            [req.body.item_quantity, req.body.item_amount, req.body.item_price, req.body.order_id, req.body.book_id]
        )
    } catch (err) {
        return res.status(500).json(err)
    }
});
// router.get('/order/:user_id', isLoggedIn, function (req, res, next) {
//     try{
//         // const [rows, fields] = pool.query("SELECT max(order_id) FROM `order` group by customer_cust_id HAVING customer_cust_id=? ", [
//         //     req.params.user_id,
//         // ]);
//         const [rows, fields] = pool.query("SELECT * from `order`");
//         console.log(rows);
//         return res.json(rows);
//     } catch (err){
//         return res.status(500).json(err)
//     }
// });

// router.get("/order/:user_id", function (req, res, next) {
//     // Query data from 3 tables
//     const promise5 = pool.query("SELECT max(order_id) FROM order group by customer_cust_id HAVING customer_cust_id=?", [
//       req.params.user_id
//     ]);
//     // Use Promise.all() to make sure that all queries are successful

//     Promise.all([promise5])
//       .then((results) => {
//         const orders = results[0];
//         res.json({
//           order: orders,
//         });
//       })
//       .catch((err) => {
//           console.log('test');
//         return res.status(500).json(err);
//       });
//   });

    // const promise1 = pool.query("SELECT max(order_id) FROM order group by customer_cust_id HAVING customer_cust_id=? ", [
    //     req.body.customer_cust_id,
    // ]);

    // Promise.all([promise1])
    // .then((results) => {
    // const [order_id, orderFields] = results[0];
    // res.json({
    //     order_id: order_id,
    //     error: null,
    // });
    // })
    // .catch((err) => {
    // return res.status(500).json(err);
    // });

exports.router = router;

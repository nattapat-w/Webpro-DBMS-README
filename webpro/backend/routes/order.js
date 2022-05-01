const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const { isLoggedIn } = require('../middlewares')

router = express.Router();

router.post('/order', isLoggedIn, async function (req, res, next) {
    try {
        const [rows1, fields1] = await conn.query(
            "INSERT INTO `order` (`order_amount`, `order_price`, `order_date`, `delivery_date` ,`employee_emp_id`, `customer_cust_id`)"+
             "VALUES (?, ?, CURRENT_TIMESTAMP, CURDATE() + INTERVAL 2 DAY, 1, ?);",
            [req.body.order_amount, req.body.order_price, req.body.customer_cust_id]
        )
    } catch (err) {
        return res.status(500).json(err)
    }
});

exports.router = router;

const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const { isLoggedIn } = require('../middlewares')

router = express.Router();


router.post("/member", isLoggedIn, async function (req, res, next) {
  try {
    const [rows, fields] = await pool.query(
      "INSERT INTO member(customer_cust_id, cust_mail, point)" +
      "VALUES(?, ?, 0);",
      [req.body.user_id, req.body.email]
    );
    const [rows2, fields2] = await pool.query(
        "UPDATE customer SET cust_member = 1 WHERE cust_id = ?",
        [req.body.user_id]
      );
    res.send("success!");
  } catch (err) {
      return res.status(400).json(err);
  }
});
exports.router = router;

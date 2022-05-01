const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const { isLoggedIn } = require('../middlewares')

router = express.Router();

router.get("/books/detail/:id", function (req, res, next) {
  // Query data from 3 tables
  const promise1 = pool.query("SELECT * FROM book b join type t on b.book_type = t.type_id WHERE book_id=?", [
    req.params.id
  ]);
router.put('/books/:bookId', isLoggedIn, async function (req, res, next) {
    try {
        const [rows1, fields1] = await pool.query(
            'UPDATE book SET book_title=?, book_price=?, book_amount=? WHERE book_id=?', 
            [req.body.book_title, req.body.book_price, req.body.book_amount , req.params.bookId]
        )
        res.json({ book_title: req.body.book_title,  book_price: req.body.book_price, book_amount: req.body.book_amount})
    } catch (error) {
        res.status(500).json(error)
    }
});

router.put('/books/order/:bookId', isLoggedIn, async function (req, res, next) {
  try {
      const [rows1, fields1] = await pool.query(
          'UPDATE book SET book_amount=? WHERE book_id=?', 
          [req.body.book_quantity , req.params.bookId]
      )
      console.log(rows1)
  } catch (error) {
      res.status(500).json(error)
  }
});

  // Use Promise.all() to make sure that all queries are successful
  Promise.all([promise1])
    .then((results) => {
      const [books, bookFields] = results[0];
      res.json({
        book: books[0],
        error: null,
      });
    })
    .catch((err) => {
      return res.status(500).json(err);
    });
});

exports.router = router;

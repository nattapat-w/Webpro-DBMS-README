const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");

router = express.Router();

router.get("/books/detail/:id", function (req, res, next) {
  // Query data from 3 tables
  const promise1 = pool.query("SELECT * FROM book b join type t on b.book_type = t.type_id WHERE book_id=?", [
    req.params.id
  ]);

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

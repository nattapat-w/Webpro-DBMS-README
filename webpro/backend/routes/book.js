const express = require("express");
const path = require("path");
const multer = require("multer")
const pool = require("../config");
const fs = require("fs");
const { isLoggedIn } = require('../middlewares')

router = express.Router();

const storage = multer.diskStorage({
  destination: function (req, file, callback){
    callback(null, './static/images')
  },
  filename:  function (req, file, callback){
    callback(null, file.fieldname + "-" + Date.now() + path.extname(file.originalname))
  }
})
const upload = multer({storage: storage})

router.delete('/books/:bookId', isLoggedIn, async function (req, res, next) {
  try {
      const [rows1, fields1] = await pool.query(
          'DELETE FROM `book` WHERE `book_id` = ?', 
          [req.params.bookId]
      )
  } catch (error) {
      res.status(500).json(error)
  }
});

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
} catch (error) {
    res.status(500).json(error)
}
});
//insert book
router.post("/book", upload.array('book_cover', 5), isLoggedIn, async function (req, res, next) {
    const file = req.files;
    let pathArray = [];

    if (!file) {
      return res.status(400).json({ message: "Please upload a file" });
    }
  try {
    req.files.forEach((file, index) => {
      let path = [file.path.substring(6)];
      pathArray.push(path);
    });
    console.log(pathArray[0]);
    console.log();
    const [rows, fields] = await pool.query(
      "INSERT INTO book(book_title, book_price, book_amount, book_type, book_cover)" +
      "VALUES(?, ?, ?, ?, ?);",
      [req.body.book_title, req.body.book_price, req.body.book_amount, req.body.book_type, pathArray]
    );
  } catch (err) {
      return res.status(400).json(err);
  }
    // req.files.forEach((file, index) => {
    //   let path = [blogId, file.path.substring(6), index == 0 ? 1 : 0];
    //   pathArray.push(path);
    // });

    // await conn.query(
    //   "INSERT INTO images(blog_id, file_path, main) VALUES ?;",
    //   [pathArray]
    // );

    // await conn.commit();
});

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

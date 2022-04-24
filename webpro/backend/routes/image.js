const express = require("express");
const path = require("path")
const pool = require("../config");
const fs = require("fs");

router = express.Router();

router.delete('/image/:imageId', async function (req, res, next) {
    const conn = await pool.getConnection();
    await conn.beginTransaction();

    try {
        // Get Path files from the upload folder
        const [
            images,
            imageFields,
        ] = await conn.query(
            "SELECT `file_path` FROM `images` WHERE `id` = ?",
            [req.params.imageId]
        );

        // Delete File from path
        const appDir = path.dirname(require.main.filename); // Get app root directory
        console.log(appDir)
        const p = path.join(appDir, 'static', images[0].file_path);
        fs.unlinkSync(p);

        // Delete Data from Table images
        const [rows1, fields1] = await conn.query(
            'DELETE FROM `images` WHERE `id`=?', [req.params.imageId]
        )

        // commit
        await conn.commit()
        res.json({ message: "Delete image Complete" })
    } catch (error) {
        next(error)
        await conn.rollback();
        // res.status(500).json(error)
    } finally {
        conn.release();
    }
})

router.put('/image/setmain/:blogId/:imageId', async function (req, res, next) {
    const conn = await pool.getConnection()
    await conn.beginTransaction();

    try {
        console.log(req.params)
        await conn.query(
            'UPDATE `images` SET `main`=0 WHERE `blog_id`=?;', [req.params.blogId]
            // 'UPDATE `images` SET `main`="0" WHERE `blog_id`=?'[req.params.blogId]
        )
        await conn.query(
            'UPDATE `images` SET `main`=1 WHERE `id`=?', [req.params.imageId]
            // 'UPDATE images SET main=1 WHERE id=?'[req.params.imageId]
        )
        await conn.commit()
        res.json({ message: 'Change main to ' + req.params.imageId })

    } catch (e) {
        await conn.rollback();
        next(e)
    } finally {
        conn.release();
    }
})

exports.router = router;
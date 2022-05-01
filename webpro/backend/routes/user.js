const express = require("express")
const pool = require("../config")
const Joi = require('joi')
const bcrypt = require('bcrypt');
const { generateToken } = require("../utils/token");
const { isLoggedIn } = require('../middlewares')

router = express.Router();

router.get('/user/me', isLoggedIn, async (req, res, next) => {
        // req.user ถูก save ข้อมูล user จาก database ใน middleware function "isLoggedIn"
        res.json(req.user)
    })

router.put('/user/:custId', isLoggedIn, async function (req, res, next) {
        try {
            const [rows1, fields1] = await pool.query(
                'UPDATE customer SET cust_fname=?, cust_lname=?, cust_phone=?, cust_addr=?, cust_pcode=? WHERE cust_id=?', 
                [req.body.firstname, req.body.lastname, req.body.phone, req.body.address
                , req.body.portal , req.params.custId]
            )
            console.log(rows1)
            res.json({ username: req.body.username,  firstname: req.body.firstname, lastname: req.body.lastname,
                phone: req.body.phone, address: req.body.address, portal: req.body.portal})
            // res.json({ book_title: req.body.book_title,  book_price: req.body.book_price, book_amount: req.body.book_amount})
        } catch (error) {
            res.status(500).json(error)
        }
    });
    
const loginSchema = Joi.object({
         username: Joi.string().required(),
         password: Joi.string().required()
    })

    router.post('/user/login', async (req, res, next) => {
            try {
                await loginSchema.validateAsync(req.body, { abortEarly: false })
            } catch (err) {
                return res.status(400).send(err)
            }
            const username = req.body.username
            const password = req.body.password
            const conn = await pool.getConnection()
            await conn.beginTransaction()
        
            try {
                // Check if username is correct
                const [users] = await conn.query(
                    'SELECT * FROM customer WHERE cust_uname=?', 
                    [username]
                )
                const user = users[0]
                if (!user) {
                    throw new Error('Incorrect username or password')
                }
        
                // Check if password is correct
                if (!(await bcrypt.compare(password, user.cust_pwd))) {
                    throw new Error('Incorrect username or password')
                }
        
                // Check if token already existed
                const [tokens] = await conn.query(
                    'SELECT * FROM tokens WHERE user_id=?', 
                    [user.cust_id]
                )
                let token = tokens[0]?.token
                if (!token) {
                    // Generate and save token into database
                    token = generateToken()
                    await conn.query(
                        'INSERT INTO tokens(user_id, token) VALUES (?, ?)', 
                        [user.cust_id, token]
                    )
                }
        
                conn.commit()
                res.status(200).json({'token': token})
            } catch (error) {
                conn.rollback()
                res.status(400).json(error.toString())
            } finally {
                conn.release()
            }
        })


const passwordValidator = (value, helpers) => {
    if (value.length < 8) {
        throw new Joi.ValidationError('Password must contain at least 8 characters')
    }
    if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
        throw new Joi.ValidationError('Password must be harder')
    }
    return value
}

const usernameValidator = async (value, helpers) => {
    const [rows, _] = await pool.query("SELECT cust_uname FROM customer WHERE cust_uname = ?", [value])
    if (rows.length > 0) {
        const message = 'This username is already taken'
        throw new Joi.ValidationError(message, { message })
    }
    return value
}

const signupSchema = Joi.object({
    mobile: Joi.string().required().pattern(/0[0-9]{9}/),
    first_name: Joi.string().required().max(150),
    last_name: Joi.string().required().max(150),
    password: Joi.string().required().custom(passwordValidator),
    confirm_password: Joi.string().required().valid(Joi.ref('password')),
    username: Joi.string().required().min(5).max(20).external(usernameValidator),
    address: Joi.string().required().max(150),
    pcode: Joi.string().required().min(5)
})

router.post('/user/signup', async (req, res, next) => {
    try {
        await signupSchema.validateAsync(req.body, { abortEarly: false })
    } catch (err) {
        return res.status(400).send(err)
    }

    const conn = await pool.getConnection()
    await conn.beginTransaction()

    const username = req.body.username
    const password = await bcrypt.hash(req.body.password, 5)
    const first_name = req.body.first_name
    const last_name = req.body.last_name
    const address = req.body.address
    const pcode = req.body.pcode
    const mobile = req.body.mobile

    try {
        await conn.query(
            'INSERT INTO customer(cust_uname, cust_pwd, cust_fname, cust_lname, cust_phone, cust_addr, cust_pcode, cust_member)'+
            'VALUES (?, ?, ?, ?, ?, ?, ?, 0)',
            [username, password, first_name, last_name, mobile, address, pcode]
        )
        conn.commit()
        res.status(201).send()
    } catch (err) {
        conn.rollback()
        res.status(400).json(err.toString());
    } finally {
        conn.release()
    }
})

exports.router = router
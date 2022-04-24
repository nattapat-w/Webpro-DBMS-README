# WEEK12 TUTORIAL + EXERCISE

ในสัปดาห์นี้เราจะเรียนเกี่ยวกับการทำระบบ Authentication และ Authorization โดยพระเอกในสัปดาห์นี้คือตัว [Middleware](https://expressjs.com/en/guide/using-middleware.html) ของ express.js

โดยสิ่งที่เราจะทำกันในสัปดาห์นี้คือ

1. Logger Middleware
2. Login API
3. Protected API (IsLoggedIn Middleware)
4. Login Page
5. Navigation Guard
6. ซ่อนปุ่มแก้ไข/ปุ่มลบ ใน Blog หรือ Comment ที่ไม่ใช่ของตัวเอง
7. IsOwner Middleware
8. User Role

# Setup

## Setup Database

ในสัปดาห์นี้มีการเพิ่มตารางใหม่เข้ามาใน Database คือตาราง `tokens`

```SQL
CREATE TABLE `tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_UN` (`token`),
  KEY `token_FK` (`user_id`),
  CONSTRAINT `token_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
)
```

ให้นักศึกษา drop ตารางข้อมูลเดิมที่มีอยู่ และ ทำการ import ข้อมูลจาก `db/webpro-3.sql` เข้าไปแทนที่ เพื่อใช้ใน tutorial ของสัปดาห์นี้

## Clone / Download

```bash
git clone https://github.com/it-web-pro/WEEK12-TUTORIAL-EXERCISE.git
```

## Backend Server

```bash
cd backend
npm install
npm run serve
```

## Frontend Server

```bash
cd frontend
npm install
npm run serve
```

ลองตรวจสอบดูว่าใช้งานได้

- <http://localhost:3000>
- <http://localhost:8080/#/>
- <http://localhost:8080/#/user/login>

# Tutorial

## 1. Logger Middleware

เพื่อเป็นการทำความเข้าใจพื้นฐานเกี่ยวกับ Middleware เราจะมาทดลองทำ Middleware สำหรับให้พิมพ์ request ที่เข้ามาทุกอันเช่น

```bash
Example app listening at http://localhost:3000
2021-04-27T10:19:21 | OPTIONS: /user/me
2021-04-27T10:19:21 | GET: /user/me
2021-04-27T10:19:21 | OPTIONS: /?search=
2021-04-27T10:19:21 | GET: /?search=
```

สร้าง Logger Middleware ในไฟล์ `backend/middlewares/index.js`

```javascript
-------------------------------------------------------------------
File: backend/middlewares/index.js
-------------------------------------------------------------------
+ | async function logger (req, res, next) {
+ |     const timestamp = new Date().toISOString().substring(0, 19)
+ |     console.log(`${timestamp} | ${req.method}: ${req.originalUrl}`)
+ |     next()
+ | }
  |
+ | module.exports = {
+ |     logger
+ | }
```

สั่งใช้งาน Logger Middleware ของเราในระดับ Application-Level

```javascript
-------------------------------------------------------------------
File: backend/index.js
-------------------------------------------------------------------
  | const express = require("express")
  | 
  | const app = express();
  | const cors = require('cors')
+ | const { logger } = require('./middlewares')
+ | app.use(logger)
  | app.use(cors())
  | 
  | // Statics
  | app.use(express.static('static'))
  | app.use(express.json())
  | // ...
```

ทดลองยิง request จาก Postman แล้วดูรายการ log ใน console ของ backend

## 2. Login API

ตัวอย่าง Request & Response

```txt
POST /user/login
Payload: 
    username: admin
    password: Aa123456
Response: 
    { token: "jscRQI1EC!kKdW#en@swQA5jZ9wySb5..." }
```

โค๊ด

```javascript
-------------------------------------------------------------------
File: backend/routes/user.js
-------------------------------------------------------------------
  | const express = require("express")
  | const pool = require("../config")
  | const Joi = require('joi')
  | const bcrypt = require('bcrypt');
+ | const { generateToken } = require("../utils/token");
  |
  | router.post('/user/signup', async (req, res, next) => {
  | // ...
  | })
  |
+ | const loginSchema = Joi.object({
+ |     username: Joi.string().required(),
+ |     password: Joi.string().required()
+ | })
+ | 
+ | router.post('/user/login', async (req, res, next) => {
+ |     try {
+ |         await loginSchema.validateAsync(req.body, { abortEarly: false })
+ |     } catch (err) {
+ |         return res.status(400).send(err)
+ |     }
+ |     const username = req.body.username
+ |     const password = req.body.password
+ | 
+ |     const conn = await pool.getConnection()
+ |     await conn.beginTransaction()
+ | 
+ |     try {
+ |         // Check if username is correct
+ |         const [users] = await conn.query(
+ |             'SELECT * FROM users WHERE username=?', 
+ |             [username]
+ |         )
+ |         const user = users[0]
+ |         if (!user) {    
+ |             throw new Error('Incorrect username or password')
+ |         }
+ | 
+ |         // Check if password is correct
+ |         if (!(await bcrypt.compare(password, user.password))) {
+ |             throw new Error('Incorrect username or password')
+ |         }
+ | 
+ |         // Check if token already existed
+ |         const [tokens] = await conn.query(
+ |             'SELECT * FROM tokens WHERE user_id=?', 
+ |             [user.id]
+ |         )
+ |         let token = tokens[0]?.token
+ |         if (!token) {
+ |             // Generate and save token into database
+ |             token = generateToken()
+ |             await conn.query(
+ |                 'INSERT INTO tokens(user_id, token) VALUES (?, ?)', 
+ |                 [user.id, token]
+ |             )
+ |         }
+ | 
+ |         conn.commit()
+ |         res.status(200).json({'token': token})
+ |     } catch (error) {
+ |         conn.rollback()
+ |         res.status(400).json(error.toString())
+ |     } finally {
+ |         conn.release()
+ |     }
+ | })
  |
  | exports.router = router
```

ทดสอบ API login ด้วย Postmann โดยใช้ข้อมูลดังนี้
```txt
POST /user/login
Payload: 
    username: admin
    password: Aa123456
```

ในกรณีที่ Login สำเร็จ เมื่อเปิดดูใน Database ตาราง tokens จะพบว่ามีข้อมูล tokens ถูก insert เข้ามา 1 แถว

## 3. Protected API

สร้าง Middleware สำหรับตรวจสอบว่า request มาจาก client ทีมีการ login แล้วหรือยัง?

```javascript
-------------------------------------------------------------------
File: backend/middlewares/index.js
-------------------------------------------------------------------
  | //...
+ | const pool = require("../config");
  |
+ | async function isLoggedIn (req, res, next) {
+ |     let authorization = req.headers.authorization
+ | 
+ |     if (!authorization) {
+ |         return res.status(401).send('You are not logged in')
+ |     }
+ | 
+ |     let [part1, part2] = authorization.split(' ')
+ |     if (part1 !== 'Bearer' || !part2) {
+ |         return res.status(401).send('You are not logged in')
+ |     }
+ |     
+ |     // Check token
+ |     const [tokens] = await pool.query('SELECT * FROM tokens WHERE token = ?', [part2])
+ |     const token = tokens[0]
+ |     if (!token) {
+ |         return res.status(401).send('You are not logged in')
+ |     }
+ | 
+ |     // Set user
+ |     const [users] = await pool.query(
+ |         'SELECT id, username, first_name, last_name, email, picture, mobile, join_date ' + 
+ |         'FROM users WHERE id = ?', [token.user_id]
+ |     )
+ |     req.user = users[0]
+ | 
+ |     next()
+ | }
  |
  | module.exports = {
c |     logger,
+ |     isLoggedIn
  | }
```

นำ `IsLoggedIn` Middleware มาใช้งาน

```javascript
-------------------------------------------------------------------
File: backend/routes/user.js
-------------------------------------------------------------------
  | const express = require("express")
  | const pool = require("../config")
  | const Joi = require('joi')
  | const bcrypt = require('bcrypt');
  | const { generateToken } = require("../utils/token");
+ | const { isLoggedIn } = require('../middlewares')
  |
  | //...
  |
+ | router.get('/user/me', isLoggedIn, async (req, res, next) => {
+ |     // req.user ถูก save ข้อมูล user จาก database ใน middleware function "isLoggedIn"
+ |     res.json(req.user)
+ | })
  |
  | exports.router = router
```

ในขั้นตอนนี้เราได้ทำการสร้าง middleware `isLoggedIn` เพื่อตรวจสอบ token ที่แนบมากับ header ของ request โดยนำ token ที่แนบมาไปดึงข้อมูลจากตาราง `tokens` เพื่อหา `user_id` สำหรับใช้ในการดึงข้อมูล user จากตาราง `users` ต่อไป  

## 4. Login Page

ในขั้นตอนนี้เราจะทำการ Login โดยใช้ axios ส่ง username, password ไปแลก token มาและบันทึกลง localStorage

```javascript
-------------------------------------------------------------------
File: frontend/src/views/Login.vue
-------------------------------------------------------------------
  | <template>
  |   ...
c |   <button class="button is-primary is-fullwidth" @click="submit">
  |     Login
  |   </button>
  |   ...
  | </template>
  | <script>
+ | import axios from 'axios'
  | 
  | export default {
  |   data () {
  |     return {
  |       username: '',
  |       password: '',
  |       error: ''
  |     }
  |   },
+ |   methods: {
+ |     submit () {
+ |       const data = {
+ |         username: this.username,
+ |         password: this.password
+ |       }
+ | 
+ |       axios.post('http://localhost:3000/user/login/', data)
+ |         .then(res => {
+ |           const token = res.data.token                                
+ |           localStorage.setItem('token', token)
+ |           this.$emit('auth-change')
+ |           this.$router.push({path: '/'})
+ |         })
+ |         .catch(error => {
+ |           this.error = error.response.data
+ |           console.log(error.response.data)
+ |         })
+ |     }
+ |   }
  | }
  | </script>
```

เมื่อ Login สำเร็จทำการ `$emit` event มาที่ App.vue เพื่ออัพเดต Navigation Bar

```javascript
-------------------------------------------------------------------
File: frontend/src/App.vue
-------------------------------------------------------------------
  | <template>
  |   ...
c |   <router-view :key="$route.fullPath" @auth-change="onAuthChange" />
  |   ...
  | </template>
  |
  | <script>
+ | import axios from 'axios'
  | 
  | export default {
  |   data () {
  |     return {
  |       user: null
  |     }
  |   },
+ |   mounted () {
+ |     this.onAuthChange()
+ |   },
+ |   methods: {
+ |     onAuthChange () {
+ |       const token = localStorage.getItem('token')
+ |       if (token) {
+ |         this.getUser()
+ |       }
+ |     },
+ |     getUser () {
+ |       const token = localStorage.getItem('token')
+ |       axios.get('http://localhost:3000/user/me', { headers: {Authorization: 'Bearer ' + token} }).then(res => {
+ |         this.user = res.data
+ |       })
+ |     },
+ |   }
  | }
  | </script>
```

เนื่องจากเราต้องทำ `headers` ทุกครั้งที่มีการเรียกใช้ API การที่ต้อง copy โค๊ดส่วนนี้ไปทุกครั้งก็จะทำให้มีการ Duplication เกิดขึ้น และ ทำให้โค๊ดอ่านยากขึ้นด้วย
เราสามารถใช้ [axios interceptor](https://github.com/axios/axios#interceptors) เข้ามาแก้ปัญหานี้ได้ โดย axios interceptor สามารถเขียนได้ดังในไฟล์ `frontend/src/plugins/axios.js`

```javascript
-------------------------------------------------------------------
File: frontend/src/plugins/axios.js
-------------------------------------------------------------------
import axios from 'axios'

const instance = axios.create({
    baseURL: 'http://localhost:3000',
})

instance.interceptors.request.use(
    function (config) {
        const token = localStorage.getItem('token')
        if (token) {
            config.headers['Authorization'] = `Bearer ${token}`
        }
        return config;
    },
    function (error) {
        return Promise.reject(error);
    }
);

export default instance
```

จะเห็นได้ว่าใน axios interceptor จะทำการแนบ `token` ที่บันทึกไว้ใน localStorage ไปใน header `Authorization` ด้วยทุกครั้งที่มีการส่ง request ด้วย axios

ดังนั้นในไฟล์ frontend/src/App.vue จึงไม่จำเป็นต้องแนบ `token` ไปใน header อีกต่อไป

```javascript
-------------------------------------------------------------------
File: frontend/src/App.vue
-------------------------------------------------------------------
  | <template>
  |   ...
  |   <router-view :key="$route.fullPath" @auth-change="onAuthChange" />
  |   ...
  | </template>
  |
  | <script>
c | import axios from '@/plugins/axios'
  | 
  | export default {
  |   data () {
  |     return {
  |       user: null
  |     }
  |   },
  |   mounted () {
  |     this.onAuthChange()
  |   },
  |   methods: {
  |     onAuthChange () {
  |       const token = localStorage.getItem('token')
  |       if (token) {
  |         this.getUser()
  |       }
  |     },
  |     getUser () {
- |       const token = localStorage.getItem('token')
c |       axios.get('/user/me').then(res => {
  |         this.user = res.data
  |       })
  |     },
  |   }
  | }
  | </script>
```

ลองทำการ login ในหน้า `http://localhost:8080/#/user/login` โดยใช้ username: admin และ password: Aa123456

![image](https://user-images.githubusercontent.com/77012730/163679555-65d9de81-dda4-40db-a2ee-bc853bd9252a.png)

เมื่อ login สำเร็จจะเข้าสู่หน้า Index โดยให้สังเกตที่มุมขวาของหน้าจอจะเห็น ชื่อ นามสกุล ของ user ที่ login

![image](https://user-images.githubusercontent.com/77012730/163679576-102104c5-7f0a-421a-8b9d-35cab81a4f17.png)

---

### แบบฝึกหัด

#### 4.1 ให้นำ `IsLoggedIn` Middleware ไปใช้ที่ backend route ต่อไปนี้

```txt
- POST   /blogs
- PUT    /blog/:id
- DELETE /blogs/:id
- POST   /:blogId/comments
- PUT    /comments/:commentId
- DELETE /comments/:commentId
```

#### 4.2 ใน `POST /blogs` ให้บันทึก `blogs.create_by_id` เป็น `req.user.id`

```javascript
-------------------------------------------------------------------
File: frontend/src/App.vue
-------------------------------------------------------------------
  | const express = require("express");
  | const path = require("path");
  | const pool = require("../config");
  | const fs = require("fs");
  | const multer = require("multer");
+ | const { isLoggedIn } = require('../middlewares')
  |
  | //...
  |
c | router.post("/blogs", isLoggedIn, upload.array("myImage", 5), async function (req, res, next) {
  |   const file = req.files;
  |   let pathArray = [];
  | 
  |   if (!file) {
  |     return res.status(400).json({ message: "Please upload a file" });
  |   }
  | 
  |   const title = req.body.title;
  |   const content = req.body.content;
  |   const status = req.body.status;
  |   const pinned = req.body.pinned;
  | 
  |   // Begin transaction
  |   const conn = await pool.getConnection();
  |   await conn.beginTransaction();
  | 
  |   try {
  |     let results = await conn.query(
? |       "INSERT INTO blogs(title, content, status, pinned, `like`, create_date, /* เติมเอง */) " +
? |       "VALUES(?, ?, ?, ?, 0, CURRENT_TIMESTAMP, /* เติมเอง */);",
? |       [title, content, status, pinned, /* เติมเอง */]
  |     );
  |   }
  | 
  |   // ...
  | })
```

#### 4.3 ใน `POST /:blogId/comments` ให้บันทึก `comments.comment_by_id` เป็น `req.user.id`

#### 4.4 ในทุกไฟล์ใน frontend ที่มีการเรียกใช้ axios ให้เปลี่ยน

```javascript
- | import axios from 'axios'
+ | import axios from '@/plugins/axios'
```

เพื่อเป็นการเพิ่ม Authorization Header เข้าไปในทุก ๆ Request

--- 

## 5. Navigation Guard

ในฝั่ง `frontend` เราไม่ต้องการใช้ผู้ใช้ที่ยังไม่ได้เข้าสู่ระบบเข้าสู่หน้าสร้าง Blog ได้  
เราสามารถกำหนดกฎเกณฑ์นี้ได้ด้วย [Navigation Guaurd](https://router.vuejs.org/guide/advanced/navigation-guards.html#global-before-guards) ของ Vue Router

โดย

- เพิ่ม `meta` เข้าไปในแต่ละ route โดยให้
  - `meta: { login: true }` หมายถึงต้อง login ก่อนถึงจะเข้า url นี้ได้
  - `meta: { guess: true }` หมายถึงต้องเป็น guess (ยังไม่ได้ login) ถึงจะเข้า url นี้ได้
- ใช้ `router.beforeEach` ในการตรวจสอบข้อมูล ใน `meta` และทำการ redirect ผู้ใช้ที่ไปยังที่ที่สมควรไป

```javascript
-------------------------------------------------------------------
File: frontend/src/router/index.vue
-------------------------------------------------------------------
  | const routes = [
  |   {
  |     path: '/',
  |     name: 'home',
  |     component: () => import('../views/Home.vue')
  |   },
  |   {
  |     path: '/blogs/detail/:id',
  |     name: 'detail',
  |     component: () => import('../views/blogs/DetailBlog.vue')
  |   },
  |   {
  |     path: '/blogs/create',
  |     name: 'create-blog',
+ |     meta: { login: true },
  |     component: () => import('../views/blogs/CreateBlog.vue')
  |   },
  |   {
  |     path: '/blogs/update/:id',
  |     name: 'update-blog',
+ |     meta: { login: true },
  |     component: () => import('../views/blogs/UpdateBlog.vue')
  |   },
  |   {
  |     path: '/user/signup',
  |     name: 'signup',
+ |     meta: { guess: true },
  |     component: () => import('../views/Signup.vue')
  |   },
  |   {
  |     path: '/user/login',
  |     name: 'login',
+ |     meta: { guess: true },
  |     component: () => import('../views/Login.vue')
  |   }
  | ]
  | const router = new VueRouter({ routes })
  | 
+ | router.beforeEach((to, from, next) => {
+ |   const isLoggedIn = !!localStorage.getItem('token')
+ | 
+ |   if (to.meta.login && !isLoggedIn) {
+ |     alert('Please login first!')
+ |     next({ path: '/user/login' })
+ |   }
+ | 
+ |   if (to.meta.guess && isLoggedIn) {
+ |     alert("You've already logged in")
+ |     next({ path: '/'})
+ |   }
+ | 
+ |   next()
+ | })
  | 
  | export default router
```

## 6. ซ่อนปุ่มแก้ไข/ปุ่มลบ ใน Blog หรือ Comment ที่ไม่ใช่ของตัวเอง

ใน `frontend/src/App.vue` ส่งข้อมูล user ให้ child-component โดย

```javascript
-------------------------------------------------------------------
File: frontend/src/App.vue
-------------------------------------------------------------------
  | <template>
  |   ...
c |   <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" />
  |   ...
  | </template>
```

ใน `frontend/src/views/Home.vue` รับ Props `user` มาจาก `App.vue`

```javascript
-------------------------------------------------------------------
File: frontend/src/views/Home.vue
-------------------------------------------------------------------
  | <script>
  | import axios from "@/plugins/axios";
  | // @ is an alias to /src
  | export default {
  |   name: "Home",
+ |   props: ['user'],
  |   data() {
  |     return {
  |       search: "",
  |       blogs: [],
  |     };
  |   },
  |   // ...
  | }
  | </script>
```

เมื่อเข้าถึงข้อมูล `user` ได้แล้วเราก็สามารถตรวจสอบความเป็นเจ้าของ blog ได้โดย

```javascript
-------------------------------------------------------------------
File: frontend/src/views/Home.vue
-------------------------------------------------------------------
  | <template>
  |   ...
  |   <a
+ |     v-if="isBlogOwner(blog)"
  |     class="card-footer-item"
  |     @click="$router.push({name:'update-blog',params:{id:blog.id}})"
  |   >
  |     <span class="icon-text">
  |       <span>Edit</span>
  |     </span>
  |   </a>
  |   ...
  | </template>
  |
  | <script>
  | export default {
  |   // ...
  | 
  |   methods: {
  |     // ...
+ |     isBlogOwner (blog) {
+ |       if (!this.user) return false
+ |       return blog.create_by_id === this.user.id
+ |     }
  |   }
  | }
  | </script>
```

---

### แบบฝึกหัด

#### 6.1 ใน `frontend/src/views/blogs/DetailBlog.vue` ให้ซ่อนปุ่ม Delete this blog ถ้าไม่ใช่ blog ของตัวเอง

#### 6.2 ใน `frontend/src/views/blogs/DetailBlog.vue` ให้ซ่อนปุ่ม แก้ไขและปุ่มลบ Comment ใน Comment ที่ไม่ใช่ Comment ของตัวเอง

---

## 7. IsOwner Middleware

ในฝั่ง backend เราก็ควรที่จะป้องกันไม่ให้ผู้ใช้ทำการแก้ไข/ลบ Blog ที่ไม่ใช้ของตัวเองได้  

สร้าง Middlware ชื่อว่า `blogOwner`

```javascript
-------------------------------------------------------------------
File: backend/routes/blog.js
-------------------------------------------------------------------
  | const express = require("express");
  | const path = require("path");
  | const pool = require("../config");
  | const fs = require("fs");
  | const multer = require("multer");
  | const { isLoggedIn } = require("../middlewares");
  | 
+ | const blogOwner = async (req, res, next) => {
+ |   const [[blog]] = await pool.query('SELECT * FROM blogs WHERE id=?', [req.params.id])
+ | 
+ |   if (blog.create_by_id !== req.user.id) {
+ |     return res.status(403).send('You do not have permission to perform this action')
+ |   }
+ | 
+ |   next()
+ | }
```

ใช้ Middlware `blogOwner` กับ route ที่เกี่ยวข้องกับการแก้ไข/ลบ Blog

```javascript
-------------------------------------------------------------------
File: backend/routes/blog.js
-------------------------------------------------------------------
c | router.put("/blogs/:id", isLoggedIn, blogOwner, upload.array("myImage", 5), async function (req, res, next) {
  |   // ...
  | });
  | 
c | router.delete("/blogs/:id", isLoggedIn, blogOwner, async function (req, res, next) {
  |   // ...
  | });
```

---

### แบบฝึกหัด

#### 7.1 สร้างและใช้งาน middleware เพื้อป้องกันไม่ให้ผู้ใช้ทำการแก้ไข/ลบ Comment ที่ไม่ใช่ของตัวเอง

---

## 8. User Role

เพื่อไม่ให้มีเนื้อหาที่ไม่เหมาะสมอยู่ใน Web ของเรา เราจึงควรมี admin ที่สามารถ แก้ไข/ลบ Blog หรือ Comment ของผู้ใช้อื่นได้  
โดยให้มีผู้ใช้ 2 ระดับคือ

- normal
- admin

แก้ไข Database Schema โดยเพิ่ม คอลัมน์ `role` เข้าไปในตาราง `users`
โดยให้ค่า default เป็น `normal`

```SQL
ALTER TABLE `webpro`.`users` 
ADD COLUMN `role` VARCHAR(10) NOT NULL DEFAULT 'normal' AFTER `join_date`;
```

ใน `backend/middlewares/index.js` แก้ไข Middleware `isLoggedIn` ให้ดึง role มาจากฐานข้อมูลด้วย

```javascript
-------------------------------------------------------------------
File: backend/middlewares/index.js
-------------------------------------------------------------------
  | //...
  |
  | async function isLoggedIn (req, res, next) {
  |     let authorization = req.headers.authorization
  | 
  |     if (!authorization) {
  |         return res.status(401).send('You are not logged in')
  |     }
  | 
  |     let [part1, part2] = authorization.split(' ')
  |     if (part1 !== 'Bearer' || !part2) {
  |         return res.status(401).send('You are not logged in')
  |     }
  |     
  |     // Check token
  |     const [tokens] = await pool.query('SELECT * FROM tokens WHERE token = ?', [part2])
  |     const token = tokens[0]
  |     if (!token) {
  |         return res.status(401).send('You are not logged in')
  |     }
  | 
  |     // Set user
  |     const [users] = await pool.query(
c |         'SELECT id, username, first_name, last_name, email, picture, mobile, join_date, role ' + 
  |         'FROM users WHERE id = ?', [token.user_id]
  |     )
  |     req.user = users[0]
  | 
  |     next()
  | }
  |
  | module.exports = {
  |     logger,
  |     isLoggedIn
  | }
```

ใน `backend/routes/blog.js` แก้ไข Middleware `blogOwner` ให้ทำการ by-pass ผู้ใช้ที่เป็น admin

```javascript
-------------------------------------------------------------------
File: backend/routes/blog.js
-------------------------------------------------------------------
  | const blogOwner = async (req, res, next) => {
+ |   if (req.user.role === 'admin') {
+ |     return next()
+ |   }
  |
  |   const [[blog]] = await pool.query('SELECT * FROM blogs WHERE id=?', [req.params.id])
  | 
  |   if (blog.create_by_id !== req.user.id) {
  |     return res.status(403).send('You do not have permission to perform this action')
  |   }
  | 
  |   next()
  | }
```

---

### แบบฝึกหัด

#### 8.1 ทำการ by-pass ให้ผู้ใช้ที่เป็น admin สามารถแก้ไข Comment ของคนอื่นได้

#### 8.2 ทำให้ผู้ใช้ที่เป็น admin สามารถมองเห็นปุ่มลบ/แก้ไข Blog และ Comment ของคนอื่นได้

---

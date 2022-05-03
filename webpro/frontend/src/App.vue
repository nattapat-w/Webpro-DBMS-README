<template>
  <div id="app">
    <!-- nav bar -->
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item is-size-4" style="color:white">
          README
        </router-link>

        <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu">
        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">
            หมวดหมู่
          </a>
          <div class="navbar-dropdown has-background-red">
            <a class="navbar-item" @click="filterType = 0">
              ทั้งหมด
              </a>
            <a class="navbar-item" @click="filterType = 1">
              สยองขวัญ
              </a>
            <a class="navbar-item" @click="filterType = 2">
              นิยาย
              </a>
            <a class="navbar-item" @click="filterType = 3">
              การ์ตูน
              </a>
            <a class="navbar-item" @click="filterType = 4">
              การศึกษา
              </a>
            <a class="navbar-item" @click="filterType = 5">
              ท่องเที่ยว
              </a>
            <a class="navbar-item" @click="filterType = 6">
              ประวัติศาสตร์
              </a>
            <a class="navbar-item" @click="filterType = 7">
              สุขภาพ
              </a>
            <a class="navbar-item" @click="filterType = 8">
              จิตวิทยา
              </a>
            <a class="navbar-item" @click="filterType = 9">
              ธุรกิจ
              </a>
          </div>
        </div>
        <div class="navbar-end">
          <div v-if="user" class="navbar-item">
            <router-link to="/order" class="button mr-5 is-info">
              <strong>Show Order</strong>
            </router-link>
            <router-link to="/checkout" class="button" style="background-color: #8FB0AA;color:black">
            <!-- Cart ({{this.cart.reduce((total, curr) => (total = total + (parseInt(curr.quantity))), 0)}}) -->
              <strong>Cart ({{this.cart.reduce((total, curr) => (total = total + (parseInt(curr.quantity))), 0)}})</strong>
            </router-link>
          </div>
          <div v-if="isAdmin()" class="navbar-item">
            <router-link to="/books/create" class="button is-warning">
              <strong>Add Book</strong>
            </router-link>
          </div>
          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <span class="icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                <path d="M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm89.6 32h-16.7c-22.2 10.2-46.9 16-72.9 
                16s-50.6-5.8-72.9-16h-16.7C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 
                48-48v-41.6c0-74.2-60.2-134.4-134.4-134.4z"/></svg>
              </span>
              <span class="pl-3">{{ user.cust_fname }} {{ user.cust_lname }}</span>
            </a>
            <div class="navbar-dropdown">
              <router-link :to="`/user/me`">
              <a class="navbar-item">Profile</a>
              </router-link>
              <a class="navbar-item" @click="logOut()">Log out</a>
            </div>
          </div>

          <div v-if="!user" class="navbar-item">
            <router-link to="/user/login">
              <a class="has-text-white">Login</a>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/signup">
              <a class="has-text-white">Signup</a>
            </router-link>
          </div>
        </div>
      </div>
    </nav>
    
    <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" :cart="cart" :filterType="filterType" />
  </div>
</template>
<style>

@font-face {
  font-family: "Kanit";
  src: local("Kanit"),
   url(./fonts/Kanit-Regular.ttf) format("truetype");
}
body{
  background-color: #B2E7E8;
  padding: 0;
  margin: 0;
  width: 100%;
  min-height: 100vh;
}
#app{
  font-family: 'Kanit', sans-serif;
}
.button{
  font-family: 'Kanit', sans-serif;
}
.button:hover{
  background-image: linear-gradient(rgba(0, 0, 0, 0.2) 0 0);
}
.navbar-item .navbar-link{
  color: white;
}
.navbar-item:hover .navbar-link{
  color: black;
}
.section{
  font-family: 'Kanit', sans-serif;
}
.navbar-menu{
  background-color: #304D63;
}
.navbar-brand{
  background-color: #304D63;
}
.navbar-brand:hover{
  filter: brightness(75%);
}
.input{
  font-family: 'Kanit', sans-serif;
}
option{
  font-family: 'Kanit', sans-serif;
}
label{
  font-family: 'Kanit', sans-serif;
}
</style>
<script>
import axios from "@/plugins/axios";
export default {
  data () {
    return {
      user: null,
      filterType: 0,
      cart: [],
    }
  },
   mounted () {
     this.onAuthChange()
   },
   methods: {
     logOut () {
       localStorage.clear(),
       window.location.reload()
     },
     onAuthChange () {
       const token = localStorage.getItem('token')
       if (token) {
         this.getUser()
       }
     },
     getUser () {
       axios.get('/user/me').then(res => {
         this.user = res.data
       })
     },
     isAdmin (){
       if(!this.user) return false
       if (this.user.role === 'admin'){
         return true
       }
       else{
         return false
       }
     }
   },
}
</script>
<template>
  <div id="app">
    <!-- nav bar -->
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item is-size-4">
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
          <div class="navbar-dropdown">
            <a class="navbar-item">
              สยองขวัญ
              </a>
            <a class="navbar-item">
              นิยาย
              </a>
            <a class="navbar-item">
              การ์ตูน
              </a>
            <a class="navbar-item">
              การศึกษา
              </a>
            <a class="navbar-item">
              ท่องเที่ยว
              </a>
            <a class="navbar-item">
              ประวัติศาสตร์
              </a>
            <a class="navbar-item">
              สุขภาพ
              </a>
            <a class="navbar-item">
              จิตวิทยา
              </a>
            <a class="navbar-item">
              ธุรกิจ
              </a>
          </div>
        </div>
        <div class="navbar-end">
          <div v-if="user" class="navbar-item">
            <router-link to="/checkout" class="button is-primary">
              <strong>Cart ({{this.cart.reduce((total, curr) => (total = total + (parseInt(curr.quantity))), 0)}})</strong>
            </router-link>
          </div>
          <div v-if="user" class="navbar-item">
            <router-link to="/books/create" class="button is-primary">
              <strong>Add Book</strong>
            </router-link>
          </div>
          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <figure class="image is-24x24 my-auto">
                <img class="is-rounded" src="https://bulma.io/images/placeholders/128x128.png">
              </figure>
              <span class="pl-3">{{ user.cust_fname }} {{ user.cust_lname }}</span>
            </a>
            <div class="navbar-dropdown">
              <router-link :to="`/user/me`">
              <a class="navbar-item">Profile</a>
              </router-link>
              <a class="navbar-item">Log out</a>
            </div>
          </div>

          <div v-if="!user" class="navbar-item">
            <router-link to="/user/login">
              <strong>Login</strong>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/signup">
              <strong>Signup</strong>
            </router-link>
          </div>
        </div>
      </div>
    </nav>
    
    <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" :cart="cart" />
  </div>
</template>
<style scoped>
</style>
<script>
import axios from "@/plugins/axios";
export default {
  data () {
    return {
      user: null,
      cart: [],
    }
  },
   mounted () {
     this.onAuthChange()
   },
   methods: {
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
   }
}
</script>
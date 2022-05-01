<template>
  <div class="container is-fluid mt-6">
    <div class="columns is-centered">

      <div class="column is-5">
        <h1 class="title has-text-centered">เข้าสู่ระบบ</h1>

        <p
          v-if="error"
          class="px-3 py-2 mb-3 has-text-danger-dark has-background-danger-light"
        >
          {{ error }}
        </p>

        <!-- Login form -->
        <div class="field">
          <label class="label">ชื่อผู้ใช้งาน / Username</label>
          <div class="control has-icons-left">
            <input v-model="username" class="input" type="text" placeholder="ชื่อผู้ใช้งาน"/>
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <label class="label">รหัสผ่าน / Password</label>
          <div class="control has-icons-left has-icons-right">
            <input v-model="password" class="input" type="password" placeholder="รหัสผ่าน"/>
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fas fa-check"></i>
            </span>
          </div>
        </div>

        <button class="button is-fullwidth mt-4" @click="submit">
         เข้าสู่ระบบ
        </button>

        <p class="my-3">
          ยังไม่มีบัญชี ? <a href="/#/user/signup">สร้างบัญชี</a>
        </p>
      </div>
    </div>
  </div>
</template>
<style scoped>
.button{
  background-color: #304D63;
  color: white;
}
.button:hover{
  background-color: #243b4c;
}
.container{
  height: 633px;
}
</style>
<script>
import axios from '@/plugins/axios'

export default {
  data () {
    return {
      username: '',
      password: '',
      error: ''
    }
    },
    methods: {
     submit () {
       const data = {
         username: this.username,
         password: this.password
       }
 
       axios.post('http://localhost:3000/user/login/', data)
         .then(res => {
           const token = res.data.token                                
           localStorage.setItem('token', token)
           this.$emit('auth-change')
           this.$router.push({path: '/'})
         })
         .catch(error => {
           this.error = error.response.data
           console.log(error.response.data)
         })
   }
  }
}
</script>
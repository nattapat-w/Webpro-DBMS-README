<template>
  <div class="container is-fluid mt-6">
    <div class="columns is-centered">

      <div class="column is-5">
        <h1 class="title">Log in</h1>

        <p
          v-if="error"
          class="px-3 py-2 mb-3 has-text-danger-dark has-background-danger-light"
        >
          {{ error }}
        </p>

        <!-- Login form -->
        <div class="field">
          <label class="label">Username</label>
          <div class="control has-icons-left">
            <input v-model="username" class="input" type="text" />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <label class="label">Password</label>
          <div class="control has-icons-left has-icons-right">
            <input v-model="password" class="input" type="password" />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fas fa-check"></i>
            </span>
          </div>
        </div>

        <button class="button is-primary is-fullwidth mt-4" @click="submit">
          Login
        </button>

        <p class="my-3">
          Don't have an account yet? <a href="/#/user/signup">Sign up</a>
        </p>
      </div>
    </div>
  </div>
</template>
<style scoped>

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
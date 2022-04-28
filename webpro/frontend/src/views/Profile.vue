<template>
    <section class="hero">
      <div class="hero-body">
      </div>
      <div class="container is-fluid">
          <div class="columns is-centered">
          <div class="column is-5">
            <p class="title">ชื่อผู้ใช้งาน : {{user.cust_uname}}</p>
            <p class="title">ชื่อ : {{user.cust_fname}}</p>
            <p class="title">นามสกุล : {{user.cust_lname}}</p>
            <p class="title">เบอร์โทร์ศัพท์ : {{user.cust_phone}}</p>
            <p class="title">ที่อยู่ : {{user.cust_addr}}</p>
            <p class="title">รหัสไปรษณีย์ : {{user.cust_pcode}}</p>
            <p class="title" v-if="user.cust_member==0">การเป็นสมาชิก : ไม่เป็นสมาชิก</p>
            <p class="title" v-if="user.cust_member!=0">การเป็นสมาชิก : เป็นสมาชิก</p>
            <button class="button is-primary" v-if="user.cust_member==0" @click="addMember()">สมัครสมาชิก</button>
            <div v-if="addMemberToggle === true" class="media-content">
                <div class="content mt-5">
                <p class="title">Email: </p><input v-model="memberEmail" class="input" type="text" />
            </div>
            <div class="level-item">
                <button @click="addMemberToggle = false" class="button is-info is-outlined">
                    <span>Cancel</span>
                    <span class="icon is-small">
                    <i class="fas fa-times"></i>
                    </span>
                </button>
                </div>
        </div>
          </div>
          </div>
    </div>
    </section>
</template>
<style scoped>
.title{
    font-size: 20px;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
    props: ['user'],
  data () {
    return {
      error: null,
      addMemberToggle: false,
      memeberEmail: "",
      email: ""
    };
  },
  methods: {
      addMember() {
        this.addMemberToggle = true;
      }
  }
};
</script>
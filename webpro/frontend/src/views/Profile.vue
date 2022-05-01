<template>
    <section class="hero">
      <div class="container is-fluid mt-6">
          <div class="columns is-centered">
              <div class="card">
                  <header class="card-header">
                    <p class="card-header-title is-centered">
              <span class="icon is-medium m-3">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                <path d="M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm89.6 32h-16.7c-22.2 10.2-46.9 16-72.9 
                16s-50.6-5.8-72.9-16h-16.7C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 
                48-48v-41.6c0-74.2-60.2-134.4-134.4-134.4z"/></svg>
              </span>
                    Profile
                    </p>
                    </header>
          <div class="column is-5-centered" v-if="editToggle === false">
            <div class="p1">ชื่อผู้ใช้งาน : {{user.cust_uname}}</div>
            <div class="p1">ชื่อ : {{user.cust_fname}}</div>
            <div class="p1">นามสกุล : {{user.cust_lname}}</div>
            <div class="p1">เบอร์โทร์ศัพท์ : {{user.cust_phone}}</div>
            <div class="p1">ที่อยู่ : {{user.cust_addr}}</div>
            <div class="p1">รหัสไปรษณีย์ : {{user.cust_pcode}}</div>
            <div class="p1" v-if="user.cust_member==0">การเป็นสมาชิก : ไม่เป็นสมาชิก</div>
            <div class="p1" v-if="user.cust_member!=0">การเป็นสมาชิก : เป็นสมาชิก / แต้มสะสม : 50 แต้ม</div>
            <!-- <p class="title" v-if="user.cust_member!=0">Email : {{member.cust_mail}}</p>
            <p class="title" v-if="user.cust_member!=0">แต้มสะสม : {{member.point}}</p> -->
            <div style="justify-content: flex-end; display:flex">
            <button class="button is-warning" @click="editProfile()"><p>แก้ไขข้อมูลส่วนตัว</p></button>
            <button class="button is-primary" v-if="user.cust_member==0" @click="addMember()">สมัครสมาชิก</button>
            </div>
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
          <div class="column is-5-centered " v-if="editToggle === true">
        <div class="p1">ชื่อผู้ใช้งาน : {{user.cust_uname}}</div>
            <p class="p1">ชื่อ : 
        <input type="text" class="input ml-4 mr-4" style="width: 60%" v-model="editFirstname"/>
        </p>
            <p class="p1">นามสกุล : 
        <input type="text" class="input ml-4 mr-4" style="width: 60%" v-model="editLastname"/>
        </p>
            <p class="p1">เบอร์โทร์ศัพท์ : 
        <input class="input ml-4 mr-4" style="width: 60%" v-model="editPhone"/>
        </p>
        <p class="p1"> ที่อยู่ : 
        <textarea class="textarea" v-model="editAddress"></textarea>
        </p>
            <!-- <p class="p1">ที่อยู่ : 
        <input type="text" class="textarea ml-4 mr-4" style="width: 60%" v-model="editAddress"/>
        </p> -->
            <p class="p1">รหัสไปรษณีย์ : 
        <input type="text" class="input ml-4 mr-4" style="width: 60%" v-model="editPortal"/>
        </p>
            <div class="p1" v-if="user.cust_member==0">การเป็นสมาชิก : ไม่เป็นสมาชิก</div>
            <div class="p1" v-if="user.cust_member!=0">การเป็นสมาชิก : เป็นสมาชิก / แต้มสะสม : 50 แต้ม</div>
            <!-- <p class="title" v-if="user.cust_member!=0">Email : {{member.cust_mail}}</p>
            <p class="title" v-if="user.cust_member!=0">แต้มสะสม : {{member.point}}</p> -->
            <div style="justify-content: flex-end; display:flex">
            <button class="button is-success mr-4" @click="saveEditProfile(user.cust_id)"><p>ยืนยัน</p></button>
            <button class="button is-warning" @click="editToggle = false"><p>ยกเลิก</p></button>
            <button class="button is-primary" v-if="user.cust_member==0" @click="addMember()">สมัครสมาชิก</button>
            </div>
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
      </div>
    </section>
</template>
<style scoped>
.card{
    margin-top: 25px;
    box-shadow: 1px 1px 8px 1px #000000;
}
.title{
    font-size: 25px;
    margin: 25px;
}
.card-header-title{
    font-size: 50px;
    color: black;
    background-color: #ED8975;
}
input{
  font-size: 25px;
  margin-bottom: 20px;
  line-height: 0px;
  height: 1.5em;
}
textarea{
  font-family: 'Kanit', sans-serif;
  font-size: 25px;
}
p{
    font-family: 'Kanit', sans-serif;
    font-size: 20px;
}
.p1{
    font-size: 25px;
    margin: 15px;
    display: block;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
    props: ['user'],
  data () {
    return {
      error: null,
      editToggle: false,
      editFirstname: "",
      editLastname: "",
      editPhone: "",
      editAddress: "",
      editPortal: "",
      addMemberToggle: false,
      memeberEmail: "",
      email: ""
    };
  },
  methods: {
    editProfile(){
      this.editToggle = true
      this.editFirstname = this.user.cust_fname
      this.editLastname = this.user.cust_lname
      this.editPhone = this.user.cust_phone
      this.editAddress = this.user.cust_addr
      this.editPortal = this.user.cust_pcode
    },
    addMember() {
      this.addMemberToggle = true;
    },
    saveEditProfile(custId) {
      axios
        .put(`http://localhost:3000/user/${custId}`, {
          firstname: this.editFirstname,
          lastname: this.editLastname,
          phone: this.editPhone,
          address: this.editAddress,
          portal: this.editPortal,
        })
        .then((response) => {
          this.user.cust_fname = response.data.firstname;
          this.user.cust_lname = response.data.lastname;
          this.user.cust_phone = response.data.phone;
          this.user.cust_addr = response.data.address;
          this.user.cust_pcode = response.data.portal;
          this.editToggle = false;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
  }
};
</script>
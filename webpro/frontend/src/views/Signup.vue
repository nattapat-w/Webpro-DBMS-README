<template>
  <div>
    <div class="container is-fluid mt-6">
      <div class="columns is-centered">
        <div class="column is-5">
          <h1 class="title has-text-centered">สมัครสมาชิก</h1>
          <!-- Sign up form -->
          <div class="field">
            <label class="label">ชื่อผู้ใช้งาน / Username</label>
            <div class="control has-icons-left">
              <input
                v-model="$v.username.$model"
                :class="{ 'is-danger': $v.username.$error }"
                class="input"
                type="text" placeholder="ชื่อผู้ใช้งาน"
              />
              <span class="icon is-small is-left">
                <i class="fas fa-user"></i>
              </span>
            </div>
            <template v-if="$v.username.$error">
              <p class="help is-danger" v-if="!$v.username.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.username.minLength">
                Must be at least 5 characters
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">รหัสผ่าน / Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.password.$model"
                :class="{ 'is-danger': $v.password.$error }"
                class="input"
                type="password" placeholder="รหัสผ่าน"
              />
              <span class="icon is-small is-left">
                <i class="fas fa-lock"></i>
              </span>
            </div>
            <template v-if="$v.password.$error">
              <p class="help is-danger" v-if="!$v.password.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.password.minLength">
                Must be at least 8 character
              </p>
              <p class="help is-danger" v-if="!$v.password.complex">
                Password too easy
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">ยืนยันรหัสผ่าน / Confirm Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.confirm_password.$model"
                :class="{ 'is-danger': $v.confirm_password.$error }"
                class="input"
                type="password" placeholder="ยืนยันรหัสผ่าน"
              />
              <span class="icon is-small is-left">
                <i class="fas fa-lock"></i>
              </span>
            </div>
            <template v-if="$v.confirm_password.$error">
              <p class="help is-danger" v-if="!$v.confirm_password.sameAs">
                Password not match
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">ชื่อ / First Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.first_name.$model"
                :class="{ 'is-danger': $v.first_name.$error }"
                class="input"
                type="text" placeholder="ชื่อ"
              />
                <span class="icon is-small is-left">
                  <i class="fas fa-info-circle"></i>
                </span>
            </div>
            <template v-if="$v.first_name.$error">
              <p class="help is-danger" v-if="!$v.first_name.required">
                This field is required
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">นามสกุล / Last Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.last_name.$model"
                :class="{ 'is-danger': $v.last_name.$error }"
                class="input"
                type="text" placeholder="นามสกุล"
              />
                <span class="icon is-small is-left">
                  <i class="fas fa-info-circle"></i>
                </span>
            </div>
            <template v-if="$v.last_name.$error">
              <p class="help is-danger" v-if="!$v.last_name.required">
                This field is required
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">เบอร์โทรศัพท์ / Mobile Number</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.mobile.$model"
                :class="{ 'is-danger': $v.mobile.$error }"
                class="input"
                type="text" placeholder="เบอร์โทรศัพท์"
              />
              <span class="icon is-small is-left">
                <i class="fas fa-mobile"></i>
              </span>
            </div>
            <template v-if="$v.mobile.$error">
              <p class="help is-danger" v-if="!$v.mobile.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.mobile.mobile">
                Invalid Mobile Number
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">ที่อยู่ / Address</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.address.$model"
                :class="{ 'is-danger': $v.address.$error }"
                class="input"
                type="text" placeholder="ที่อยู่"
              />
                <span class="icon is-small is-left">
                  <i class="fas fa-home"></i>
                </span>
            </div>
            <template v-if="$v.address.$error">
              <p class="help is-danger" v-if="!$v.address.required">
                This field is required
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label">รหัสไปรษรีย์ / Portal code</label>
            <div class="control has-icons-left has-icons-right">
              <input
                v-model="$v.pcode.$model"
                :class="{ 'is-danger': $v.pcode.$error }"
                class="input"
                type="text" placeholder="รหัสไปรษรีย์"
              />
                <span class="icon is-small is-left">
                  <i class="fas fa-home"></i>
                </span>
            </div>
            <template v-if="$v.pcode.$error">
              <p class="help is-danger" v-if="!$v.pcode.required">
                This field is required
              </p>
            </template>
          </div>

          <button class="button is-fullwidth mt-5" @click="submit()">สมัครสมาชิก</button>

          <p class="my-3">มีบัญชีแล้ว ? <a href="/#/user/login">เข้าสู่ระบบ</a></p>
        </div>
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
</style>
<script>
import axios from '@/plugins/axios'
import {
  required,
  helpers,
  minLength,
  maxLength,
  sameAs,
} from "vuelidate/lib/validators";

function mobile(value) {
  return !helpers.req(value) || !!value.match(/0[0-9]{9}/);
}

function complexPassword(value) {
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    return false;
  }
  return true;
}

export default {
  data() {
    return {
      username: "",
      password: "",
      confirm_password: "",
      mobile: "",
      first_name: "",
      last_name: "",
      address: "",
      pcode: ""
    };
  },
  methods: {
    submit() {
      // Validate all fields
      this.$v.$touch();

      // เช็คว่าในฟอร์มไม่มี error
      if (!this.$v.$invalid) {
        let data = {
          username: this.username,
          password: this.password,
          confirm_password: this.confirm_password,
          address: this.address,
          pcode: this.pcode,
          mobile: this.mobile,
          first_name: this.first_name,
          last_name: this.last_name,
        };

        axios
          .post("http://localhost:3000/user/signup", data)
          .then((res) => {
            alert("Sign up Success");
          })
          .catch((err) => {
            alert(err.response.data.details.message)
          });
      }
    },
  },
  validations: {
    mobile: {
      required: required,
      mobile: mobile,
    },
    password: {
      required: required,
      minLength: minLength(8),
      complex: complexPassword,
    },
    confirm_password: {
      sameAs: sameAs("password"),
    },
    username: {
      required: required,
      minLength: minLength(5),
      maxLength: maxLength(20),
    },
    first_name: {
      required: required,
    },
    last_name: {
      required: required,
    },
    address: {
      required: required,
    },
    pcode: {
      required: required,
      minLength: minLength(5),
    },
  },
};
</script>
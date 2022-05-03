<template>
  <div class="container is-widescreen">
    <section class="section" v-if="error">
      <div class="container is-widescreen">
        <div class="notification is-danger">
          <!-- <%= error.code + ': ' + error.sqlMessage %> -->
          <!---->
          {{ error }}
        </div>
      </div>
    </section>
    <section class="hero">
      <div class="hero-body" style="text-align: center">
        <div class="title">เพิ่มหนังสือ</div>
      </div>
    </section>
     <div class="columns is-centered">
    <div class="card mb-6 pl-3 pr-3 pt-2 pb-4" style="width:50%">
      <input
        class="mb-5"
        multiple
        type="file"
        accept="image/png, image/jpeg, image/webp"
        @change="selectImages"
      />

      <div v-if="images" class="columns is-multiline">
        <div v-for="(image, index) in images" :key="image.id" class="column">
          <div class="card">
            <div class="card-image">
              <figure class="image is-4by3">
                <img :src="showSelectImage(image)" alt="Placeholder image" />
              </figure>
            </div>
            <footer class="card-footer">
              <a @click="deleteSelectImage(index)" class="card-footer-item has-text-danger">Delete</a>
            </footer>
          </div>
        </div>
      </div>

      <div class="field">
        <label class="label">ชื่อหนังสือ</label>
        <div class="control">
          <input v-model="bookTitle" class="input" type="text" placeholder="ชื่อหนังสือ" />
        </div>
      </div>
      <div class="field">
        <label class="label">ราคา</label>
        <div class="control">
          <input v-model="bookPrice" class="input" type="number" placeholder="ราคา" />
        </div>
      </div>
      <div class="field">
        <label class="label">จำนวน</label>
        <div class="control">
          <input v-model="bookAmount" class="input" type="number" placeholder="สินค้าคงเหลือ" />
        </div>
      </div>
    <div class="field">
      <div class="label">เลือกหมวดหมู่</div>
      <div class="control">
        <div class="select">
          <select v-model="bookType">
            <option value="0">เลือกหมวดหมู่</option>
            <option value="1">สยองขวัญ</option>
            <option value="2">นิยาย</option>
            <option value="3">การ์ตูน</option>
            <option value="4">การศึกษา</option>
            <option value="5">ท่องเที่ยว</option>
            <option value="6">ประวัติศาสตร์</option>
            <option value="7">สุขภาพ</option>
            <option value="8">จิตวิทยา</option>
            <option value="9">ธุรกิจ</option>
          </select>
          
        </div>
      </div>
    </div>

      <div class="field is-grouped mt-2 is-pulled-right">
        <div class="control">
          <button @click="submitBook" class="button is-link">ยืนยัน</button>
        </div>
        <div class="control">
          <button @click="$router.go(-1)" class="button is-link is-light">ยกเลิก</button>
        </div>
      </div>
    </div>
  </div>
  </div>
</template>
<style scoped>
.title{
  font-size: 50px;
}
select {
  font-family: "Kanit", sans-serif;
}
</style>
<script>
import axios from '@/plugins/axios'

export default {
  data() {
    return {
      book: {},
      error: null,
      images: [], // array of image
      bookTitle: "",
      bookPrice: "",
      bookAmount: "",
      bookType: 0,
    };
  },
  methods: {
    selectImages(event) {
      this.images = event.target.files;
      console.log(this.images);
      console.log(this.images[0]);
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    deleteSelectImage(index) {
      console.log(this.images);
      this.images = Array.from(this.images);
      this.images.splice(index, 1);
    },
    submitBook (){
      if(this.bookType === 0){
        alert('กรุณาเลือกหมวดหมู๋')
      }
      else if(this.bookTitle === "" || this.bookPrice === "" || this.bookAmount === ""){
        alert('กรุณากรอกข้อมูลให้ครบทุกช่อง')
      }
      else{
        let formData = new FormData();
        formData.append("book_title", this.bookTitle);
        formData.append("book_price", this.bookPrice);
        formData.append("book_amount", this.bookAmount);
        formData.append("book_type", this.bookType);
         this.images.forEach((image) => {
        formData.append("book_cover", image);
      });
      axios
        .post("http://localhost:3000/book", formData)
        .then((response) => {
          alert(response.data)
        }).catch((error) => {
            this.error = error.message;
        });
     }
    },
  }
  };
    // submitBlog() {
    //   let formData = new FormData();
    //   formData.append("title", this.titleBlog);
    //   formData.append("content", this.contentBlog);
    //   formData.append("pinned", this.pinnedBlog ? 1 : 0);
    //   formData.append("status", "01");
    //   this.images.forEach((image) => {
    //     formData.append("myImage", image);
    //   }
    //   );
    //   axios
    //     .post("http://localhost:3000/blogs", formData)
    //     .then((res) => this.$router.push({name: 'home'}))
    //     .catch((e) => console.log(e.response.data));
    // },

      // Note ***************
      // ตอนเรายิง Postmant จะใช้ fromData
      // ตอนยิงหลาย ๆ รูปพร้อมกันใน Postman จะเป็นแบบนี้

      // title   | "This is a title of blog"
      // comment | "comment in blog"
      // ...
      // myImage | [select file 1]
      // myImage | [select file 2]
      // myImage | [select file 3]

      // จะสังเกตุว่าใช้ myImage เป็น key เดียวกัน เลยต้องเอามา loop forEach
      // พอไปฝั่ง backend มันจะจัด file ให้เป็น Array เพื่อเอาไปใช้งานต่อได้
</script>
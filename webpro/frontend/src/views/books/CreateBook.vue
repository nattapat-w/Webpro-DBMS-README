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
    <div class="card mb-6 pl-3 pr-3 pt-2 pb-4" style="width:350px">
      <input
        class="mb-5"
        multiple
        type="file"
        accept="image/png, image/jpeg, image/webp"
        @change="selectImages"
      />

      <div v-if="images" class="columns is-multiline">
        <div v-for="(image, index) in images" :key="image.id" class="column is-one-quarter">
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
          <select>
            <option>สยองขวัญ</option>
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
    };
  },
  methods: {
    selectImages(event) {
      this.images = event.target.files;
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
    submitBlog() {
      let formData = new FormData();
      formData.append("title", this.titleBlog);
      formData.append("content", this.contentBlog);
      formData.append("pinned", this.pinnedBlog ? 1 : 0);
      formData.append("status", "01");
      this.images.forEach((image) => {
        formData.append("myImage", image);
      }
      );

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

      axios
        .post("http://localhost:3000/blogs", formData)
        .then((res) => this.$router.push({name: 'home'}))
        .catch((e) => console.log(e.response.data));
    },
  },
};
</script>
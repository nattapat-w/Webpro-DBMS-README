<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title-1 mb-5">{{typeTitle}}</p>
        <div class="columns">
          <div class="column is-half">
            <input class="input" type="text" v-model="search" placeholder="ค้นหาหนังสือ" />
          </div>
          <div class="column is-half">
            <button @click="getBooks" class="button" style="background-color: #304D63;color: white">Search</button>
            <button @click="clearSearch" class="button ml-4" style="background-color: #ED8975;color: white">Clear</button>
          </div>
        </div>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="columns is-multiline">
          <div class="column is-2" v-for="book in filterBooks" :key="book.book_id">
            <router-link class="card" :to="`/books/detail/${book.book_id}`">
            <div class="card">
              <div class="card-image pt-3">
                <figure class="image" >
                  <img
                    :src="imagePath(book.book_cover)"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content">
                <div class="title pb-3">{{ book.book_title }}</div>
                <div class="subtitle is-6">
                <strong>ราคา: </strong>{{book.book_price}} บาท<br>
                <strong>สินค้าคงเหลือ: </strong>{{book.book_amount}} ชิ้น <br>
                <strong>หมวดหมู่: </strong>{{book.type_name}}
                </div>
                <!-- <div class="content" style="height: 30px;">{{ shortContent(book.book_price) }}</div> -->
              </div>
              <footer class="card-footer">
              </footer>
            </div>
            </router-link>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.card:hover {
  box-shadow: 1px 1px 8px 1px #545454;
  transform: scale(1.05);
}
.card{
  transition: 0.2s;
}
.image{
  box-shadow: 1px 0.5px 4px 1px rgb(15, 15, 15);
  background-size: cover;
}
.title{
  font-size: 20px;
}
.title-1{
  font-size: 50px;
  font-weight: bold;
  color: black;
}
</style>

<script>
import axios from '@/plugins/axios'
// @ is an alias to /src
export default {
  name: "Home",
  props: ['user', 'filterType'],
  data() {
    return {
      search: "",
      books: [],
    };
  },
  mounted() {
    this.getBooks();
  },
  computed: {
    filterBooks (){
      if(this.filterType === 0){
        return this.books
      }
      return this.books.filter((val) => val.book_type === this.filterType)
    },
    typeTitle (){
      // if(this.filterType !== 0){
      //   return "หนังสือ"+this.books.filter((val) => val.book_type === this.filterType)[0].type_name
      // }else{
      //   return "หนังสือทั้งหมด"
      // }
      if(this.filterType === 1) {return "หนังสือสยองขวัญ"}
      if(this.filterType === 2) {return "หนังสือนิยาย"}
      if(this.filterType === 3) {return "หนังสือการ์ตูน"}
      if(this.filterType === 4) {return "หนังสือการศึกษา"}
      if(this.filterType === 5) {return "หนังสือท่องเที่ยว"}
      if(this.filterType === 6) {return "หนังสือประวัติศาสตร์"}
      if(this.filterType === 7) { return "หนังสือสุขภาพ"}
      if(this.filterType === 8) {return "หนังสือจิตวิทยา"}
      if(this.filterType === 9) {return "หนังสือธุรกิจ"}
      return "หนังสือทั้งหมด"
    }
  },
  methods: {
    getBooks() {
      axios
        .get("http://localhost:3000", {
          params: {
            search: this.search,
          },
        })
        .then((response) => {
          this.books = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    clearSearch() {
      this.search = '';
      this.getBooks();
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    // shortContent(content) {
    //   if (content.length > 200) {
    //     return content.substring(0, 197) + "...";
    //   }
    //   return content;
    // },
    // addLike(blogId) {
    //   axios
    //     .put(`http://localhost:3000/blogs/addlike/${blogId}`)
    //     .then((response) => {
    //       let selectedBlog = this.blogs.filter((e) => e.id === blogId)[0];
    //       selectedBlog.like = response.data.like;
    //     })
    //     .catch((err) => {
    //       console.log(err);
    //     });
    // },
    isAdmin() { //เช็คว่าเป็น admin ไหม
       if (!this.user) return false
        if (this.user.cust_uname === "admin3"){  //ทำให้ชื่อ admin3 มองเห็นปุ่ม edit  password:Aa123456
         return true
       }
       else{
         return false
       }
     }
  },
};
</script>

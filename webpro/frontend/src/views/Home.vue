<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title">Book</p>
        <div class="columns">
          <div class="column is-half">
            <input class="input" type="text" v-model="search" placeholder="Search book(s)" />
          </div>
          <div class="column is-half">
            <button @click="getBooks" class="button">Search</button>
          </div>
        </div>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="columns is-multiline">
          <div class="column is-3" v-for="book in books" :key="book.book_id">
            <div class="card">
              <div class="card-image pt-5">
                <figure class="image">
                  <img
                    style="height: 400px"
                    :src="imagePath(book.book_cover)"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content">
                <div class="title">{{ book.book_title }}</div>
                <!-- <div class="content" style="height: 30px;">{{ shortContent(book.book_price) }}</div> -->
              </div>
              <footer class="card-footer">
                <a class="card-footer-item">
                    <router-link class="card-footer-item" :to="`/books/detail/${book.book_id}`">View Product</router-link>
                </a>
                <p class="card-footer-item">
                  <span class="icon-text">
                    <span>{{book.book_price}} บาท</span>
                  </span>
                </p>
                 <!-- <a class="card-footer-item">
                  <span class="icon-text">
                    <span>Edit</span>
                  </span>
                </a> -->
              </footer>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
// @ is an alias to /src
export default {
  name: "Home",
  props: ['user'],
  data() {
    return {
      search: "",
      books: [],
    };
  },
  mounted() {
    this.getBooks();
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
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    shortContent(content) {
      if (content.length > 200) {
        return content.substring(0, 197) + "...";
      }
      return content;
    },
    addLike(blogId) {
      axios
        .put(`http://localhost:3000/blogs/addlike/${blogId}`)
        .then((response) => {
          let selectedBlog = this.blogs.filter((e) => e.id === blogId)[0];
          selectedBlog.like = response.data.like;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    isBlogOwner(blog) {
      // console.log(blog.create_by_id);
       if (!this.user) return false
        if (this.user.role === "admin"){  //ทำให้ admin มองเห็นปุ่ม delete blog
         return true
       } else{
       return blog.create_by_id === this.user.id
       }
     }
  },
};
</script>

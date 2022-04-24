<template>
    <section class="hero">
      <div class="hero-body">
        <p class="title">{{ book.book_title }}</p>
      </div>
      <div class="columns">
          <div class="column">
                <figure class="image">
                <img
                  :src="'http://localhost:3000/'+book.book_cover"
                  alt="Placeholder image"
                  style="width: 500px; height:700px; margin-left:50px"
                />
              </figure>
          </div>
          <div class="column">
            <p class="title">{{book.book_title}}</p>
            <p class="title">ราคา: {{book.book_price}}</p>
            <p class="title">สินค้าคงเหลือ: {{book.book_amount}}</p>
            <p class="title">ประเภท: {{book.type_name}}</p>
        </div>
    </div>
    </section>
</template>

<script>
import axios from '@/plugins/axios'

export default {
  data() {
    return {
      book: {},
      error: null,
    };
  },
  mounted() {
    this.getBookDetail(this.$route.params.id);
  },
  methods: {
    getBookDetail(bookId) {
      axios
        .get(`http://localhost:3000/books/detail/${bookId}`)
        .then((response) => {
          this.book = response.data.book;
        })
        .catch((error) => {
          this.error = error.response.data.message;
        });
    }
  },
};
</script>
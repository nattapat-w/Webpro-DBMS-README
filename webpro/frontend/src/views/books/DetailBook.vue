<template>
    <section class="hero">
      <div class="hero-body">
      </div>
      <div class="columns">
          <div class="column">
                <figure class="image">
                <img
                  :src="'http://localhost:3000/'+book.book_cover"
                  alt="Placeholder image"
                  style="width: 400px; height:500px; margin-left:150px"
                />
              </figure>
          </div>
          <div class="column">
            <p class="title">ชื่อหนังสือ: {{book.book_title}}</p>
            <p class="title">ราคา: {{book.book_price}} บาท</p>
            <p class="title">สินค้าคงเหลือ: {{book.book_amount}} เล่ม</p>
            <p class="title">หมวดหมู่: {{book.type_name}}</p>
            <div class="button is-success is-medium">
              <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24"><path d="M10 19.5c0 .829-.672 1.5-1.5 
            1.5s-1.5-.671-1.5-1.5c0-.828.672-1.5 1.5-1.5s1.5.672 1.5 1.5zm3.5-1.5c-.828 0-1.5.671-1.5 1.5s.672 1.5 
            1.5 1.5 1.5-.671 1.5-1.5c0-.828-.672-1.5-1.5-1.5zm1.336-5l1.977-7h-16.813l2.938 7h11.898zm4.969-10l-3.432 
            12h-12.597l.839 2h13.239l3.474-12h1.929l.743-2h-4.195z"/></svg> สั่งซื้อสินค้า</div>
        </div>
    </div>
    </section>
</template>
<style>
svg{
  margin-right: 8px;
}
</style>
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
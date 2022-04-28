<template>
<div class="container is-max-desktop p-5">
<div class="column pt-6 pl-0 pr-0">
  <div class="card mb-5" style="height: 210px" v-for="book in cart" :key="book.book_id">
    <div class="card-content p-3">
      <div class="media">
        <div class="media-left">
          <figure class="image is-128x128">
            <img :src="imagePath(book.book_cover)"
            alt="Placeholder image">
          </figure>
        </div>
        <div class="media-content pt-3 pl-3">
          <p class="detail">{{ book.book_title }}</p>
          <p class="detail">ราคา:  {{ book.book_price }}</p>
          <p class="detail">จำนวน:  {{ book.quantity}}</p>
          <p class="detail">ราคารวม:  {{ book.quantity*book.book_price}}</p>
          <div style="display: flex; justify-content: space-between">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</template>
<style scoped>
.detail{
    font-size: 30px;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
  props: ["cart"],
  data() {
    return {};
  },
  mounted() {},
  methods: {
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
  },
};
</script>
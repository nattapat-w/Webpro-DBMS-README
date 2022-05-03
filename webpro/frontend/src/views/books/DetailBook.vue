<template>
  <section class="hero">
    <div class="columns mt-6">
      <div class="column is-1">
      </div>
      <div class="column is-3">
        <figure class="image">
          <img
            :src="'http://localhost:3000/' + book.book_cover"
            alt="Placeholder image"
          />
        </figure>
      </div>
      <div class="column is-1">
      </div>
      <div class="column is-6" v-if="editToggle === false">
      <div class="card">
          <header class="card-header">
            <p class="card-header-title is-centered">{{ book.book_title }}</p>
          </header>
        <div class="text">
        <p class="title">ราคา : {{ book.book_price }} บาท</p>
        <p class="title">สินค้าคงเหลือ : {{ book.book_amount }} เล่ม</p>
        <p class="title">หมวดหมู่ : {{ book.type_name }}</p>
        <div class="button is-medium mt-3 ml-4 mb-6"  @click="addToCart(book)" style="background-color: #8FB0AA;color:black">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="30"
            height="30"
            viewBox="0 0 24 24"
          >
            <path
              d="M10 19.5c0 .829-.672 1.5-1.5 
            1.5s-1.5-.671-1.5-1.5c0-.828.672-1.5 1.5-1.5s1.5.672 1.5 1.5zm3.5-1.5c-.828 0-1.5.671-1.5 1.5s.672 1.5 
            1.5 1.5 1.5-.671 1.5-1.5c0-.828-.672-1.5-1.5-1.5zm1.336-5l1.977-7h-16.813l2.938 7h11.898zm4.969-10l-3.432 
            12h-12.597l.839 2h13.239l3.474-12h1.929l.743-2h-4.195z"
            />
          </svg>
          สั่งซื้อสินค้า 
        </div>
        <div class="button is-medium mt-3 ml-4 mb-6 is-danger" v-if="isAdmin()" @click="editBook()">
          แก้ไขข้อมูลหนังสือ
        </div>
        </div>
      </div>
      </div>

      <!-- แก้ไขหนังสือ -->
      <div class="column is-6" v-if="editToggle === true">
      <div class="card">
          <header class="card-header">
            <p class="card-header-title is-centered">
              <input type="text" class="input ml-4 mr-2 is-large" style="width:70%" v-model="editBookTitle" placeholder="ชื่อหนังสือ" /> 
            </p>
          </header>
        <div class="text">
        <p class="title" style="display: inline" >ราคา : 
        <input type="text" class="input ml-4 mr-2" style="width:30%" v-model="editBookPrice" placeholder="ราคาหนังสือ" /> บาท</p>
        <p class="title">สินค้าคงเหลือ : 
          <input type="text" class="input ml-4 mr-2" style="width:30%" v-model="editBookAmount" placeholder="จำนวนหนังสือ" /> เล่ม</p>
        <p class="title">หมวดหมู่ : {{ book.type_name }}</p>
        <div class="button is-medium mt-3 is-success" @click="saveEditBook(book.book_id)">
          ยืนยัน
        </div>
        <div class="button is-medium mt-3 ml-4 mb-6 is-danger" @click="editToggle = false">
          ยกเลิก
        </div>
        </div>
      </div>
      </div>
    </div>
  </section>
</template>
<style scoped>
svg {
  margin-right: 8px;
}
.card-header-title{
  font-size: 50px;
  color: black;
  background-color: #ED8975;
}
img {
  box-shadow: 2px 3px 8px 1px #000000;
}
.input{
  margin-bottom: 20px;
  font-size: 30px;
  line-height: 0px;
  height: 1.5em;
}
.text{
  margin: 20px;
}
.card{
  box-shadow: 2px 3px 8px 1px #000000;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
  props: ['cart', 'user'],
  data() {
    return {
      book: {},
      error: null,
      editToggle: false,
      editBookTitle: "",
      editBookPrice: "",
      editBookAmount: "",
    };
  },
  mounted() {
    this.getBookDetail(this.$route.params.id);
  },
  methods: {
    editBook() {
      this.editToggle = true
      this.editBookTitle = this.book.book_title
      this.editBookPrice = this.book.book_price
      this.editBookAmount = this.book.book_amount
    },
    getBookDetail(bookId) {
      axios
        .get(`http://localhost:3000/books/detail/${bookId}`)
        .then((response) => {
          this.book = response.data.book;
          this.$set(this.book, "quantity", 0);
        })
        .catch((error) => {
          this.error = error.response.data.message;
        });
    },
    saveEditBook(bookId) {
      axios
        .put(`http://localhost:3000/books/${bookId}`, {
          book_title: this.editBookTitle,
          book_price: this.editBookPrice,
          book_amount: this.editBookAmount
        })
        .then((response) => {
          this.book.book_title = response.data.book_title;
          this.book.book_price = response.data.book_price;
          this.book.book_amount = response.data.book_amount;
          this.editToggle = false;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    addToCart(book) {
      if(!this.user){
        alert('กรุณาเข้าสู่ระบบก่อนทำการซื้อสินค้า')
      }
      var findProduct = this.cart.find(o => o.book_id === book.book_id)
      // console.log(findProduct);
      if(findProduct){
        findProduct.quantity += 1
      // this.book.quantity = 1
      // this.cart.push(book)
      }
      else{
        this.book.quantity += 1
        this.cart.push(book)
      }
    },
    isAdmin(){
       if(!this.user) return false
       if (this.user.role === 'admin'){
         return true
       }
       else{
         return false
       }
      }
  },
};
</script>
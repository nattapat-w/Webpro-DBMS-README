<template>
  <div class="container is-max-desktop p-5">
    <div class="column pt-6 pl-0 pr-0">
      <p class="emptyCart" v-if="this.cart.length === 0">
        ยังไม่ได้เพิ่มสินค้าในตะกร้า
      </p>
      <div
        class="card mb-5"
        style="height: 210px"
        v-for="book in cart"
        :key="book.book_id"
      >
        <div class="card-content p-3">
          <div class="media">
            <div class="media-left">
              <figure class="image is-128x128">
                <img
                  :src="imagePath(book.book_cover)"
                  alt="Placeholder image"
                />
              </figure>
            </div>
            <div class="media-content pt-3 pl-3">
              <p class="book_title">
                {{ book.book_title }} x{{ book.quantity }}
              </p>
              <p class="detail">ราคา: {{ book.book_price }} บาท</p>
              <p class="detail">จำนวน: {{ book.quantity }} เล่ม</p>
              <p class="detail">
                ราคารวม: {{ book.quantity * book.book_price }}
              </p>
              <div style="display: flex; justify-content: space-between"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="field">
      <div class="label">เลือกวิธีชำระเงิน</div>
      <div class="control">
        <div class="select">
          <select v-model="paymentMethod">
            <option>จ่ายเงินปลายทาง</option>
            <option>โอนผ่านธนาคาร</option>
            <option value="credit">บัตรเครดิต</option>
          </select>
        </div>
      </div>
    </div>
    <div v-if="paymentMethod === 'credit'">
      <div class="field">
        <label class="label">หมายเลขบัตรเครดิต / Card number</label>
        <div class="control">
          <input
            v-model="bookPrice"
            class="input"
            type="number"
            placeholder="หมายเลขบัตรเครดิต 16 หลัก"
          />
        </div>
      </div>
      <div class="field">
        <label class="label">ชื่อบนบัตร / Name on card</label>
        <div class="control">
          <input
            v-model="bookPrice"
            class="input"
            type="number"
            placeholder="Ex. John Cena"
          />
        </div>
      </div>
      <div class="columns">
        <div class="column">
          <div class="field">
            <label class="label">วันหมดอายุ / Expiry date</label>
            <div class="select">
              <select name="expireMM" id="expireMM">
                <option value="">เดือน / Month</option>
                <option value="01">มกราคม / January</option>
                <option value="02">กุมภาพันธ์ /February</option>
                <option value="03">มีนาคม /March</option>
                <option value="04">เมษายน /April</option>
                <option value="05">พฤษภาคม /May</option>
                <option value="06">มิถุนายน /June</option>
                <option value="07">กรกฎาคม /July</option>
                <option value="08">สิงหาคม /August</option>
                <option value="09">กันยายน /September</option>
                <option value="10">ตุลาคม /October</option>
                <option value="11">พฤศจิกายน /November</option>
                <option value="12">ธันวาคม /December</option>
              </select>
            </div>
            <div class="select ml-3">
              <select name="expireYY" id="expireYY">
                <option value="">ปี / Year</option>
                <option value="21">2021</option>
                <option value="22">2022</option>
                <option value="23">2023</option>
                <option value="24">2024</option>
                <option value="25">2025</option>
              </select>
            </div>
            <input
              class="inputCard"
              type="hidden"
              name="expiry"
              id="expiry"
              maxlength="4"
            />
          </div>
        </div>
        <div class="column">
          <div class="field">
            <label class="label">รหัสหลังบัตร / Security code</label>
            <div class="control">
              <input
                class="input"
                style="width: 30%"
                type="number"
                placeholder="123"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="detail" style="margin-top: 2%">
      ที่อยู่จัดส่ง : {{ user.cust_addr }} {{ user.cust_pcode }}
    </div>
    <div class="detail" style="margin-top: 2%">
      เบอร์โทร์ศัพท์ : {{ user.cust_phone }}
    </div>
    <div style="justify-content: flex-end; display: flex">
      <div
        class="button is-danger is-medium is-flex-justify-right"
        @click="clearOrder()"
      >
        Clear
      </div>
      <div
        class="button is-info ml-5 is-medium is-flex-justify-right"
        @click="confirmOrder()"
      >
        Confirm Order
      </div>
    </div>
    <div class="column pt-4 pl-0 pr-0">
      <table style="width: 100%" class="table is-bordered" v-if="tableToggle">
        <thead>
          <tr>
            <th class="has-text-centered" colspan="4">Order Detail</th>
          </tr>
          <tr>
            <th colspan="2">
              ชื่อ : {{ user.cust_fname + " " + user.cust_lname }}
            </th>
            <th colspan="1">ที่อยู่ : {{ user.cust_addr }}</th>
            <th colspan="2">เบอร์โทร์ศัพท์ : {{user.cust_phone}}</th>
          </tr>
          <tr>
            <th class="has-text-centered" colspan="4">รายการสินค้า</th>
          </tr>
          <tr>
            <th>ชื่อสินค้า</th>
            <th>ราคาต่อหน่วย</th>
            <th>จำนวน</th>
            <th>ราคารวม</th>
          </tr>
          <tr v-for="book in cart" :key="book.book_id">
            <td>{{ book.book_title }}</td>
            <td>{{ book.book_price }} บาท</td>
            <td>{{ book.quantity }} เล่ม</td>
            <td>{{ book.book_price * book.quantity }} บาท</td>
          </tr>
          <tr>
            <td colspan="2"></td>
            <td><strong>ราคารวมทั้งหมด</strong></td>
            <td>{{ this.cart.reduce((total, curr) => (total = total + (parseInt(curr.book_price)*parseInt(curr.quantity))), 0) }} บาท</td>
          </tr>
        </thead>
      </table>
    </div>
  </div>
</template>
<style scoped>
.detail {
  font-size: 20px;
}
.book_title {
  font-size: 40px;
}
select {
  font-family: "Kanit", sans-serif;
}
.emptyCart {
  font-size: 50px;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
  props: ["cart", "user"],
  data() {
    return {
      orderID: [],
      paymentMethod: "",
      tableToggle: false,
    };
  },
  mounted() {},
  methods: {
    clearOrder(){
      this.cart.splice(0, this.cart.length)
    },
    async confirmOrder() {
      if (confirm("ยืนยันคำสั่งซื้อ ?") === true) {
        this.tableToggle = true;
        let cart_amount = this.cart.reduce((total, curr) => (total = total + (parseInt(curr.quantity))), 0);
        let cart_price = this.cart.reduce((total, curr) => (total = total + (parseFloat(curr.book_price*curr.quantity))), 0);
        let user_id = this.user.cust_id;
        await axios //insert into order
          .post("http://localhost:3000/order", {
            order_amount: cart_amount,
            order_price: cart_price,
            customer_cust_id: user_id,
          }).then((response) => {
            this.orderID = response.data;
          })
          .catch((error) => {
            this.error = error.message;
          });
        console.log(this.orderID);
        for(let i=0; i<this.cart.length; i++){
          const book = this.cart[i];
          const bookId = book.book_id;
        axios
          .put(`http://localhost:3000/books/order/${bookId}`, {
            book_quantity: book.book_amount-book.quantity,
          }).then((response) => {
            console.log(response);
          })
          .catch((error) => {
            this.error = error.message;
          });
         axios
          .post(`http://localhost:3000/order/item`, {
            order_id: this.orderID,
            item_quantity: book.quantity,
            item_amount: book.quantity*book.book_price,
            item_price: book.book_price,
            book_id: book.book_id
          }).then(() => {
          })
          .catch((error) => {
            this.error = error.message;
          });
          }
          
      }
        // axios // get order_id
        //   .get(`http://localhost:3000/order/${user_id}`, {
        //   }).then((response) => {
        //     console.log(response);
        //   })
        //   .catch((error) => {
        //     this.error = error.message;
        //   });

        //  axios
        //   .post(`http://localhost:3000/order/${bookId}`, {
        //     book_quantity: book.book_amount-book.quantity,
        //   }).then(() => {
        //     alert("สั่งซื้อสำเร็จ")
        //   })
        //   .catch((error) => {
        //     this.error = error.message;
        //   });
    },
    isCredit() {
      this.credit = true;
    },
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
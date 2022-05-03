<template>
  <div class="container is-max-desktop p-5">
    <p class="emptyCart" v-if="this.orders.length === 0">
        ไม่มี ORDER
      </p>
      <div
        class="card mb-5 mt-4"
        style="height: 210px"
        v-for="order in orders"
        :key="order.order_id"
      >
        <div class="card-content">
          <div class="media">
            <div class="media-content pt-3 pl-3">
            <div class="title">ORDER</div>
              <p>จำนวน: {{ order.order_amount }} เล่ม</p>
              <p>ราคารวม: {{ order.order_price }}</p>
              <p>วันที่สั่ง: {{ order.order_date.slice(0, 10) }} เวลา: {{ order.order_date.slice(11, 19) }}</p>
              <p>วันที่จัดส่ง {{ order.delivery_date.slice(0, 10) }}</p>
            </div>
          </div>
        </div>
      </div>
      </div>
</template>
<style scoped>
.emptyCart {
  font-size: 100px;
  text-align: center;
}
</style>
<script>
import axios from "@/plugins/axios";

export default {
  name: 'order',
  props: ["user"],
  data() {
    return {
        orders: [],
    };
  },
  mounted() {
    this.getOrder();
  },
  methods: {
    getOrder() {
        const user_id = this.user.cust_id
      axios
        .get(`http://localhost:3000/order/${user_id}`, {
        })
        .then((response) => {
          this.orders = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  }
};
</script>
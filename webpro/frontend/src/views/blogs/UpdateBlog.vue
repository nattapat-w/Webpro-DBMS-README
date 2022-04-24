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
      <div class="hero-body">
        <p class="title">Edit Blog</p>
      </div>
    </section>
    <section class="px-6">
      <h1 class="is-size-4">Exist Image</h1>

      <div v-if="currentImage.length > 0" class="columns is-multiline">
        <div v-for="(image) in currentImage" :key="image.id" class="column is-one-quarter">
          <div class="card">
            <div class="card-image">
              <figure class="image is-4by3">
                <img :src="'http://localhost:3000'+image.file_path" alt="Placeholder image" />
              </figure>
            </div>
            <footer class="card-footer">
              <a
                @click="deleteCurrentImage(image.id)"
                class="card-footer-item has-text-danger"
              >Delete</a>
              <span @click="selectMainId = image.id" class="icon card-footer-item">
                <i v-if="selectMainId === image.id" class="fas fa-star mt-5"></i>
                <i v-else class="far fa-star mt-5"></i>
              </span>
            </footer>
          </div>
        </div>
      </div>
      <div class="control">
        <button @click="updateMainImage()" class="button is-link mb-2">Update Main</button>
      </div>

      <h1 class="is-size-4">New Image</h1>
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

      <div class="field mt-5">
        <label class="label">Title</label>
        <div class="control">
          <input v-model="titleBlog" class="input" type="text" placeholder="Text input" />
        </div>
      </div>

      <div class="field">
        <label class="label">Content</label>
        <div class="control">
          <textarea v-model="contentBlog" class="textarea" placeholder="Textarea"></textarea>
        </div>
      </div>

      <label class="label">Staus</label>

      <div class="control">
        <label class="radio">
          <input v-model="statusBlog" type="radio" name="answer" value="01" />
          01
        </label>
        <label class="radio">
          <input v-model="statusBlog" type="radio" name="answer" value="02" />
          02
        </label>
      </div>

      <div class="field mt-3">
        <div class="control">
          <label class="checkbox">
            <input v-model="pinnedBlog" type="checkbox" />
            Pinned
          </label>
        </div>
      </div>

      <div class="field is-grouped mb-6">
        <div class="control">
          <button @click="submitBlog()" class="button is-link">Submit</button>
        </div>
        <div class="control">
          <button @click="$router.go(-1)" class="button is-link is-light">Cancel</button>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from '@/plugins/axios'

export default {
  data() {
    return {
      selectMainId: null,
      blog: {},
      error: null,
      images: [],
      currentImage: [],
      titleBlog: "",
      contentBlog: "",
      pinnedBlog: 0,
      statusBlog: "01",
    };
  },
  created() {
    axios
      .get(`http://localhost:3000/blogs/${this.$route.params.id}`)
      .then((response) => {
        this.titleBlog = response.data.blog.title;
        this.contentBlog = response.data.blog.content;
        this.pinnedBlog = response.data.blog.pinned ? 1 : 0;
        this.statusBlog = response.data.blog.status;
        this.currentImage = response.data.images;
        this.selectMainId = this.currentImage.filter((x) => x.main === 1)[0].id;
      })
      .catch((e) => {
        console.log(e);
      });
  },
  methods: {
    selectImages(event) {
      //   console.log(URL.createObjectURL(event.target.files[0]));
      this.images = event.target.files;
    },
    showSelectImage(image) {
      return URL.createObjectURL(image);
    },
    deleteSelectImage(index) {
      console.log(this.images);
      this.images = Array.from(this.images);
      this.images.splice(index, 1);
    },

    updateMainImage() {
      console.log("ccc");
      axios
        .put(
          `http://localhost:3000/image/setmain/${this.$route.params.id}/${this.selectMainId}`
        )
        .then((response) => {
          console.log(response);
          this.$router.push({ path: "/" });
        })
        .catch((e) => {
          console.log(e);
        });
    },
    deleteCurrentImage(imageId) {
      let comfirmDeleteImage = confirm("Are you sure to delete this image");
      if (comfirmDeleteImage == true) {
        axios
          .delete("http://localhost:3000/image/" + imageId)
          .then((response) => {
            console.log("delete image ", response);
            this.$router.push({ path: "/" });
          })
          .catch((e) => {
            console.log(e);
          });
      }
    },

    submitBlog() {
      console.log(this.statusBlog);
      let formData = new FormData();
      //   formData.append("myImage", this.imageBlog);
      formData.append("title", this.titleBlog);
      formData.append("content", this.contentBlog);
      formData.append("pinned", this.pinnedBlog ? 1 : 0);
      formData.append("status", this.statusBlog);
      this.images.forEach((image) => {
        formData.append("myImage", image);
      });

      axios
        .put("http://localhost:3000/blogs/" + this.$route.params.id, formData)
        .then((res) => {
          console.log(res);
          this.$router.push({ path: "/" });
        })
        .catch((e) => console.log(e));
    },
  },
};
</script>

<style>
</style>
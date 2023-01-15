<template>
  <div class="wrapper">
    <MainPage />
  </div>
</template>

<script>

import MainPage from "./components/MainPage.vue";

export default {
  name: 'App',
  
  components: {
    MainPage,
  }
}
</script>

<style>
*, *::before, *::after {
  box-sizing: border-box;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  width: 450px;
  height: 110px;
  color: #2c3e50;
}
.wrapper{
  margin: 0 8px;
}
</style>

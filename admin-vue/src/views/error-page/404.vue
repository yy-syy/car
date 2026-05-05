<template>
  <div class="error-page">
    <div class="error-code">404</div>
    <div class="error-desc">抱歉，您访问的页面不存在</div>
    <div class="error-handle">
      <el-button type="primary" size="medium" @click="goHome">返回首页</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Page404',
  methods: {
    goHome() {
      this.$router.push({ path: '/' })
    }
  }
}
</script>

<style scoped>
.error-page {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #f3f3f3;
}

.error-code {
  font-size: 120px;
  color: #2d8cf0;
  line-height: 1;
}

.error-desc {
  font-size: 24px;
  color: #777;
  margin-top: 20px;
}

.error-handle {
  margin-top: 30px;
  padding-bottom: 200px;
}
</style>

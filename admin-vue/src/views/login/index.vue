<template>
  <div class="login">
    <div class="login-main">
      <div class="caption">
        <h4 class="caption-title">fuint汽车会员系统</h4>
        <p class="caption-remark">欢迎使用 fuint汽车会员系统，您的卡券、储值卡、计次卡等会员营销小管家！</p>
      </div>
    </div>
    <div class="login-form">
      <el-form ref="loginForm" :model="loginForm" :rules="loginRules" size="medium">
        <div class="title">
          <svg-icon icon-class="car" class-name="logo" />
          <span class="name">fuint汽车会员系统</span>
        </div>
        <el-form-item prop="username">
          <el-input
            ref="username"
            v-model="loginForm.username"
            placeholder="账号"
            name="username"
            type="text"
            tabindex="1"
            autocomplete="on"
          >
            <svg-icon slot="prefix" icon-class="user" class-name="el-input__icon input-icon" />
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            :key="passwordType"
            ref="password"
            v-model="loginForm.password"
            :type="passwordType"
            placeholder="密码"
            name="password"
            tabindex="2"
            autocomplete="on"
            @keyup.enter.native="handleLogin"
          >
            <svg-icon slot="prefix" icon-class="password" class-name="el-input__icon input-icon" />
          </el-input>
        </el-form-item>
        <el-form-item prop="captchaCode">
          <el-input
            v-model="loginForm.captchaCode"
            placeholder="请输入验证码"
            name="captchaCode"
            tabindex="3"
            style="width: 63%;"
            @keyup.enter.native="handleLogin"
          >
            <svg-icon slot="prefix" icon-class="validCode" class-name="el-input__icon input-icon" />
          </el-input>
          <div class="login-code">
            <img :src="captchaImage" @click="refreshCaptcha" class="login-code-img" />
          </div>
        </el-form-item>
        <el-checkbox v-model="loginForm.rememberMe" style="margin: 0 0 25px;">记住密码</el-checkbox>
        <el-form-item style="width: 100%;">
          <el-button
            :loading="loading"
            type="primary"
            style="width: 100%; line-height: 24px; font-size: 16px;"
            @click.native.prevent="handleLogin"
          >
            <span>立即登录</span>
          </el-button>
        </el-form-item>
      </el-form>
      <div class="copy-right">
        <span>Copyright © 2022-2025 <a href="https://www.fuint.cn" class="link">fuint.cn</a> All Rights Reserved.</span>
      </div>
    </div>
  </div>
</template>

<script>
import { getAccessToken } from '@/utils/auth'
import axios from 'axios'

export default {
  name: 'Login',
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入账号'))
      } else {
        callback()
      }
    }
    const validatePassword = (rule, value, callback) => {
      if (value.length < 6) {
        callback(new Error('密码长度不能少于6位'))
      } else {
        callback()
      }
    }
    const validateCaptcha = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入验证码'))
      } else {
        callback()
      }
    }
    return {
      loginForm: {
        username: 'fuint',
        password: '123456',
        captchaCode: '',
        uuid: '',
        rememberMe: false
      },
      loginRules: {
        username: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }],
        captchaCode: [{ required: true, trigger: 'blur', validator: validateCaptcha }]
      },
      loading: false,
      passwordType: 'password',
      redirect: undefined,
      captchaImage: ''
    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  created() {
    if (getAccessToken()) {
      this.$router.push(this.redirect || '/')
    }
    this.refreshCaptcha()
  },
  methods: {
    refreshCaptcha() {
      axios.get('/fuint-car/clientApi/captcha/getCode?' + Date.now()).then(res => {
        const result = res.data
        if (result && result.data) {
          this.captchaImage = result.data.code || ''
          this.loginForm.uuid = result.data.uuid || ''
        }
      }).catch(() => {
        this.captchaImage = ''
      })
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          const loginData = {
            username: this.loginForm.username,
            password: this.loginForm.password,
            captchaCode: this.loginForm.captchaCode,
            uuid: this.loginForm.uuid
          }
          this.$store.dispatch('user/login', loginData)
            .then(() => {
              this.loading = false
              this.$router.push(this.redirect || '/')
            })
            .catch(() => {
              this.loading = false
              this.refreshCaptcha()
            })
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.login {
  height: 100%;
  width: 100%;
  position: relative;

  .login-main {
    background-image: url('~@/assets/images/login-bg.png');
    position: fixed;
    top: 0;
    left: 0;
    right: 500px;
    bottom: 0;
    transform: translateZ(0);
    overflow: hidden;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: 50% center;

    .caption {
      background: rgba(0, 0, 0, 0.7);
      color: #fff;
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 30px 50px;
      font-size: 14px;
      z-index: 20;
      font-weight: 300;

      .caption-title {
        font-size: 30px;
        font-weight: 700;
        margin: 0 0 10px;
      }

      .caption-remark {
        margin: 0;
        opacity: 0.8;
      }
    }
  }

  .login-form {
    width: 500px;
    height: 100%;
    position: fixed;
    right: 0;
    top: 0;
    bottom: 0;
    padding: 0 60px;
    background: #fff;
    overflow-y: auto;
    box-sizing: border-box;

    .el-form {
      padding-top: 80px;
    }

    .title {
      text-align: left;
      font-size: 24px;
      color: #707070;
      padding: 20px 0 40px 0;
      white-space: nowrap;

      .logo {
        width: 28px;
        height: 28px;
        vertical-align: middle;
        color: #707070;
      }

      .name {
        margin-left: 5px;
        vertical-align: middle;
      }
    }

    .login-code {
      width: 33%;
      height: 38px;
      float: right;

      img {
        cursor: pointer;
        vertical-align: middle;
      }
    }

    .login-code-img {
      height: 38px;
      width: 100%;
    }

    ::v-deep .el-input,
    ::v-deep .el-input input {
      height: 45px;
    }

    ::v-deep .el-input__inner {
      line-height: 45px;
    }

    .input-icon {
      height: 45px;
      width: 14px;
      margin-left: 2px;
    }

    .copy-right {
      color: #888;
      text-align: center;
      font-size: 12px;
      padding: 30px 0;

      .link {
        color: #ff5b57;
        font-weight: 700;
        text-decoration: none;
      }
    }
  }
}

::v-deep .el-button--primary {
  background-color: #373f64;
  border-color: #373f64;

  &:hover {
    background-color: #4a5280;
    border-color: #4a5280;
  }
}
</style>

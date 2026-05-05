<template>
  <div class="login-container">
    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" autocomplete="on" label-position="left">
      <div class="title-container">
        <h3 class="title">fuint汽车会员系统</h3>
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
          prefix-icon="el-icon-user"
        />
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
          prefix-icon="el-icon-lock"
          @keyup.enter.native="handleLogin"
        >
          <i slot="suffix" :class="showPassword ? 'el-icon-view' : 'el-icon-hide'" @click="showPassword = !showPassword" style="cursor: pointer;" />
        </el-input>
      </el-form-item>

      <el-form-item prop="captchaCode">
        <el-col :span="14">
          <el-input
            v-model="loginForm.captchaCode"
            placeholder="请输入验证码"
            name="captchaCode"
            tabindex="3"
            prefix-icon="el-icon-key"
            @keyup.enter.native="handleLogin"
          />
        </el-col>
        <el-col :span="1" class="captcha-gap" />
        <el-col :span="9">
          <img :src="captchaImage" @click="refreshCaptcha" style="cursor: pointer; width: 100%; height: 40px; border-radius: 4px;" />
        </el-col>
      </el-form-item>

      <el-button
        :loading="loading"
        type="primary"
        style="width: 100%; margin-bottom: 30px; margin-top: 20px;"
        @click.native.prevent="handleLogin"
      >登录</el-button>
    </el-form>
  </div>
</template>

<script>
import { login } from '@/api/user'
import { getAccessToken, setAccessToken } from '@/utils/auth'

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
        callback(new Error('密码不能少于6位'))
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
        uuid: ''
      },
      loginRules: {
        username: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }],
        captchaCode: [{ required: true, trigger: 'blur', validator: validateCaptcha }]
      },
      loading: false,
      showPassword: false,
      passwordType: 'password',
      redirect: undefined,
      captchaImage: ''
    }
  },
  watch: {
    showPassword(newVal) {
      this.passwordType = newVal ? 'text' : 'password'
    },
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
      const timestamp = Date.now()
      this.captchaImage = `/fuint-car/clientApi/captcha/getCode?${timestamp}`
      this.loginForm.uuid = ''
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          const loginData = {
            username: this.loginForm.username,
            password: this.loginForm.password,
            captcha: this.loginForm.captchaCode,
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

<style lang="scss">
$bg:#283443;
$light_gray:#fff;

body {
  background: $bg;
}

.login-container {
  min-height: 100%;
  width: 100%;
  background-color: $bg;
  overflow: hidden;

  .login-form {
    position: relative;
    width: 520px;
    max-width: 100%;
    padding: 160px 35px 0;
    margin: 0 auto;
    overflow: hidden;
  }

  .tips {
    font-size: 14px;
    color: #fff;
    margin-bottom: 10px;

    span {
      &:first-of-type {
        margin-right: 16px;
      }
    }
  }

  .svg-container {
    padding: 6px 5px 18px 0;
    vertical-align: middle;
    width: 30px;
    display: inline-block;

    .svg-icon {
      font-size: 20px;
      color: $light_gray;
      vertical-align: middle;
    }
  }

  .title-container {
    position: relative;

    .title {
      font-size: 26px;
      color: $light_gray;
      margin: 0 auto 40px;
      text-align: center;
      font-weight: bold;
    }
  }

  .show-pwd {
    position: absolute;
    right: 10px;
    top: 7px;
    font-size: 16px;
    color: $light_gray;
    cursor: pointer;
    user-select: none;
  }

  .captcha-gap {
    padding-top: 2px;
  }
}
</style>


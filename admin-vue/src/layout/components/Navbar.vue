<template>
  <div class="navbar">
    <hamburger :is-active="sidebar.opened" class="hamburger-container" @toggle-click="toggleSideBar" />

    <breadcrumb class="breadcrumb-container" />

    <div class="right-menu">
      <div class="right-menu-item go-cashier" title="前往收银下单" @click="$router.push('/cashier')">
        <i class="el-icon-s-shop" />
        <span>收银开单</span>
      </div>

      <div class="right-menu-item hover-effect" title="查找功能">
        <i class="el-icon-search" />
      </div>

      <div class="right-menu-item hover-effect" title="全屏展示" @click="toggleFullScreen">
        <i :class="isFullscreen ? 'el-icon-aim' : 'el-icon-full-screen'" />
      </div>

      <div class="right-menu-item hover-effect" title="帮助文档">
        <i class="el-icon-question" />
      </div>

      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <img :src="avatar?avatar:defaultAvatar" class="user-avatar">
          <span class="name">{{ name }}</span>
          <i class="el-icon-caret-bottom" />
        </div>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="$router.push('/')">首页</el-dropdown-item>
          <el-dropdown-item divided @click.native="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Hamburger from '@/components/Hamburger'
import Breadcrumb from '@/components/Breadcrumb'
import defaultAvatar from '@/assets/images/avatar.png'

export default {
  components: {
    Hamburger,
    Breadcrumb
  },
  data() {
    return {
      defaultAvatar: defaultAvatar,
      isFullscreen: false
    }
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'name',
      'avatar'
    ])
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch('app/toggleSideBar')
    },
    toggleFullScreen() {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen()
        this.isFullscreen = true
      } else {
        document.exitFullscreen()
        this.isFullscreen = false
      }
    },
    async logout() {
      await this.$store.dispatch('user/logout')
      this.$router.push(`/login?redirect=${this.$route.fullPath}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background .3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, .025);
    }
  }

  .breadcrumb-container {
    float: left;
    line-height: 50px;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;
    display: flex;
    align-items: center;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;
      line-height: 50px;
      cursor: pointer;
      transition: background .3s;

      &:hover {
        background: rgba(0, 0, 0, .025);
      }

      &.go-cashier {
        font-size: 14px;
        color: #333;
        padding: 0 12px;

        i {
          margin-right: 4px;
          font-size: 16px;
        }
      }
    }

    .avatar-container {
      margin-right: 20px;
      margin-left: 8px;

      .avatar-wrapper {
        position: relative;
        cursor: pointer;
        display: flex;
        align-items: center;

        .user-avatar {
          cursor: pointer;
          width: 32px;
          height: 32px;
          border-radius: 50%;
          vertical-align: middle;
        }

        .name {
          margin: 0 8px;
          font-size: 14px;
        }

        .el-icon-caret-bottom {
          font-size: 12px;
        }
      }
    }
  }
}
</style>

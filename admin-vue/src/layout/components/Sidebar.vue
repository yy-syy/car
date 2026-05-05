<template>
  <div :class="['sidebar-container', {'has-logo':showLogo}]">
    <logo v-if="showLogo" :collapse="isCollapse" />
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <el-menu
        :default-active="activeMenu"
        :collapse="isCollapse"
        :background-color="variables.menuBg"
        :text-color="variables.menuText"
        :unique-opened="false"
        :active-text-color="variables.menuActiveText"
        :collapse-transition="false"
        mode="vertical"
      >
        <sidebar-item v-for="route in permission_routes" :key="route.path" :item="route" :base-path="route.path" />
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Logo from './Logo'
import SidebarItem from './SidebarItem'
import variables from '@/assets/styles/variables.scss'

export default {
  components: { SidebarItem, Logo },
  computed: {
    ...mapGetters([
      'permission_routes',
      'sidebar'
    ]),
    activeMenu() {
      const route = this.$route
      const { meta, path } = route
      if (meta.activeMenu) {
        return meta.activeMenu
      }
      return path
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo
    },
    variables() {
      return variables
    },
    isCollapse() {
      return !this.sidebar.opened
    }
  }
}
</script>

<style lang="scss" scoped>
.scrollbar-wrapper {
  overflow-x: hidden !important;
}
.sidebar-container {
  transition: width 0.28s;
  width: 210px !important;
  background-color: #304156;
  height: 100%;
  position: fixed;
  font-size: 0px;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 1001;
  overflow: hidden;

  &.has-logo {
    .el-scrollbar {
      height: calc(100% - 50px);
    }
  }

  .horizontal-collapse-transition {
    transition: 0s width ease-in-out, 0s padding-left ease-in-out, 0s padding-right ease-in-out;
  }

  .scrollbar-wrapper {
    overflow-x: hidden !important;
  }

  .el-scrollbar__bar.is-vertical {
    right: 0px;
  }

  .el-scrollbar {
    height: 100%;
  }
}

.mobile {
  .sidebar-container {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1001;
  }
}
</style>

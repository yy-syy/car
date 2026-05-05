<template>
  <div v-if="!isExternalLink" style="display: flex; align-items: center;">
    <svg-icon v-if="icon" :icon-class="icon" class="svg-icon" />
    <el-icon v-else-if="isElementIcon" :class="icon" />
    <i v-else-if="icon" :class="icon" />
    <span v-if="title" slot="title">{{ title }}</span>
  </div>
  <a v-else :href="icon" target="_blank" rel="noopener">
    <span slot="title">{{ title }}</span>
  </a>
</template>

<script>
import { isExternal as isExternalLink } from '@/utils/validate'

export default {
  name: 'MenuItem',
  props: {
    icon: {
      type: String,
      default: ''
    },
    title: {
      type: String,
      default: ''
    }
  },
  computed: {
    isExternalLink() {
      return isExternalLink(this.icon)
    },
    isElementIcon() {
      return /^el-icon-/.test(this.icon)
    }
  }
}
</script>

<style scoped>
.svg-icon {
  margin-right: 5px;
  width: 16px;
  height: 16px;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}
</style>

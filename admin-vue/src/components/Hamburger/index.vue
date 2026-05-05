<template>
  <div style="padding: 0 15px;" @click="toggleClick">
    <svg
      :class="{'is-active':isActive}"
      class="hamburger"
      viewBox="0 0 1024 1024"
      width="64"
      height="64"
    >
      <path d="M408 442.5h208c21.5 0 39 17.5 39 39s-17.5 39-39 39H408c-21.5 0-39-17.5-39-39s17.5-39 39-39zM408 254.5h208c21.5 0 39 17.5 39 39s-17.5 39-39 39H408c-21.5 0-39-17.5-39-39s17.5-39 39-39zM408 630.5h208c21.5 0 39 17.5 39 39s-17.5 39-39 39H408c-21.5 0-39-17.5-39-39s17.5-39 39-39z"/>
    </svg>
  </div>
</template>

<script>
export default {
  name: 'Hamburger',
  props: {
    isActive: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    toggleClick() {
      this.$emit('toggle-click')
    }
  }
}
</script>

<style scoped>
.hamburger {
  display: inline-block;
  vertical-align: middle;
  width: 20px;
  height: 20px;
  fill: currentColor;
}

.hamburger.is-active {
  transform: rotate(180deg);
}
</style>

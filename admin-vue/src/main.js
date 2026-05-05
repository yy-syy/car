import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import '@/assets/styles/index.scss'
import * as filters from './filters'
import VueMeta from 'vue-meta'
import VuePrintNB from 'vue-print-nb'
import './permission'
import SvgIcon from '@/components/SvgIcon'
import waves from '@/directive/waves'
import Pagination from '@/components/Pagination'

Vue.use(VueMeta)
Vue.use(ElementUI)
Vue.use(VuePrintNB)
Vue.component('svg-icon', SvgIcon)
Vue.component('pagination', Pagination)
Vue.directive('waves', waves)

Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})

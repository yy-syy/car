import axios from 'axios'
import { Message } from 'element-ui'
import store from '@/store'
import { getAccessToken } from '@/utils/auth'

const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 30000
})

service.interceptors.request.use(
  config => {
    if (store.getters.accessToken) {
      config.headers['Access-Token'] = getAccessToken()
    }
    // 统一转换分页参数名：pageNum -> page
    if (config.params && config.params.pageNum !== undefined) {
      config.params.page = config.params.pageNum
      delete config.params.pageNum
    }
    if (config.data && config.data.pageNum !== undefined) {
      config.data.page = config.data.pageNum
      delete config.data.pageNum
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

service.interceptors.response.use(
  response => {
    const res = response.data

    if (res.code !== 200) {
      // 401或1001表示未登录/token失效
      if (res.code === 401 || res.code === 1001) {
        store.dispatch('user/resetToken').then(() => {
          location.reload()
        })
        return Promise.reject(new Error(res.message || '登录已失效'))
      }

      Message({
        message: res.message || 'Error',
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(new Error(res.message || 'Error'))
    } else {
      // 统一转换分页数据格式：paginationResponse/dataList -> list/total
      if (res.data && (res.data.paginationResponse || res.data.dataList)) {
        const page = res.data.paginationResponse || res.data.dataList
        res.data.list = page.content || []
        res.data.total = page.totalElements || 0
        res.data.pageNum = page.currentPage || 1
        res.data.pageSize = page.pageSize || 10
      }
      return res
    }
  },
  error => {
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export const post = (url, data, option) => {
  return service({
    url,
    method: 'post',
    data,
    ...option
  })
}

export const get = (url, params, option) => {
  return service({
    url,
    method: 'get',
    params,
    ...option
  })
}

export const put = (url, data, option) => {
  return service({
    url,
    method: 'put',
    data,
    ...option
  })
}

export const del = (url, params, option) => {
  return service({
    url,
    method: 'delete',
    params,
    ...option
  })
}

export default service

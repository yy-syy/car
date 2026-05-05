import axios from 'axios'
import { MessageBox, Message } from 'element-ui'
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
      Message({
        message: res.message || 'Error',
        type: 'error',
        duration: 5 * 1000
      })

      if (res.code === 401) {
        MessageBox.confirm('你已被登出，请重新登录', '确认登出', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          store.dispatch('user/resetToken').then(() => {
            location.reload()
          })
        })
      }
      return Promise.reject(new Error(res.message || 'Error'))
    } else {
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

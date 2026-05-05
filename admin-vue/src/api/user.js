import request, { post, get } from '@/utils/request'

const api = {
  login: '/login/doLogin',
  getInfo: '/login/getInfo',
  getRouters: '/login/getRouters',
  logout: '/login/logout',
  captcha: 'https://www.fuint.cn/clientApi/captcha/getCode'
}

export function login(data) {
  return post(api.login, data)
}

export function getInfo() {
  return get(api.getInfo)
}

export function getRouters() {
  return get(api.getRouters)
}

export function logout() {
  return post(api.logout)
}

export function getCaptcha() {
  return get(api.captcha)
}

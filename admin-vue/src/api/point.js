import { get, post } from '@/utils/request'

export function getPointList(params) {
  return get('/point/list', params)
}

export function getPointSetting() {
  return get('/point/setting')
}

export function savePointSetting(data) {
  return post('/point/saveSetting', data)
}

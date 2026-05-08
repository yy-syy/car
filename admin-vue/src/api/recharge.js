import { get, post } from '@/utils/request'

export function getBalanceList(params) {
  return get('/balance/list', params)
}

export function getRechargeSetting() {
  return get('/balance/setting')
}

export function saveRechargeSetting(data) {
  return post('/balance/saveSetting', data)
}

export function doRecharge(data) {
  return post('/balance/doRecharge', data)
}

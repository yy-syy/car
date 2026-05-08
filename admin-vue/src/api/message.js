import { get, post, del } from '@/utils/request'

export function getSmsTemplateList(params) {
  return get('/smsTemplate/list', params)
}

export function saveSmsTemplate(data) {
  return post('/smsTemplate/save', data)
}

export function deleteSmsTemplate(id) {
  return del('/smsTemplate/delete', { id })
}

export function getSubMessageList(params) {
  return get('/subMessage/list', params)
}

export function saveSubMessage(data) {
  return post('/subMessage/save', data)
}

export function getSmsLogList(params) {
  return get('/smsManager/list', params)
}

export function getSmsSetting() {
  return get('/smsManager/setting')
}

export function saveSmsSetting(data) {
  return post('/smsManager/saveSetting', data)
}

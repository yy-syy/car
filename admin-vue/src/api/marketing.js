import request, { get, post, del } from '@/utils/request'

const api = {
  giftList: '/openGift/list',
  giftAdd: '/openGift/add',
  giftUpdate: '/openGift/update',
  giftDelete: '/openGift/delete',
  giveList: '/give/list',
  smsList: '/smsManager/list',
  smsSend: '/smsManager/send',
  smsTemplateList: '/smsTemplate/list',
  smsTemplateAdd: '/smsTemplate/add',
  smsTemplateUpdate: '/smsTemplate/update',
  smsTemplateDelete: '/smsTemplate/delete'
}

export function getGiftList(params) {
  return get(api.giftList, params)
}

export function addGift(data) {
  return post(api.giftAdd, data)
}

export function updateGift(data) {
  return post(api.giftUpdate, data)
}

export function deleteGift(id) {
  return del(api.giftDelete, { id })
}

export function getGiveList(params) {
  return get(api.giveList, params)
}

export function getSmsList(params) {
  return get(api.smsList, params)
}

export function sendSms(data) {
  return post(api.smsSend, data)
}

export function getSmsTemplateList(params) {
  return get(api.smsTemplateList, params)
}

export function addSmsTemplate(data) {
  return post(api.smsTemplateAdd, data)
}

export function updateSmsTemplate(data) {
  return post(api.smsTemplateUpdate, data)
}

export function deleteSmsTemplate(id) {
  return del(api.smsTemplateDelete, { id })
}

import request, { get, post, del } from '@/utils/request'

const api = {
  giftList: '/openGift/list',
  giftInfo: '/openGift/info',
  giftSave: '/openGift/save',
  giftUpdateStatus: '/openGift/updateStatus',
  giveList: '/give/list',
  smsLogList: '/smsManager/list',
  smsSend: '/smsManager/send',
  smsTemplateList: '/smsTemplate/list',
  smsTemplateInfo: '/smsTemplate/info',
  smsTemplateSave: '/smsTemplate/save',
  smsTemplateUpdateStatus: '/smsTemplate/updateStatus'
}

export function getGiftList(params) {
  return get(api.giftList, params)
}

export function getGiftInfo(id) {
  return get(`${api.giftInfo}/${id}`)
}

export function saveGift(data) {
  return post(api.giftSave, data)
}

export function updateGiftStatus(data) {
  return post(api.giftUpdateStatus, data)
}

export function getGiveList(params) {
  return get(api.giveList, params)
}

export function getSmsLogList(params) {
  return get(api.smsLogList, params)
}

export function sendSms(data) {
  return post(api.smsSend, data)
}

export function getSmsTemplateList(params) {
  return get(api.smsTemplateList, params)
}

export function getSmsTemplateInfo(id) {
  return get(`${api.smsTemplateInfo}/${id}`)
}

export function saveSmsTemplate(data) {
  return post(api.smsTemplateSave, data)
}

export function updateSmsTemplateStatus(data) {
  return post(api.smsTemplateUpdateStatus, data)
}

// 兼容别名
export const fetchGiftList = getGiftList
export const fetchGiveList = getGiveList
export const fetchSmsList = getSmsLogList
export const addGift = saveGift
export const updateGift = saveGift
export const addSmsTemplate = saveSmsTemplate
export const updateSmsTemplate = saveSmsTemplate

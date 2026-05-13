import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/coupon/list',
  info: '/coupon/info',
  save: '/coupon/save',
  updateStatus: '/coupon/updateStatus',
  send: '/coupon/sendCoupon',
  groupList: '/couponGroup/list',
  groupInfo: '/couponGroup/info',
  groupSave: '/couponGroup/save',
  groupUpdateStatus: '/couponGroup/updateStatus',
  userCouponList: '/userCoupon/list',
  confirmList: '/confirmLog/list',
  sendLogList: '/sendLog/list',
  giveList: '/give/list'
}

export function getCouponList(params) {
  return get(api.list, params)
}

export function getCouponInfo(id) {
  return get(`${api.info}/${id}`)
}

export function saveCoupon(data) {
  return post(api.save, data)
}

export function updateCouponStatus(data) {
  return post(api.updateStatus, data)
}

export function sendCoupon(data) {
  return post(api.send, data)
}

export function getCouponGroupList(params) {
  return get(api.groupList, params)
}

export function getCouponGroupInfo(id) {
  return get(`${api.groupInfo}/${id}`)
}

export function saveCouponGroup(data) {
  return post(api.groupSave, data)
}

export function updateCouponGroupStatus(data) {
  return post(api.groupUpdateStatus, data)
}

export function getUserCouponList(params) {
  return get(api.userCouponList, params)
}

export function getConfirmLogList(params) {
  return get(api.confirmList, params)
}

export function getSendLogList(params) {
  return get(api.sendLogList, params)
}

export function getGiveList(params) {
  return get(api.giveList, params)
}

// 兼容别名
export const fetchCouponList = getCouponList
export const fetchCouponGroupList = getCouponGroupList
export const fetchUserCouponList = getUserCouponList
export const addCoupon = saveCoupon
export const updateCoupon = saveCoupon
export const addCouponGroup = saveCouponGroup
export const updateCouponGroup = saveCouponGroup

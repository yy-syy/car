import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/coupon/list',
  detail: '/coupon/detail',
  add: '/coupon/add',
  update: '/coupon/update',
  delete: '/coupon/delete',
  send: '/coupon/send',
  groupList: '/couponGroup/list',
  groupAdd: '/couponGroup/add',
  groupUpdate: '/couponGroup/update',
  groupDelete: '/couponGroup/delete',
  userList: '/userCoupon/list',
  verify: '/coupon/verify'
}

export function getCouponList(params) {
  return get(api.list, params)
}

export function getCouponDetail(id) {
  return get(api.detail, { id })
}

export function addCoupon(data) {
  return post(api.add, data)
}

export function updateCoupon(data) {
  return post(api.update, data)
}

export function deleteCoupon(id) {
  return del(api.delete, { id })
}

export function sendCoupon(data) {
  return post(api.send, data)
}

export function getCouponGroupList(params) {
  return get(api.groupList, params)
}

export function addCouponGroup(data) {
  return post(api.groupAdd, data)
}

export function updateCouponGroup(data) {
  return post(api.groupUpdate, data)
}

export function deleteCouponGroup(id) {
  return del(api.groupDelete, { id })
}

export function getUserCouponList(params) {
  return get(api.userList, params)
}

export function verifyCoupon(data) {
  return post(api.verify, data)
}

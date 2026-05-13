import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/order/list',
  info: '/order/info',
  verify: '/order/verify',
  delivered: '/order/delivered',
  updateStatus: '/order/updateStatus',
  setting: '/order/setting',
  saveSetting: '/order/saveSetting',
  refundList: '/refund/list',
  refundInfo: '/refund/info',
  refundAudit: '/refund/updateStatus',
  settlementList: '/settlement/list',
  settlementInfo: '/settlement/info',
  settlementSave: '/settlement/save',
  settlementConfirm: '/settlement/doConfirm'
}

export function getOrderList(params) {
  return get(api.list, params)
}

export function getOrderInfo(id) {
  return get(`${api.info}/${id}`)
}

export function verifyOrder(data) {
  return post(api.verify, data)
}

export function deliveredOrder(data) {
  return post(api.delivered, data)
}

export function updateOrderStatus(data) {
  return post(api.updateStatus, data)
}

export function getOrderSetting() {
  return get(api.setting)
}

export function saveOrderSetting(data) {
  return post(api.saveSetting, data)
}

export function getRefundList(params) {
  return get(api.refundList, params)
}

export function getRefundInfo(id) {
  return get(`${api.refundInfo}/${id}`)
}

export function auditRefund(data) {
  return post(api.refundAudit, data)
}

export function getSettlementList(params) {
  return get(api.settlementList, params)
}

export function getSettlementInfo(id) {
  return get(`${api.settlementInfo}/${id}`)
}

export function saveSettlement(data) {
  return post(api.settlementSave, data)
}

export function confirmSettlement(data) {
  return post(api.settlementConfirm, data)
}

// 兼容别名
export const fetchOrderList = getOrderList
export const fetchRefundList = getRefundList
export const fetchSettlementList = getSettlementList

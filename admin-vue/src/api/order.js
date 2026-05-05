import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/order/list',
  detail: '/order/detail',
  add: '/order/add',
  update: '/order/update',
  delete: '/order/delete',
  refundList: '/refund/list',
  refundDetail: '/refund/detail',
  refundAudit: '/refund/audit'
}

export function getOrderList(params) {
  return get(api.list, params)
}

export function getOrderDetail(id) {
  return get(api.detail, { id })
}

export function addOrder(data) {
  return post(api.add, data)
}

export function updateOrder(data) {
  return post(api.update, data)
}

export function deleteOrder(id) {
  return del(api.delete, { id })
}

export function getRefundList(params) {
  return get(api.refundList, params)
}

export function getRefundDetail(id) {
  return get(api.refundDetail, { id })
}

export function auditRefund(data) {
  return post(api.refundAudit, data)
}

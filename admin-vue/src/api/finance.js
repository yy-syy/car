import request, { get, post, del } from '@/utils/request'

const api = {
  balanceList: '/balance/list',
  balanceLog: '/balance/log',
  commissionList: '/commissionLog/list',
  commissionCashList: '/commissionCash/list',
  commissionCashAudit: '/commissionCash/audit'
}

export function getBalanceList(params) {
  return get(api.balanceList, params)
}

export function getBalanceLog(params) {
  return get(api.balanceLog, params)
}

export function getCommissionList(params) {
  return get(api.commissionList, params)
}

export function getCommissionCashList(params) {
  return get(api.commissionCashList, params)
}

export function auditCommissionCash(data) {
  return post(api.commissionCashAudit, data)
}

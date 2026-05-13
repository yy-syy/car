import request, { get, post, del } from '@/utils/request'

const api = {
  balanceList: '/balance/list',
  balanceSetting: '/balance/setting',
  balanceSaveSetting: '/balance/saveSetting',
  balanceRecharge: '/balance/doRecharge',
  commissionLogList: '/commissionLog/list',
  commissionCashList: '/commissionCash/list',
  commissionCashAudit: '/commissionCash/updateStatus',
  commissionRuleList: '/commissionRule/list',
  commissionRuleInfo: '/commissionRule/info',
  commissionRuleSave: '/commissionRule/save',
  commissionRuleUpdateStatus: '/commissionRule/updateStatus',
  commissionRelationList: '/commissionRelation/list'
}

export function getBalanceList(params) {
  return get(api.balanceList, params)
}

export function getBalanceSetting() {
  return get(api.balanceSetting)
}

export function saveBalanceSetting(data) {
  return post(api.balanceSaveSetting, data)
}

export function doRecharge(data) {
  return post(api.balanceRecharge, data)
}

export function getCommissionLogList(params) {
  return get(api.commissionLogList, params)
}

export function getCommissionCashList(params) {
  return get(api.commissionCashList, params)
}

export function auditCommissionCash(data) {
  return post(api.commissionCashAudit, data)
}

export function getCommissionRuleList(params) {
  return get(api.commissionRuleList, params)
}

export function getCommissionRuleInfo(id) {
  return get(`${api.commissionRuleInfo}/${id}`)
}

export function saveCommissionRule(data) {
  return post(api.commissionRuleSave, data)
}

export function updateCommissionRuleStatus(data) {
  return post(api.commissionRuleUpdateStatus, data)
}

export function getCommissionRelationList(params) {
  return get(api.commissionRelationList, params)
}

// 兼容别名
export const fetchBalanceList = getBalanceList
export const fetchCommissionList = getCommissionLogList
export const getCommissionList = getCommissionLogList
export const getCommissionCashList2 = getCommissionCashList

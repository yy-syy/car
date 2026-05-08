import { get, post } from '@/utils/request'

export function getCommissionRuleList(params) {
  return get('/commissionRule/list', params)
}

export function saveCommissionRule(data) {
  return post('/commissionRule/save', data)
}

export function getCommissionLogList(params) {
  return get('/commissionLog/list', params)
}

export function getCommissionRelationList(params) {
  return get('/commissionRelation/list', params)
}

export function getCommissionCashList(params) {
  return get('/commissionCash/list', params)
}

export function doSettlement(data) {
  return post('/commissionCash/doSettle', data)
}

import request, { get, post, del } from '@/utils/request'

const api = {
  accountList: '/account/list',
  accountInfo: '/account/info',
  accountCreate: '/account/doCreate',
  accountUpdate: '/account/update',
  accountDelete: '/account/delete',
  accountUpdateStatus: '/account/updateStatus',
  accountResetPwd: '/account/resetPwd',
  dutyList: '/duty/list',
  dutyInfo: '/duty/info',
  dutySave: '/duty/save',
  dutyUpdateStatus: '/duty/updateStatus',
  sourceList: '/source/list',
  sourceInfo: '/source/info',
  sourceSave: '/source/save',
  sourceUpdateStatus: '/source/updateStatus',
  logList: '/actlog/list'
}

export function getAccountList(params) {
  return get(api.accountList, params)
}

export function getAccountInfo(id) {
  return get(`${api.accountInfo}/${id}`)
}

export function createAccount(data) {
  return post(api.accountCreate, data)
}

export function updateAccount(data) {
  return post(api.accountUpdate, data)
}

export function deleteAccount(id) {
  return get(`${api.accountDelete}/${id}`)
}

export function updateAccountStatus(data) {
  return post(api.accountUpdateStatus, data)
}

export function resetAccountPwd(data) {
  return post(api.accountResetPwd, data)
}

export function getDutyList(params) {
  return get(api.dutyList, params)
}

export function getDutyInfo(id) {
  return get(`${api.dutyInfo}/${id}`)
}

export function saveDuty(data) {
  return post(api.dutySave, data)
}

export function updateDutyStatus(data) {
  return post(api.dutyUpdateStatus, data)
}

export function getSourceList(params) {
  return get(api.sourceList, params)
}

export function getSourceInfo(id) {
  return get(`${api.sourceInfo}/${id}`)
}

export function saveSource(data) {
  return post(api.sourceSave, data)
}

export function updateSourceStatus(data) {
  return post(api.sourceUpdateStatus, data)
}

export function getLogList(params) {
  return get(api.logList, params)
}

// 兼容别名
export const fetchAccountList = getAccountList
export const fetchRoleList = getDutyList
export const fetchMenuList = getSourceList
export const fetchLogList = getLogList
export const getRoleList = getDutyList
export const getMenuList = getSourceList
export const addAccount = createAccount
export const addRole = saveDuty
export const updateRole = saveDuty
export const addMenu = saveSource
export const updateMenu = saveSource

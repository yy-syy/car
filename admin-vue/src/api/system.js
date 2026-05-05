import request, { get, post, del } from '@/utils/request'

const api = {
  accountList: '/account/list',
  accountDetail: '/account/detail',
  accountAdd: '/account/add',
  accountUpdate: '/account/update',
  accountDelete: '/account/delete',
  accountResetPwd: '/account/resetPwd',
  roleList: '/role/list',
  roleDetail: '/role/detail',
  roleAdd: '/role/add',
  roleUpdate: '/role/update',
  roleDelete: '/role/delete',
  menuList: '/menu/list',
  menuTree: '/menu/tree',
  menuAdd: '/menu/add',
  menuUpdate: '/menu/update',
  menuDelete: '/menu/delete',
  logList: '/log/list'
}

export function getAccountList(params) {
  return get(api.accountList, params)
}

export function getAccountDetail(id) {
  return get(api.accountDetail, { id })
}

export function addAccount(data) {
  return post(api.accountAdd, data)
}

export function updateAccount(data) {
  return post(api.accountUpdate, data)
}

export function deleteAccount(id) {
  return del(api.accountDelete, { id })
}

export function resetAccountPwd(id) {
  return post(api.accountResetPwd, { id })
}

export function getRoleList(params) {
  return get(api.roleList, params)
}

export function getRoleDetail(id) {
  return get(api.roleDetail, { id })
}

export function addRole(data) {
  return post(api.roleAdd, data)
}

export function updateRole(data) {
  return post(api.roleUpdate, data)
}

export function deleteRole(id) {
  return del(api.roleDelete, { id })
}

export function getMenuList(params) {
  return get(api.menuList, params)
}

export function getMenuTree() {
  return get(api.menuTree)
}

export function addMenu(data) {
  return post(api.menuAdd, data)
}

export function updateMenu(data) {
  return post(api.menuUpdate, data)
}

export function deleteMenu(id) {
  return del(api.menuDelete, { id })
}

export function getLogList(params) {
  return get(api.logList, params)
}

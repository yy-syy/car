import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/store/list',
  detail: '/store/detail',
  add: '/store/add',
  update: '/store/update',
  delete: '/store/delete',
  staffList: '/staff/list',
  staffDetail: '/staff/detail',
  staffAdd: '/staff/add',
  staffUpdate: '/staff/update',
  staffDelete: '/staff/delete'
}

export function getStoreList(params) {
  return get(api.list, params)
}

export function getStoreDetail(id) {
  return get(api.detail, { id })
}

export function addStore(data) {
  return post(api.add, data)
}

export function updateStore(data) {
  return post(api.update, data)
}

export function deleteStore(id) {
  return del(api.delete, { id })
}

export function getStaffList(params) {
  return get(api.staffList, params)
}

export function getStaffDetail(id) {
  return get(api.staffDetail, { id })
}

export function addStaff(data) {
  return post(api.staffAdd, data)
}

export function updateStaff(data) {
  return post(api.staffUpdate, data)
}

export function deleteStaff(id) {
  return del(api.staffDelete, { id })
}

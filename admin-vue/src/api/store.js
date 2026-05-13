import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/store/list',
  info: '/store/info',
  save: '/store/save',
  updateStatus: '/store/updateStatus',
  searchStore: '/store/searchStore',
  staffList: '/staff/list',
  staffInfo: '/staff/info',
  staffSave: '/staff/save',
  staffUpdateStatus: '/staff/updateStatus'
}

export function getStoreList(params) {
  return get(api.list, params)
}

export function getStoreInfo(id) {
  return get(`${api.info}/${id}`)
}

export function saveStore(data) {
  return post(api.save, data)
}

export function updateStoreStatus(data) {
  return post(api.updateStatus, data)
}

export function searchStore(params) {
  return get(api.searchStore, params)
}

export function getStaffList(params) {
  return get(api.staffList, params)
}

export function getStaffInfo(id) {
  return get(`${api.staffInfo}/${id}`)
}

export function saveStaff(data) {
  return post(api.staffSave, data)
}

export function updateStaffStatus(data) {
  return post(api.staffUpdateStatus, data)
}

// 兼容别名
export const fetchStoreList = getStoreList
export const fetchStaffList = getStaffList
export const addStore = saveStore
export const updateStore = saveStore
export function deleteStore(id) {
  return post(api.updateStatus, { storeId: id, status: 'D' })
}

import request, { get, post, del } from '@/utils/request'

const api = {
  vehicleList: '/vehicle/list',
  vehicleInfo: '/vehicle/info',
  vehicleSave: '/vehicle/save',
  vehicleUpdateStatus: '/vehicle/updateStatus',
  bookList: '/book/list',
  bookInfo: '/book/info',
  bookSave: '/book/save',
  bookUpdateStatus: '/book/updateStatus',
  bookItemList: '/bookItem/list',
  bookItemInfo: '/bookItem/info',
  bookItemSave: '/bookItem/save',
  bookItemUpdateStatus: '/bookItem/updateStatus',
  bookCateList: '/bookCate/list',
  bookCateInfo: '/bookCate/info',
  bookCateSave: '/bookCate/save',
  bookCateUpdateStatus: '/bookCate/updateStatus'
}

export function getVehicleList(params) {
  return get(api.vehicleList, params)
}

export function getVehicleInfo(id) {
  return get(`${api.vehicleInfo}/${id}`)
}

export function saveVehicle(data) {
  return post(api.vehicleSave, data)
}

export function updateVehicleStatus(data) {
  return post(api.vehicleUpdateStatus, data)
}

export function getBookList(params) {
  return get(api.bookList, params)
}

export function getBookInfo(id) {
  return get(`${api.bookInfo}/${id}`)
}

export function saveBook(data) {
  return post(api.bookSave, data)
}

export function updateBookStatus(data) {
  return post(api.bookUpdateStatus, data)
}

export function getBookItemList(params) {
  return get(api.bookItemList, params)
}

export function getBookItemInfo(id) {
  return get(`${api.bookItemInfo}/${id}`)
}

export function saveBookItem(data) {
  return post(api.bookItemSave, data)
}

export function updateBookItemStatus(data) {
  return post(api.bookItemUpdateStatus, data)
}

export function getBookCateList(params) {
  return get(api.bookCateList, params)
}

export function getBookCateInfo(id) {
  return get(`${api.bookCateInfo}/${id}`)
}

export function saveBookCate(data) {
  return post(api.bookCateSave, data)
}

export function updateBookCateStatus(data) {
  return post(api.bookCateUpdateStatus, data)
}

// 兼容别名
export const fetchBookList = getBookList
export const fetchBookItemList = getBookItemList
export const addVehicle = saveVehicle
export const updateVehicle = saveVehicle

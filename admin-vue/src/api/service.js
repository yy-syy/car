import request, { get, post, del } from '@/utils/request'

const api = {
  vehicleList: '/vehicle/list',
  vehicleDetail: '/vehicle/detail',
  vehicleAdd: '/vehicle/add',
  vehicleUpdate: '/vehicle/update',
  vehicleDelete: '/vehicle/delete',
  bookList: '/book/list',
  bookDetail: '/book/detail',
  bookUpdate: '/book/update',
  bookDelete: '/book/delete',
  bookCateList: '/bookCate/list',
  bookCateAdd: '/bookCate/add',
  bookCateUpdate: '/bookCate/update',
  bookCateDelete: '/bookCate/delete'
}

export function getVehicleList(params) {
  return get(api.vehicleList, params)
}

export function getVehicleDetail(id) {
  return get(api.vehicleDetail, { id })
}

export function addVehicle(data) {
  return post(api.vehicleAdd, data)
}

export function updateVehicle(data) {
  return post(api.vehicleUpdate, data)
}

export function deleteVehicle(id) {
  return del(api.vehicleDelete, { id })
}

export function getBookList(params) {
  return get(api.bookList, params)
}

export function getBookDetail(id) {
  return get(api.bookDetail, { id })
}

export function updateBook(data) {
  return post(api.bookUpdate, data)
}

export function deleteBook(id) {
  return del(api.bookDelete, { id })
}

export function getBookCateList(params) {
  return get(api.bookCateList, params)
}

export function addBookCate(data) {
  return post(api.bookCateAdd, data)
}

export function updateBookCate(data) {
  return post(api.bookCateUpdate, data)
}

export function deleteBookCate(id) {
  return del(api.bookCateDelete, { id })
}

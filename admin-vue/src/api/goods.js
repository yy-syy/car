import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/goods/list',
  info: '/goods/info',
  save: '/goods/save',
  updateStatus: '/goods/updateStatus',
  cateList: '/goods/cate/list',
  cateInfo: '/goods/cate/info',
  cateSave: '/goods/cate/save',
  cateUpdateStatus: '/goods/cate/updateStatus',
  stockList: '/stock/list',
  stockInfo: '/stock/info',
  stockSave: '/stock/save'
}

export function getGoodsList(params) {
  return get(api.list, params)
}

export function getGoodsInfo(id) {
  return get(`${api.info}/${id}`)
}

export function saveGoods(data) {
  return post(api.save, data)
}

export function updateGoodsStatus(data) {
  return post(api.updateStatus, data)
}

export function getCategoryList(params) {
  return get(api.cateList, params)
}

export function getCategoryInfo(id) {
  return get(`${api.cateInfo}/${id}`)
}

export function saveCategory(data) {
  return post(api.cateSave, data)
}

export function updateCategoryStatus(data) {
  return post(api.cateUpdateStatus, data)
}

export function getStockList(params) {
  return get(api.stockList, params)
}

export function getStockInfo(id) {
  return get(`${api.stockInfo}/${id}`)
}

export function saveStock(data) {
  return post(api.stockSave, data)
}

// 兼容别名
export const fetchGoodsList = getGoodsList
export const fetchCategoryList = getCategoryList
export const addGoods = saveGoods
export const updateGoods = saveGoods
export const addCategory = saveCategory
export const updateCategory = saveCategory

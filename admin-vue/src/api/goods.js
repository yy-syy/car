import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/goods/goods/list',
  detail: '/goods/goods/detail',
  add: '/goods/goods/add',
  update: '/goods/goods/update',
  delete: '/goods/goods/delete',
  categoryList: '/goods/cate/list',
  categoryAdd: '/goods/cate/add',
  categoryUpdate: '/goods/cate/update',
  categoryDelete: '/goods/cate/delete'
}

export function getGoodsList(params) {
  return get(api.list, params)
}

export function getGoodsDetail(id) {
  return get(api.detail, { id })
}

export function addGoods(data) {
  return post(api.add, data)
}

export function updateGoods(data) {
  return post(api.update, data)
}

export function deleteGoods(id) {
  return del(api.delete, { id })
}

export function getCategoryList(params) {
  return get(api.categoryList, params)
}

export function addCategory(data) {
  return post(api.categoryAdd, data)
}

export function updateCategory(data) {
  return post(api.categoryUpdate, data)
}

export function deleteCategory(id) {
  return del(api.categoryDelete, { id })
}

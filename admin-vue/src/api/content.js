import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/banner/list',
  detail: '/banner/detail',
  add: '/banner/add',
  update: '/banner/update',
  delete: '/banner/delete',
  articleList: '/article/list',
  articleDetail: '/article/detail',
  articleAdd: '/article/add',
  articleUpdate: '/article/update',
  articleDelete: '/article/delete'
}

export function getBannerList(params) {
  return get(api.list, params)
}

export function getBannerDetail(id) {
  return get(api.detail, { id })
}

export function addBanner(data) {
  return post(api.add, data)
}

export function updateBanner(data) {
  return post(api.update, data)
}

export function deleteBanner(id) {
  return del(api.delete, { id })
}

export function getArticleList(params) {
  return get(api.articleList, params)
}

export function getArticleDetail(id) {
  return get(api.articleDetail, { id })
}

export function addArticle(data) {
  return post(api.articleAdd, data)
}

export function updateArticle(data) {
  return post(api.articleUpdate, data)
}

export function deleteArticle(id) {
  return del(api.articleDelete, { id })
}

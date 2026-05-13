import request, { get, post, del } from '@/utils/request'

const api = {
  bannerList: '/banner/list',
  bannerInfo: '/banner/info',
  bannerSave: '/banner/save',
  bannerUpdateStatus: '/banner/updateStatus',
  articleList: '/article/list',
  articleInfo: '/article/info',
  articleSave: '/article/save',
  articleUpdateStatus: '/article/updateStatus',
  settingList: '/setting/list',
  settingSave: '/setting/save'
}

export function getBannerList(params) {
  return get(api.bannerList, params)
}

export function getBannerInfo(id) {
  return get(`${api.bannerInfo}/${id}`)
}

export function saveBanner(data) {
  return post(api.bannerSave, data)
}

export function updateBannerStatus(data) {
  return post(api.bannerUpdateStatus, data)
}

export function getArticleList(params) {
  return get(api.articleList, params)
}

export function getArticleInfo(id) {
  return get(`${api.articleInfo}/${id}`)
}

export function saveArticle(data) {
  return post(api.articleSave, data)
}

export function updateArticleStatus(data) {
  return post(api.articleUpdateStatus, data)
}

export function getSettingList(params) {
  return get(api.settingList, params)
}

export function saveSetting(data) {
  return post(api.settingSave, data)
}

// 兼容别名
export const fetchBannerList = getBannerList
export const fetchArticleList = getArticleList
export const addBanner = saveBanner
export const updateBanner = saveBanner
export const addArticle = saveArticle
export const updateArticle = saveArticle

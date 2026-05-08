import request, { get } from '@/utils/request'

const api = {
  index: '/home/index',
  statistic: '/statistic/index'
}

export function getHomeData() {
  return get(api.index)
}

export function getDashboardStats() {
  return get(api.index)
}

export function getStatistic(tag) {
  return get(api.statistic, { tag })
}

import { get, post, del } from '@/utils/request'

export function getPrinterList(params) {
  return get('/printer/list', params)
}

export function getPrinterDetail(id) {
  return get('/printer/detail', { id })
}

export function savePrinter(data) {
  return post('/printer/save', data)
}

export function deletePrinter(id) {
  return del('/printer/delete', { id })
}

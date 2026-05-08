import { get, post, del } from '@/utils/request'

export function getVehicleList(params) {
  return get('/vehicle/list', params)
}

export function getVehicleDetail(id) {
  return get('/vehicle/detail', { id })
}

export function saveVehicle(data) {
  return post('/vehicle/save', data)
}

export function deleteVehicle(id) {
  return del('/vehicle/delete', { id })
}

export function getVehicleOrderList(params) {
  return get('/vehicleOrder/list', params)
}

export function getVehicleOrderDetail(id) {
  return get('/vehicleOrder/detail', { id })
}

export function saveVehicleOrder(data) {
  return post('/vehicleOrder/save', data)
}

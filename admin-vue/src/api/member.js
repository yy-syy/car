import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/member/list',
  detail: '/member/detail',
  add: '/member/add',
  update: '/member/update',
  delete: '/member/delete',
  groupList: '/memberGroup/list',
  groupAdd: '/memberGroup/add',
  groupUpdate: '/memberGroup/update',
  groupDelete: '/memberGroup/delete',
  gradeList: '/userGrade/list',
  gradeAdd: '/userGrade/add',
  gradeUpdate: '/userGrade/update',
  gradeDelete: '/userGrade/delete'
}

export function getMemberList(params) {
  return get(api.list, params)
}

export function getMemberDetail(id) {
  return get(api.detail, { id })
}

export function addMember(data) {
  return post(api.add, data)
}

export function updateMember(data) {
  return post(api.update, data)
}

export function deleteMember(id) {
  return del(api.delete, { id })
}

export function getGroups(params) {
  return get(api.groupList, params)
}

export function addMemberGroup(data) {
  return post(api.groupAdd, data)
}

export function updateMemberGroup(data) {
  return post(api.groupUpdate, data)
}

export function deleteMemberGroup(id) {
  return del(api.groupDelete, { id })
}

export function getGrades(params) {
  return get(api.gradeList, params)
}

export function addGrade(data) {
  return post(api.gradeAdd, data)
}

export function updateGrade(data) {
  return post(api.gradeUpdate, data)
}

export function deleteGrade(id) {
  return del(api.gradeDelete, { id })
}

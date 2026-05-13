import request, { get, post, del } from '@/utils/request'

const api = {
  list: '/member/list',
  info: '/member/info',
  save: '/member/save',
  updateStatus: '/member/updateStatus',
  groupList: '/memberGroup/list',
  groupInfo: '/memberGroup/info',
  groupSave: '/memberGroup/save',
  groupUpdateStatus: '/memberGroup/updateStatus',
  gradeList: '/userGrade/list',
  gradeInfo: '/userGrade/info',
  gradeSave: '/userGrade/save',
  gradeUpdateStatus: '/userGrade/updateStatus',
  setting: '/member/setting',
  saveSetting: '/member/saveSetting'
}

export function getMemberList(params) {
  return get(api.list, params)
}

export function getMemberInfo(id) {
  return get(`${api.info}/${id}`)
}

export function saveMember(data) {
  return post(api.save, data)
}

export function updateMemberStatus(data) {
  return post(api.updateStatus, data)
}

export function getGroupList(params) {
  return get(api.groupList, params)
}

export function getGroupInfo(id) {
  return get(`${api.groupInfo}/${id}`)
}

export function saveGroup(data) {
  return post(api.groupSave, data)
}

export function updateGroupStatus(data) {
  return post(api.groupUpdateStatus, data)
}

export function getGradeList(params) {
  return get(api.gradeList, params)
}

export function getGradeInfo(id) {
  return get(`${api.gradeInfo}/${id}`)
}

export function saveGrade(data) {
  return post(api.gradeSave, data)
}

export function updateGradeStatus(data) {
  return post(api.gradeUpdateStatus, data)
}

export function getMemberSetting() {
  return get(api.setting)
}

export function saveMemberSetting(data) {
  return post(api.saveSetting, data)
}

// 兼容别名
export const fetchMemberList = getMemberList
export const fetchGradeList = getGradeList
export const getGroups = getGroupList
export const getGrades = getGradeList
export const addMember = saveMember
export const updateMember = saveMember
export const addMemberGroup = saveGroup
export const updateMemberGroup = saveGroup
export const addGrade = saveGrade
export const updateGrade = saveGrade

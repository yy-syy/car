import { login, logout, getInfo } from '@/api/user'
import { getAccessToken, setAccessToken, removeAccessToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const state = {
  accessToken: getAccessToken(),
  roles: [],
  permissions: [],
  name: '',
  avatar: ''
}

const mutations = {
  SET_ACCESS_TOKEN: (state, accessToken) => {
    state.accessToken = accessToken
  },
  SET_ROLES: (state, roles) => {
    state.roles = roles
  },
  SET_PERMISSIONS: (state, permissions) => {
    state.permissions = permissions
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  }
}

const actions = {
  login({ commit }, userInfo) {
    const { username, password, captcha, uuid } = userInfo
    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password, captcha: captcha, uuid: uuid }).then(response => {
        const { data } = response
        commit('SET_ACCESS_TOKEN', data.accessToken)
        setAccessToken(data.accessToken)
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getInfo().then(response => {
        const { data } = response

        if (!data) {
          reject('验证失败，请重新登录。')
        }

        const { roles, permissions, accountInfo } = data

        if (!roles || roles.length <= 0) {
          reject('getInfo: roles must be a non-null array!')
        }

        commit('SET_ROLES', roles)
        commit('SET_PERMISSIONS', permissions)
        commit('SET_NAME', accountInfo.accountName)
        resolve(data)
      }).catch(error => {
        reject(error)
      })
    })
  },

  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.accessToken).then(() => {
        commit('SET_ACCESS_TOKEN', '')
        commit('SET_ROLES', [])
        commit('SET_PERMISSIONS', [])
        removeAccessToken()
        resetRouter()
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  resetToken({ commit }) {
    return new Promise(resolve => {
      commit('SET_ACCESS_TOKEN', '')
      commit('SET_ROLES', [])
      commit('SET_PERMISSIONS', [])
      removeAccessToken()
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

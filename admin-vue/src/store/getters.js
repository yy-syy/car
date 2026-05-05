const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  accessToken: state => state.user.accessToken,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  roles: state => state.user.roles,
  permissions: state => state.user.permissions,
  permission_routes: state => state.permission.routes
}
export default getters

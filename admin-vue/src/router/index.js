import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/error-page/404'),
    hidden: true
  },
  {
    path: '/401',
    component: () => import('@/views/error-page/401'),
    hidden: true
  },
  {
    path: '/',
    component: () => import('@/layout/index'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: () => import('@/views/dashboard/index'),
        name: 'Dashboard',
        meta: { title: '首页', icon: 'dashboard', affix: true }
      }
    ]
  }
]

export const asyncRoutes = [
  {
    path: '/member',
    component: () => import('@/layout/index'),
    name: 'Member',
    meta: { title: '会员管理', icon: 'user' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/member/list'),
        name: 'MemberList',
        meta: { title: '会员列表', icon: 'list' }
      },
      {
        path: 'group',
        component: () => import('@/views/member/group'),
        name: 'MemberGroup',
        meta: { title: '会员分组', icon: 'peoples' }
      },
      {
        path: 'grade',
        component: () => import('@/views/member/grade'),
        name: 'MemberGrade',
        meta: { title: '会员等级', icon: 'component' }
      }
    ]
  },
  {
    path: '/order',
    component: () => import('@/layout/index'),
    name: 'Order',
    meta: { title: '订单管理', icon: 'shopping' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/order/list'),
        name: 'OrderList',
        meta: { title: '订单列表', icon: 'list' }
      },
      {
        path: 'refund',
        component: () => import('@/views/order/refund'),
        name: 'OrderRefund',
        meta: { title: '退款管理', icon: 'edit' }
      }
    ]
  },
  {
    path: '/goods',
    component: () => import('@/layout/index'),
    name: 'Goods',
    meta: { title: '商品管理', icon: 'goods' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/goods/list'),
        name: 'GoodsList',
        meta: { title: '商品列表', icon: 'list' }
      },
      {
        path: 'category',
        component: () => import('@/views/goods/category'),
        name: 'GoodsCategory',
        meta: { title: '商品分类', icon: 'component' }
      }
    ]
  },
  {
    path: '/coupon',
    component: () => import('@/layout/index'),
    name: 'Coupon',
    meta: { title: '卡券管理', icon: 'coupon' },
    children: [
      {
        path: 'group',
        component: () => import('@/views/coupon/group'),
        name: 'CouponGroup',
        meta: { title: '卡券组', icon: 'component' }
      },
      {
        path: 'list',
        component: () => import('@/views/coupon/list'),
        name: 'CouponList',
        meta: { title: '卡券列表', icon: 'list' }
      },
      {
        path: 'user',
        component: () => import('@/views/coupon/user'),
        name: 'CouponUser',
        meta: { title: '用户卡券', icon: 'user' }
      }
    ]
  },
  {
    path: '/marketing',
    component: () => import('@/layout/index'),
    name: 'Marketing',
    meta: { title: '营销管理', icon: 'marketing' },
    children: [
      {
        path: 'gift',
        component: () => import('@/views/marketing/gift'),
        name: 'MarketingGift',
        meta: { title: '开卡礼品', icon: 'component' }
      },
      {
        path: 'give',
        component: () => import('@/views/marketing/give'),
        name: 'MarketingGive',
        meta: { title: '赠送记录', icon: 'list' }
      },
      {
        path: 'sms',
        component: () => import('@/views/marketing/sms'),
        name: 'MarketingSms',
        meta: { title: '短信管理', icon: 'message' }
      }
    ]
  },
  {
    path: '/content',
    component: () => import('@/layout/index'),
    name: 'Content',
    meta: { title: '内容管理', icon: 'content' },
    children: [
      {
        path: 'banner',
        component: () => import('@/views/content/banner'),
        name: 'ContentBanner',
        meta: { title: '轮播图', icon: 'component' }
      },
      {
        path: 'article',
        component: () => import('@/views/content/article'),
        name: 'ContentArticle',
        meta: { title: '文章管理', icon: 'list' }
      }
    ]
  },
  {
    path: '/store',
    component: () => import('@/layout/index'),
    name: 'Store',
    meta: { title: '门店管理', icon: 'store' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/store/list'),
        name: 'StoreList',
        meta: { title: '门店列表', icon: 'list' }
      },
      {
        path: 'staff',
        component: () => import('@/views/store/staff'),
        name: 'StoreStaff',
        meta: { title: '员工管理', icon: 'user' }
      }
    ]
  },
  {
    path: '/service',
    component: () => import('@/layout/index'),
    name: 'Service',
    meta: { title: '服务管理', icon: 'service' },
    children: [
      {
        path: 'vehicle',
        component: () => import('@/views/service/vehicle'),
        name: 'ServiceVehicle',
        meta: { title: '车辆管理', icon: 'car' }
      },
      {
        path: 'book',
        component: () => import('@/views/service/book'),
        name: 'ServiceBook',
        meta: { title: '预约管理', icon: 'book' }
      }
    ]
  },
  {
    path: '/finance',
    component: () => import('@/layout/index'),
    name: 'Finance',
    meta: { title: '财务管理', icon: 'money' },
    children: [
      {
        path: 'balance',
        component: () => import('@/views/finance/balance'),
        name: 'FinanceBalance',
        meta: { title: '余额管理', icon: 'money' }
      },
      {
        path: 'commission',
        component: () => import('@/views/finance/commission'),
        name: 'FinanceCommission',
        meta: { title: '佣金管理', icon: 'component' }
      }
    ]
  },
  {
    path: '/system',
    component: () => import('@/layout/index'),
    name: 'System',
    meta: { title: '系统管理', icon: 'system' },
    children: [
      {
        path: 'account',
        component: () => import('@/views/system/account'),
        name: 'SystemAccount',
        meta: { title: '账号管理', icon: 'peoples' }
      },
      {
        path: 'role',
        component: () => import('@/views/system/role'),
        name: 'SystemRole',
        meta: { title: '角色管理', icon: 'component' }
      },
      {
        path: 'menu',
        component: () => import('@/views/system/menu'),
        name: 'SystemMenu',
        meta: { title: '菜单管理', icon: 'tree-table' }
      },
      {
        path: 'log',
        component: () => import('@/views/system/log'),
        name: 'SystemLog',
        meta: { title: '操作日志', icon: 'list' }
      }
    ]
  },
  { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new VueRouter({
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher
}

export default router

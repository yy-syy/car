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
    redirect: '/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/dashboard/index'),
        name: 'Index',
        meta: { title: '系统首页', icon: 'dashboard', affix: true }
      }
    ]
  }
]

export const asyncRoutes = [
  {
    path: '/store',
    component: () => import('@/layout/index'),
    name: 'Store',
    meta: { title: '店铺管理', icon: 'store' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/store/list'),
        name: 'StoreList',
        meta: { title: '店铺列表', icon: 'list' }
      },
      {
        path: 'staff',
        component: () => import('@/views/store/staff'),
        name: 'StoreStaff',
        meta: { title: '员工管理', icon: 'peoples' }
      },
      {
        path: 'booking',
        component: () => import('@/views/store/booking'),
        name: 'StoreBooking',
        meta: { title: '预约管理', icon: 'book' }
      },
      {
        path: 'booking-record',
        component: () => import('@/views/store/bookingRecord'),
        name: 'StoreBookingRecord',
        meta: { title: '预约记录', icon: 'list' }
      },
      {
        path: 'printer',
        component: () => import('@/views/store/printer'),
        name: 'StorePrinter',
        meta: { title: '打印设备', icon: 'component' }
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
        meta: { title: '轮播管理', icon: 'component' }
      },
      {
        path: 'article',
        component: () => import('@/views/content/article'),
        name: 'ContentArticle',
        meta: { title: '文章管理', icon: 'list' }
      },
      {
        path: 'navigation',
        component: () => import('@/views/content/navigation'),
        name: 'ContentNavigation',
        meta: { title: '导航管理', icon: 'tree-table' }
      }
    ]
  },
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
      },
      {
        path: 'gift',
        component: () => import('@/views/member/gift'),
        name: 'MemberGift',
        meta: { title: '开卡赠礼', icon: 'coupon' }
      },
      {
        path: 'setting',
        component: () => import('@/views/member/setting'),
        name: 'MemberSetting',
        meta: { title: '会员设置', icon: 'system' }
      }
    ]
  },
  {
    path: '/car-service',
    component: () => import('@/layout/index'),
    name: 'CarService',
    meta: { title: '汽车服务', icon: 'car' },
    children: [
      {
        path: 'vehicle',
        component: () => import('@/views/service/vehicle'),
        name: 'ServiceVehicle',
        meta: { title: '会员车辆', icon: 'car' }
      },
      {
        path: 'order',
        component: () => import('@/views/service/serviceOrder'),
        name: 'ServiceOrder',
        meta: { title: '服务订单', icon: 'list' }
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
        meta: { title: '分组管理', icon: 'component' }
      },
      {
        path: 'list',
        component: () => import('@/views/coupon/list'),
        name: 'CouponList',
        meta: { title: '卡券列表', icon: 'list' }
      },
      {
        path: 'verify',
        component: () => import('@/views/coupon/verify'),
        name: 'CouponVerify',
        meta: { title: '卡券核销', icon: 'edit' }
      },
      {
        path: 'user',
        component: () => import('@/views/coupon/user'),
        name: 'CouponUser',
        meta: { title: '会员卡券', icon: 'user' }
      },
      {
        path: 'verify-log',
        component: () => import('@/views/coupon/verifyLog'),
        name: 'CouponVerifyLog',
        meta: { title: '核销流水', icon: 'list' }
      },
      {
        path: 'send-log',
        component: () => import('@/views/coupon/sendLog'),
        name: 'CouponSendLog',
        meta: { title: '发券记录', icon: 'list' }
      },
      {
        path: 'transfer',
        component: () => import('@/views/coupon/transfer'),
        name: 'CouponTransfer',
        meta: { title: '转赠记录', icon: 'list' }
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
        meta: { title: '售后订单', icon: 'edit' }
      },
      {
        path: 'setting',
        component: () => import('@/views/order/setting'),
        name: 'OrderSetting',
        meta: { title: '交易设置', icon: 'system' }
      },
      {
        path: 'settlement',
        component: () => import('@/views/order/settlement'),
        name: 'OrderSettlement',
        meta: { title: '订单结算', icon: 'money' }
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
        path: 'category',
        component: () => import('@/views/goods/category'),
        name: 'GoodsCategory',
        meta: { title: '商品分类', icon: 'component' }
      },
      {
        path: 'list',
        component: () => import('@/views/goods/list'),
        name: 'GoodsList',
        meta: { title: '商品列表', icon: 'list' }
      },
      {
        path: 'stock',
        component: () => import('@/views/goods/stock'),
        name: 'GoodsStock',
        meta: { title: '库存管理', icon: 'shopping' }
      }
    ]
  },
  {
    path: '/message',
    component: () => import('@/layout/index'),
    name: 'Message',
    meta: { title: '消息管理', icon: 'message' },
    children: [
      {
        path: 'sms-template',
        component: () => import('@/views/message/smsTemplate'),
        name: 'SmsTemplate',
        meta: { title: '短信模板', icon: 'list' }
      },
      {
        path: 'subscribe',
        component: () => import('@/views/message/subscribe'),
        name: 'MessageSubscribe',
        meta: { title: '订阅消息', icon: 'message' }
      },
      {
        path: 'sms-log',
        component: () => import('@/views/message/smsLog'),
        name: 'SmsLog',
        meta: { title: '已发短信', icon: 'list' }
      },
      {
        path: 'sms-setting',
        component: () => import('@/views/message/smsSetting'),
        name: 'SmsSetting',
        meta: { title: '短信配置', icon: 'system' }
      }
    ]
  },
  {
    path: '/point',
    component: () => import('@/layout/index'),
    name: 'Point',
    meta: { title: '积分管理', icon: 'edit' },
    children: [
      {
        path: 'setting',
        component: () => import('@/views/point/setting'),
        name: 'PointSetting',
        meta: { title: '积分设置', icon: 'system' }
      },
      {
        path: 'log',
        component: () => import('@/views/point/log'),
        name: 'PointLog',
        meta: { title: '积分明细', icon: 'list' }
      }
    ]
  },
  {
    path: '/recharge',
    component: () => import('@/layout/index'),
    name: 'Recharge',
    meta: { title: '充值管理', icon: 'money' },
    children: [
      {
        path: 'setting',
        component: () => import('@/views/recharge/setting'),
        name: 'RechargeSetting',
        meta: { title: '充值设置', icon: 'system' }
      },
      {
        path: 'balance',
        component: () => import('@/views/recharge/balance'),
        name: 'RechargeBalance',
        meta: { title: '余额明细', icon: 'money' }
      },
      {
        path: 'member',
        component: () => import('@/views/recharge/member'),
        name: 'RechargeMember',
        meta: { title: '会员充值', icon: 'user' }
      }
    ]
  },
  {
    path: '/device',
    component: () => import('@/layout/index'),
    name: 'Device',
    meta: { title: '设备列表', icon: 'component' },
    children: [
      {
        path: 'list',
        component: () => import('@/views/device/list'),
        name: 'DeviceList',
        meta: { title: '列表', icon: 'list' }
      }
    ]
  },
  {
    path: '/commission',
    component: () => import('@/layout/index'),
    name: 'Commission',
    meta: { title: '分佣提成', icon: 'money' },
    children: [
      {
        path: 'rule',
        component: () => import('@/views/commission/rule'),
        name: 'CommissionRule',
        meta: { title: '分佣规则', icon: 'system' }
      },
      {
        path: 'log',
        component: () => import('@/views/commission/log'),
        name: 'CommissionLog',
        meta: { title: '分佣记录', icon: 'list' }
      },
      {
        path: 'invite',
        component: () => import('@/views/commission/invite'),
        name: 'CommissionInvite',
        meta: { title: '邀请明细', icon: 'peoples' }
      },
      {
        path: 'settlement',
        component: () => import('@/views/commission/settlement'),
        name: 'CommissionSettlement',
        meta: { title: '结算记录', icon: 'money' }
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
        path: 'menu',
        component: () => import('@/views/system/menu'),
        name: 'SystemMenu',
        meta: { title: '后台菜单', icon: 'tree-table' }
      },
      {
        path: 'log',
        component: () => import('@/views/system/log'),
        name: 'SystemLog',
        meta: { title: '后台日志', icon: 'list' }
      },
      {
        path: 'role',
        component: () => import('@/views/system/role'),
        name: 'SystemRole',
        meta: { title: '后台角色', icon: 'component' }
      },
      {
        path: 'code',
        component: () => import('@/views/system/code'),
        name: 'SystemCode',
        meta: { title: '生成代码', icon: 'edit' }
      },
      {
        path: 'account',
        component: () => import('@/views/system/account'),
        name: 'SystemAccount',
        meta: { title: '后台管理员', icon: 'peoples' }
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

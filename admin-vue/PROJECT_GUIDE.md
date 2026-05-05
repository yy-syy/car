# fuint 汽车服务会员营销系统 - 后台管理前端

## 项目概述

这是一个基于 Vue 2.x + Element UI 的汽车服务会员营销系统后台管理前端。

## 技术栈

- **框架**: Vue 2.6.12
- **UI 组件库**: Element UI 2.15.12
- **路由**: Vue Router 3.4.9
- **状态管理**: Vuex 3.6.0
- **HTTP 请求**: Axios 0.24.0
- **图表**: ECharts 4.9.0
- **构建工具**: Vue CLI 4
- **开发环境**: Node.js 16.x - 20.x

## 项目结构

```
admin-vue/
├── public/                  # 静态资源
│   ├── index.html          # HTML模板
│   └── favicon.ico         # 网站图标
├── src/
│   ├── api/                # API接口封装
│   │   ├── user.js         # 用户相关接口
│   │   └── home.js         # 首页相关接口
│   ├── assets/             # 静态资源
│   │   ├── images/         # 图片
│   │   ├── icons/          # SVG图标
│   │   └── styles/         # 全局样式
│   ├── components/         # 公共组件
│   │   ├── Hamburger/      # 汉堡菜单
│   │   ├── Pagination/     # 分页组件
│   │   └── SvgIcon/        # SVG图标组件
│   ├── directive/          # 自定义指令
│   │   └── waves/          # 水波纹指令
│   ├── filters/            # 过滤器
│   ├── layout/             # 布局组件
│   │   ├── components/     # 布局子组件
│   │   └── mixin/          # 布局mixin
│   ├── router/             # 路由配置
│   ├── store/              # Vuex状态管理
│   │   └── modules/        # 状态模块
│   ├── utils/              # 工具函数
│   ├── views/              # 页面视图
│   │   ├── dashboard/      # 首页
│   │   ├── login/          # 登录页
│   │   ├── error-page/     # 错误页面
│   │   ├── member/         # 会员管理
│   │   ├── order/          # 订单管理
│   │   ├── goods/          # 商品管理
│   │   ├── coupon/         # 卡券管理
│   │   ├── marketing/      # 营销管理
│   │   ├── content/        # 内容管理
│   │   ├── store/          # 店铺管理
│   │   └── system/         # 系统管理
│   ├── App.vue             # 根组件
│   ├── main.js             # 入口文件
│   └── permission.js       # 权限控制
├── .env.development        # 开发环境变量
├── .env.production         # 生产环境变量
├── .gitignore              # Git忽略文件
├── package.json            # 项目依赖
├── vue.config.js           # Vue CLI配置
└── README.md               # 项目说明
```

## 快速开始

### 环境要求

- Node.js >= 16.0.0 (推荐 LTS 版本)
- npm >= 6.0.0

### 安装依赖

```bash
cd admin-vue
npm install
```

如果 npm 下载速度慢，可以使用淘宝镜像：

```bash
npm install --registry=https://registry.npmmirror.com
```

### 启动开发服务器

```bash
npm run dev
```

启动后，浏览器访问: http://localhost:81

### 项目构建

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```

## 主要功能模块

### 1. 首页/数据看板
- 会员数量统计
- 订单数量统计
- 交易金额统计
- 数据趋势图表

### 2. 会员管理
- 会员列表
- 会员分组
- 会员等级

### 3. 订单管理
- 订单列表
- 退款管理

### 4. 商品管理
- 商品列表
- 商品分类

### 5. 卡券管理
- 卡券分组
- 卡券列表
- 会员卡券

### 6. 营销管理
- 开卡礼包
- 转赠记录
- 短信营销

### 7. 内容管理
- 焦点图
- 文章管理

### 8. 店铺管理
- 店铺列表
- 核销人员

### 9. 系统管理
- 账号管理
- 角色管理
- 菜单管理
- 操作日志

## API 接口说明

### 基础路径

开发环境: `/backendApi` (代理到 `http://localhost:8080`)

生产环境: `/backendApi` (代理到 `https://www.fuint.cn`)

### 主要接口

- **登录接口**: `/backendApi/login/doLogin`
- **获取用户信息**: `/backendApi/login/getInfo`
- **获取菜单**: `/backendApi/login/getRouters`
- **首页数据**: `/backendApi/home/index`
- **图表数据**: `/backendApi/home/statistic`

更多接口请参考后端 Swagger 文档。

## 后端接口参考

项目已提供完整的后端接口，位于:

```
backend/fuint-application/src/main/java/com/fuint/module/backendApi/controller/
```

主要的控制器包括:

- `BackendLoginController` - 登录相关
- `BackendHomeController` - 首页数据
- `BackendMemberController` - 会员管理
- `BackendOrderController` - 订单管理
- `BackendGoodsController` - 商品管理
- `BackendCouponController` - 卡券管理
- ... 等等

## 注意事项

1. 确保后端服务正常运行
2. 修改 `.env.development` 中的 `VUE_APP_SERVER_URL` 为你的后端地址
3. 当前页面大多为占位页面，需要根据实际需求完善功能
4. 建议先查看后端接口文档了解数据结构

## 开发建议

1. 参考后端接口实现前端功能
2. 按照现有的代码风格进行开发
3. 合理使用 Element UI 组件
4. 做好权限控制和路由守卫
5. 添加必要的错误处理

## 联系与支持

如有问题，请联系项目维护者或查看项目主 README.md。

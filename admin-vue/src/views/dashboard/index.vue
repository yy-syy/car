<template>
  <div class="dashboard-container">
    <!-- 运营概况 -->
    <div class="panel">
      <div class="panel-title">运营概况</div>
      <div class="panel-content">
        <div class="stat-row">
          <div class="stat-item" @click="$router.push('/order/list')">
            <div class="stat-icon">
              <i class="el-icon-document" />
            </div>
            <div class="stat-info">
              <p class="stat-label">今日新增订单数（笔）</p>
              <p class="stat-value red">{{ stats.todayOrder || 0 }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/order/list')">
            <div class="stat-icon">
              <i class="el-icon-money" />
            </div>
            <div class="stat-info">
              <p class="stat-label">今日交易金额（元）</p>
              <p class="stat-value green">{{ stats.todayPay || '0.00' }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/member/list')">
            <div class="stat-icon">
              <i class="el-icon-user" />
            </div>
            <div class="stat-info">
              <p class="stat-label">今日新增会员数</p>
              <p class="stat-value red">{{ stats.todayUser || 0 }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/member/list')">
            <div class="stat-icon">
              <i class="el-icon-s-custom" />
            </div>
            <div class="stat-info">
              <p class="stat-label">今日活跃会员数</p>
              <p class="stat-value red">{{ stats.todayActiveUser || 0 }}</p>
            </div>
          </div>
        </div>
        <div class="stat-row">
          <div class="stat-item" @click="$router.push('/member/list')">
            <div class="stat-icon">
              <i class="el-icon-s-check" />
            </div>
            <div class="stat-info">
              <p class="stat-label">总会员数</p>
              <p class="stat-value blue">{{ stats.totalUser || 0 }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/order/list')">
            <div class="stat-icon">
              <i class="el-icon-coin" />
            </div>
            <div class="stat-info">
              <p class="stat-label">总交易金额（元）</p>
              <p class="stat-value green">{{ stats.totalPay || '0.00' }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/order/list')">
            <div class="stat-icon">
              <i class="el-icon-s-order" />
            </div>
            <div class="stat-info">
              <p class="stat-label">总订单数</p>
              <p class="stat-value blue">{{ stats.totalOrder || 0 }}</p>
            </div>
          </div>
          <div class="stat-item" @click="$router.push('/order/list')">
            <div class="stat-icon">
              <i class="el-icon-s-goods" />
            </div>
            <div class="stat-info">
              <p class="stat-label">总支付人数</p>
              <p class="stat-value blue">{{ stats.totalPayUser || 0 }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 常用功能 -->
    <div class="panel">
      <div class="panel-title">常用功能</div>
      <div class="panel-content">
        <div class="shortcut-row">
          <div class="shortcut-item" @click="$router.push('/cashier')">
            <div class="shortcut-icon">
              <i class="el-icon-s-shop" />
            </div>
            <span>收银开单</span>
          </div>
          <div class="shortcut-item" @click="$router.push('/coupon/list')">
            <div class="shortcut-icon">
              <i class="el-icon-s-ticket" />
            </div>
            <span>核销卡券</span>
          </div>
          <div class="shortcut-item" @click="$router.push('/member/list')">
            <div class="shortcut-icon">
              <i class="el-icon-s-custom" />
            </div>
            <span>会员管理</span>
          </div>
        </div>
        <div class="shortcut-row">
          <div class="shortcut-item" @click="$router.push('/order/list')">
            <div class="shortcut-icon">
              <i class="el-icon-s-order" />
            </div>
            <span>订单管理</span>
          </div>
          <div class="shortcut-item" @click="$router.push('/coupon/list')">
            <div class="shortcut-icon">
              <i class="el-icon-s-ticket" />
            </div>
            <span>卡券管理</span>
          </div>
          <div class="shortcut-item" @click="$router.push('/goods/list')">
            <div class="shortcut-icon">
              <i class="el-icon-goods" />
            </div>
            <span>商品管理</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 报表统计 -->
    <div class="panel">
      <div class="panel-title">报表统计</div>
      <div class="panel-content">
        <div class="chart-placeholder">
          <div id="orderChart" style="height: 300px; width: 100%;"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getDashboardStats } from '@/api/home'

export default {
  name: 'Dashboard',
  data() {
    return {
      stats: {
        todayOrder: 0,
        todayPay: '0.00',
        todayUser: 0,
        todayActiveUser: 0,
        totalUser: 0,
        totalPay: '0.00',
        totalOrder: 0,
        totalPayUser: 0
      }
    }
  },
  created() {
    this.fetchStats()
  },
  methods: {
    fetchStats() {
      getDashboardStats().then(response => {
        if (response && response.data) {
          this.stats = { ...this.stats, ...response.data }
        }
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 20px;
}

.panel {
  background: #fff;
  border-radius: 4px;
  margin-bottom: 20px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04);

  .panel-title {
    padding: 15px 20px;
    font-size: 16px;
    font-weight: 600;
    color: #333;
    border-bottom: 1px solid #f0f0f0;
  }

  .panel-content {
    padding: 20px;
  }
}

.stat-row {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;

  &:last-child {
    margin-bottom: 0;
  }
}

.stat-item {
  flex: 1;
  display: flex;
  align-items: center;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 6px;
  cursor: pointer;
  transition: box-shadow 0.3s;

  &:hover {
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  }

  .stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    border: 2px solid #4a7bdc;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    flex-shrink: 0;

    i {
      font-size: 22px;
      color: #4a7bdc;
    }
  }

  .stat-info {
    .stat-label {
      font-size: 14px;
      color: #666;
      margin: 0 0 8px;
    }

    .stat-value {
      font-size: 22px;
      font-weight: 700;
      margin: 0;

      &.red { color: #ff4d4f; }
      &.green { color: #52c41a; }
      &.blue { color: #1890ff; }
    }
  }
}

.shortcut-row {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;

  &:last-child {
    margin-bottom: 0;
  }
}

.shortcut-item {
  flex: 1;
  display: flex;
  align-items: center;
  padding: 20px 30px;
  border: 1px solid #eee;
  border-radius: 6px;
  cursor: pointer;
  transition: box-shadow 0.3s;

  &:hover {
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  }

  .shortcut-icon {
    width: 48px;
    height: 48px;
    border-radius: 8px;
    background: #f5f7fa;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;

    i {
      font-size: 24px;
      color: #4a7bdc;
    }
  }

  span {
    font-size: 14px;
    color: #333;
  }
}

.chart-placeholder {
  min-height: 300px;
}
</style>

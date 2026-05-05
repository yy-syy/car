<template>
  <div class="dashboard-container">
    <div class="dashboard-header">
      <h2>数据概览</h2>
    </div>
    
    <div class="stats-cards">
      <div class="stat-card">
        <div class="stat-icon bg-blue">
          <i class="el-icon-user" />
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.totalMember }}</div>
          <div class="stat-label">会员总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon bg-green">
          <i class="el-icon-shopping-cart" />
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.totalOrder }}</div>
          <div class="stat-label">订单总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon bg-orange">
          <i class="el-icon-ticket" />
        </div>
        <div class="stat-content">
          <div class="stat-value">{{ stats.totalCoupon }}</div>
          <div class="stat-label">卡券总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon bg-purple">
          <i class="el-icon-wallet" />
        </div>
        <div class="stat-content">
          <div class="stat-value">￥{{ stats.totalBalance }}</div>
          <div class="stat-label">充值余额</div>
        </div>
      </div>
    </div>
    
    <div class="charts-row">
      <div class="chart-card">
        <h3>订单趋势</h3>
        <div id="orderChart" style="height: 300px;"></div>
      </div>
      
      <div class="chart-card">
        <h3>会员增长</h3>
        <div id="memberChart" style="height: 300px;"></div>
      </div>
    </div>
    
    <div class="charts-row">
      <div class="chart-card full-width">
        <h3>会员等级分布</h3>
        <div id="gradeChart" style="height: 300px;"></div>
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
        totalMember: 0,
        totalOrder: 0,
        totalCoupon: 0,
        totalBalance: 0
      }
    }
  },
  created() {
    this.fetchStats()
  },
  methods: {
    fetchStats() {
      getDashboardStats().then(response => {
        this.stats = response.data
      })
    }
  }
}
</script>

<style scoped>
.dashboard-container {
  padding: 20px;
}
.dashboard-header {
  margin-bottom: 20px;
}
.dashboard-header h2 {
  font-size: 20px;
  font-weight: bold;
  color: #333;
}
.stats-cards {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}
.stat-card {
  flex: 1;
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 15px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}
.stat-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  color: #fff;
}
.stat-icon.bg-blue {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
.stat-icon.bg-green {
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
}
.stat-icon.bg-orange {
  background: linear-gradient(135deg, #fc4a1a 0%, #f7b733 100%);
}
.stat-icon.bg-purple {
  background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
}
.stat-content {
  flex: 1;
}
.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #333;
}
.stat-label {
  font-size: 14px;
  color: #999;
  margin-top: 5px;
}
.charts-row {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}
.chart-card {
  flex: 1;
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}
.chart-card.full-width {
  flex: 100%;
}
.chart-card h3 {
  font-size: 16px;
  font-weight: bold;
  color: #333;
  margin-bottom: 15px;
}
</style>
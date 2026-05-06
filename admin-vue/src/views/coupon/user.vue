<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.realName" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="searchForm.mobile" placeholder="请输入手机号码" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="userCouponList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="couponName" label="卡券名称" />
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="receiveTime" label="领取时间" width="160" />
        <el-table-column prop="expireTime" label="过期时间" width="160" />
        <el-table-column prop="useTime" label="使用时间" width="160" />
      </el-table>

      <el-pagination
        :total="total"
        :page-size="pageSize"
        :current-page="pageNum"
        :layout="layout"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script>
import { fetchUserCouponList } from '@/api/coupon'

export default {
  name: 'UserCouponList',
  data() {
    return {
      searchForm: {
        realName: '',
        mobile: ''
      },
      userCouponList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchUserCouponList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.userCouponList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { realName: '', mobile: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    getStatusText(status) {
      const map = {
        UNUSED: '未使用',
        USED: '已使用',
        EXPIRED: '已过期'
      }
      return map[status] || status
    },
    getStatusType(status) {
      const map = {
        UNUSED: 'warning',
        USED: 'success',
        EXPIRED: 'danger'
      }
      return map[status] || 'default'
    }
  }
}
</script>

<style scoped>
.search-bar {
  margin-bottom: 20px;
}
.table-container {
  background: #fff;
  padding: 20px;
}
</style>
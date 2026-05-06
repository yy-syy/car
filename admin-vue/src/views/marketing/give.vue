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
        <el-form-item label="领取状态">
          <el-select v-model="searchForm.status" placeholder="请选择领取状态">
            <el-option label="全部" value="" />
            <el-option label="待领取" value="PENDING" />
            <el-option label="已领取" value="RECEIVED" />
            <el-option label="已过期" value="EXPIRED" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="giveList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="couponName" label="卡券名称" />
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="status" label="领取状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="receiveTime" label="领取时间" width="160" />
        <el-table-column prop="expireTime" label="过期时间" width="160" />
        <el-table-column prop="createTime" label="创建时间" width="160" />
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
import { fetchGiveList } from '@/api/marketing'

export default {
  name: 'GiveList',
  data() {
    return {
      searchForm: {
        realName: '',
        mobile: '',
        status: ''
      },
      giveList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false
    }
  },
  created() {
    this.fetchGives()
  },
  methods: {
    fetchGives() {
      this.loading = true
      fetchGiveList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.giveList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchGives() },
    handleReset() { this.searchForm = { realName: '', mobile: '', status: '' }; this.fetchGives() },
    handleSizeChange(val) { this.pageSize = val; this.fetchGives() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchGives() },
    getStatusText(status) {
      const map = {
        PENDING: '待领取',
        RECEIVED: '已领取',
        EXPIRED: '已过期'
      }
      return map[status] || status
    },
    getStatusType(status) {
      const map = {
        PENDING: 'warning',
        RECEIVED: 'success',
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
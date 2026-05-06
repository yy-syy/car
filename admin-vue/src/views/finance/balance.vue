<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.memberName" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="记录类型">
          <el-select v-model="searchForm.type" placeholder="请选择记录类型">
            <el-option label="全部" value="" />
            <el-option label="充值" value="RECHARGE" />
            <el-option label="消费" value="CONSUME" />
            <el-option label="退款" value="REFUND" />
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
        :data="balanceList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="memberName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="type" label="记录类型" width="120">
          <template slot-scope="scope">
            <el-tag :type="getTypeType(scope.row.type)">
              {{ getTypeText(scope.row.type) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="amount" label="金额" width="120">
          <template slot-scope="scope">
            <span :class="scope.row.type === 'RECHARGE' ? 'text-success' : 'text-danger'">
              {{ scope.row.type === 'RECHARGE' ? '+' : '-' }}￥{{ scope.row.amount }}
            </span>
          </template>
        </el-table-column>
        <el-table-column prop="balance" label="余额" width="120">
          <template slot-scope="scope">￥{{ scope.row.balance }}</template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" />
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
import { fetchBalanceList } from '@/api/finance'

export default {
  name: 'BalanceList',
  data() {
    return {
      searchForm: {
        memberName: '',
        type: ''
      },
      balanceList: [],
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
      fetchBalanceList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.balanceList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { memberName: '', type: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    getTypeText(type) {
      const map = { RECHARGE: '充值', CONSUME: '消费', REFUND: '退款' }
      return map[type] || type
    },
    getTypeType(type) {
      const map = { RECHARGE: 'success', CONSUME: 'warning', REFUND: 'info' }
      return map[type] || 'default'
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
.text-success {
  color: #67c23a;
}
.text-danger {
  color: #f56c6c;
}
</style>
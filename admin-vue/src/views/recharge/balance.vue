<template>
  <div class="app-container">
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="userName" label="会员" />
      <el-table-column prop="orderSn" label="订单号" />
      <el-table-column prop="amount" label="变动金额" width="120">
        <template slot-scope="scope">
          <span :style="{color: scope.row.amount > 0 ? '#67c23a' : '#f56c6c'}">{{ scope.row.amount > 0 ? '+' : '' }}{{ scope.row.amount }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="备注" />
      <el-table-column prop="createTime" label="时间" width="160" />
    </el-table>
    <el-pagination :total="total" :page-size="pageSize" :current-page="pageNum" layout="total, sizes, prev, pager, next, jumper" @current-change="handleCurrentChange" @size-change="handleSizeChange" style="margin-top:15px;" />
  </div>
</template>
<script>
import { getBalanceList } from '@/api/recharge'
export default {
  name: 'RechargeBalance',
  data() { return { list: [], loading: false, total: 0, pageNum: 1, pageSize: 10 } },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getBalanceList({ page: this.pageNum, pageSize: this.pageSize }).then(res => {
        if (res.data) { this.list = res.data.content || res.data.list || []; this.total = res.data.totalElements || res.data.total || 0 }
      }).finally(() => { this.loading = false })
    },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() }
  }
}
</script>

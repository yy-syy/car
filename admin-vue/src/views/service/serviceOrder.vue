<template>
  <div class="app-container">
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="orderSn" label="订单号" width="180" />
      <el-table-column prop="userName" label="客户" width="100" />
      <el-table-column prop="plateNo" label="车牌号" width="120" />
      <el-table-column prop="serviceName" label="服务项目" />
      <el-table-column prop="amount" label="金额" width="100" />
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 'paid' ? 'success' : scope.row.status === 'created' ? 'warning' : 'info'">{{ scope.row.statusText || scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="160" />
    </el-table>
    <el-pagination :total="total" :page-size="pageSize" :current-page="pageNum" layout="total, sizes, prev, pager, next, jumper" @current-change="handleCurrentChange" @size-change="handleSizeChange" style="margin-top:15px;" />
  </div>
</template>
<script>
import { getVehicleOrderList } from '@/api/vehicle'
export default {
  name: 'ServiceOrder',
  data() { return { list: [], loading: false, total: 0, pageNum: 1, pageSize: 10 } },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getVehicleOrderList({ page: this.pageNum, pageSize: this.pageSize }).then(res => {
        if (res.data) { this.list = res.data.content || res.data.list || []; this.total = res.data.totalElements || res.data.total || 0 }
      }).finally(() => { this.loading = false })
    },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() }
  }
}
</script>

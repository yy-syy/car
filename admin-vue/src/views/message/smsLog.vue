<template>
  <div class="app-container">
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="mobile" label="手机号" width="130" />
      <el-table-column prop="content" label="短信内容" show-overflow-tooltip />
      <el-table-column prop="sendTime" label="发送时间" width="160" />
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 'A' ? 'success' : 'danger'">{{ scope.row.status === 'A' ? '成功' : '失败' }}</el-tag>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination :total="total" :page-size="pageSize" :current-page="pageNum" layout="total, sizes, prev, pager, next, jumper" @current-change="handleCurrentChange" @size-change="handleSizeChange" style="margin-top:15px;" />
  </div>
</template>
<script>
import { getSmsLogList } from '@/api/message'
export default {
  name: 'SmsLog',
  data() { return { list: [], loading: false, total: 0, pageNum: 1, pageSize: 10 } },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getSmsLogList({ page: this.pageNum, pageSize: this.pageSize }).then(res => {
        if (res.data) { this.list = res.data.content || res.data.list || []; this.total = res.data.totalElements || res.data.total || 0 }
      }).finally(() => { this.loading = false })
    },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() }
  }
}
</script>

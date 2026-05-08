<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="设备名称">
          <el-input v-model="searchForm.name" placeholder="请输入" style="width:150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" label="设备名称" />
      <el-table-column prop="sn" label="设备编号" />
      <el-table-column prop="storeName" label="所属门店" />
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 'A' ? 'success' : 'danger'">{{ scope.row.status === 'A' ? '启用' : '禁用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="160" />
    </el-table>
    <el-pagination :total="total" :page-size="pageSize" :current-page="pageNum" layout="total, sizes, prev, pager, next, jumper" @current-change="handleCurrentChange" @size-change="handleSizeChange" style="margin-top:15px;" />
  </div>
</template>
<script>
import { getPrinterList } from '@/api/device'
export default {
  name: 'DeviceList',
  data() {
    return { list: [], loading: false, total: 0, pageNum: 1, pageSize: 10, searchForm: { name: '' } }
  },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getPrinterList({ page: this.pageNum, pageSize: this.pageSize, ...this.searchForm }).then(res => {
        if (res.data) { this.list = res.data.content || res.data.list || []; this.total = res.data.totalElements || res.data.total || 0 }
      }).finally(() => { this.loading = false })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { name: '' }; this.handleSearch() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() }
  }
}
</script>

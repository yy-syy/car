<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="操作人">
          <el-input v-model="searchForm.accountName" placeholder="请输入操作人" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="模块">
          <el-input v-model="searchForm.module" placeholder="请输入模块" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table :data="logList" :loading="loading" border stripe>
        <el-table-column prop="logId" label="日志ID" width="100" />
        <el-table-column prop="accountName" label="操作人" width="120" />
        <el-table-column prop="module" label="模块" width="150" />
        <el-table-column prop="content" label="操作内容" />
        <el-table-column prop="ip" label="IP地址" width="140" />
        <el-table-column prop="userAgent" label="浏览器" width="150" />
        <el-table-column prop="createTime" label="操作时间" width="160" />
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
import { fetchLogList } from '@/api/system'

export default {
  name: 'LogList',
  data() {
    return {
      searchForm: {
        accountName: '',
        module: ''
      },
      logList: [],
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
      fetchLogList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.logList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { accountName: '', module: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() }
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
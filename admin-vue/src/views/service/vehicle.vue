<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="车牌号">
          <el-input v-model="searchForm.plateNo" placeholder="请输入车牌号" style="width:150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-table :data="list" border stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="plateNo" label="车牌号" width="120" />
      <el-table-column prop="brand" label="品牌" />
      <el-table-column prop="model" label="车型" />
      <el-table-column prop="color" label="颜色" width="80" />
      <el-table-column prop="userName" label="车主" width="100" />
      <el-table-column prop="mobile" label="手机号" width="130" />
      <el-table-column prop="createTime" label="创建时间" width="160" />
      <el-table-column label="操作" width="150">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination :total="total" :page-size="pageSize" :current-page="pageNum" layout="total, sizes, prev, pager, next, jumper" @current-change="handleCurrentChange" @size-change="handleSizeChange" style="margin-top:15px;" />
  </div>
</template>
<script>
import { getVehicleList, deleteVehicle } from '@/api/vehicle'
export default {
  name: 'ServiceVehicle',
  data() { return { list: [], loading: false, total: 0, pageNum: 1, pageSize: 10, searchForm: { plateNo: '' } } },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getVehicleList({ page: this.pageNum, pageSize: this.pageSize, ...this.searchForm }).then(res => {
        if (res.data) { this.list = res.data.content || res.data.list || []; this.total = res.data.totalElements || res.data.total || 0 }
      }).finally(() => { this.loading = false })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { plateNo: '' }; this.handleSearch() },
    handleEdit(row) { this.$message.info('编辑: ' + row.plateNo) },
    handleDelete(row) {
      this.$confirm('确认删除?', '提示', { type: 'warning' }).then(() => {
        deleteVehicle(row.id).then(() => { this.$message.success('删除成功'); this.fetchData() })
      }).catch(() => {})
    },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() }
  }
}
</script>

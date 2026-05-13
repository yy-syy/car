<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="分类名称">
          <el-input v-model="queryParams.name" placeholder="请输入分类名称" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
          <el-button type="success" icon="el-icon-plus" @click="handleAdd">新增分类</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table v-loading="loading" :data="categoryList" border stripe>
        <el-table-column prop="id" label="ID" width="60" align="center" />
        <el-table-column prop="name" label="分类名称" min-width="150" />
        <el-table-column prop="description" label="描述" min-width="200" show-overflow-tooltip />
        <el-table-column prop="sort" label="排序" width="80" align="center" />
        <el-table-column label="状态" width="80" align="center">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.status" active-value="A" inactive-value="N" @change="handleStatusChange(scope.row)" />
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" align="center" />
        <el-table-column label="操作" width="150" align="center">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" plain @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-container">
        <el-pagination
          :current-page="queryParams.page"
          :page-sizes="[10, 20, 50]"
          :page-size="queryParams.pageSize"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="500px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="80px">
        <el-form-item label="分类名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入分类名称" />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="formData.sort" :min="0" style="width: 100%" />
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入描述" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getCategoryList, saveCategory, updateCategoryStatus } from '@/api/goods'

export default {
  name: 'GoodsCategory',
  data() {
    return {
      loading: false,
      categoryList: [],
      total: 0,
      queryParams: { page: 1, pageSize: 10, name: '' },
      dialogVisible: false,
      dialogTitle: '',
      formData: { id: '', name: '', sort: 0, description: '' },
      formRules: {
        name: [{ required: true, message: '请输入分类名称', trigger: 'blur' }]
      }
    }
  },
  created() { this.fetchData() },
  methods: {
    fetchData() {
      this.loading = true
      getCategoryList(this.queryParams).then(res => {
        this.categoryList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => { this.loading = false })
    },
    handleSearch() { this.queryParams.page = 1; this.fetchData() },
    handleReset() { this.queryParams = { page: 1, pageSize: 10, name: '' }; this.fetchData() },
    handleSizeChange(val) { this.queryParams.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.queryParams.page = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增分类'
      this.formData = { id: '', name: '', sort: 0, description: '' }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleEdit(row) {
      this.dialogTitle = '编辑分类'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        saveCategory(this.formData).then(() => {
          this.$message.success(this.formData.id ? '修改成功' : '新增成功')
          this.dialogVisible = false
          this.fetchData()
        })
      })
    },
    handleStatusChange(row) {
      updateCategoryStatus({ cateId: row.id, status: row.status }).then(() => {
        this.$message.success('操作成功')
      }).catch(() => {
        row.status = row.status === 'A' ? 'N' : 'A'
      })
    },
    handleDelete(row) {
      this.$confirm('确定要删除该分类？', '提示', { type: 'warning' }).then(() => {
        updateCategoryStatus({ cateId: row.id, status: 'D' }).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    }
  }
}
</script>

<style scoped>
.filter-container { padding: 20px; background: #fff; margin-bottom: 15px; border-radius: 4px; }
.table-container { padding: 20px; background: #fff; border-radius: 4px; }
.pagination-container { margin-top: 20px; text-align: right; }
</style>

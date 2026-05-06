<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="等级名称">
          <el-input v-model="searchForm.gradeName" placeholder="请输入等级名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增等级</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="gradeList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="gradeName" label="等级名称" />
        <el-table-column prop="minPoint" label="最低积分" width="120" />
        <el-table-column prop="maxPoint" label="最高积分" width="120" />
        <el-table-column prop="discount" label="折扣率" width="100">
          <template slot-scope="scope">{{ scope.row.discount }}%</template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 'ENABLE' ? 'success' : 'danger'">
              {{ scope.row.status === 'ENABLE' ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" />
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
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

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="600px">
      <el-form :model="formData" :rules="formRules" ref="formRef" label-width="80px">
        <el-form-item label="等级名称" prop="gradeName">
          <el-input v-model="formData.gradeName" placeholder="请输入等级名称" />
        </el-form-item>
        <el-form-item label="最低积分" prop="minPoint">
          <el-input v-model="formData.minPoint" type="number" placeholder="请输入最低积分" />
        </el-form-item>
        <el-form-item label="最高积分" prop="maxPoint">
          <el-input v-model="formData.maxPoint" type="number" placeholder="请输入最高积分" />
        </el-form-item>
        <el-form-item label="折扣率" prop="discount">
          <el-input v-model="formData.discount" type="number" placeholder="请输入折扣率(%)" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="formData.status" active-value="ENABLE" inactive-value="DISABLE" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { fetchGradeList, addGrade, updateGrade, deleteGrade } from '@/api/member'

export default {
  name: 'GradeList',
  data() {
    return {
      searchForm: {
        gradeName: ''
      },
      gradeList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false,
      dialogVisible: false,
      dialogTitle: '',
      formRef: '',
      formData: {
        gradeId: '',
        gradeName: '',
        minPoint: 0,
        maxPoint: 0,
        discount: 100,
        status: 'ENABLE'
      },
      formRules: {
        gradeName: [{ required: true, message: '请输入等级名称', trigger: 'blur' }],
        minPoint: [{ required: true, message: '请输入最低积分', trigger: 'blur' }],
        maxPoint: [{ required: true, message: '请输入最高积分', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchGradeList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.gradeList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { gradeName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增等级'
      this.formData = { gradeId: '', gradeName: '', minPoint: 0, maxPoint: 0, discount: 100, status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑等级'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteGrade(row.gradeId).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.gradeId ? updateGrade : addGrade
          api(this.formData).then(() => {
            this.$message.success(this.formData.gradeId ? '修改成功' : '新增成功')
            this.dialogVisible = false
            this.fetchData()
          })
        }
      })
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
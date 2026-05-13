<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="员工姓名">
          <el-input v-model="queryParams.realName" placeholder="请输入员工姓名" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="queryParams.mobile" placeholder="请输入手机号" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="所属店铺">
          <el-select v-model="queryParams.storeId" placeholder="全部" clearable style="width: 160px">
            <el-option v-for="item in storeOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
          <el-button type="success" icon="el-icon-plus" @click="handleAdd">新增员工</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table v-loading="loading" :data="staffList" border stripe>
        <el-table-column prop="id" label="ID" width="60" align="center" />
        <el-table-column prop="realName" label="员工姓名" width="100" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column label="所属店铺" min-width="120">
          <template slot-scope="scope">{{ scope.row.storeName || '-' }}</template>
        </el-table-column>
        <el-table-column label="员工类别" width="100" align="center">
          <template slot-scope="scope">
            <el-tag :type="categoryTagType(scope.row.category)" size="small">
              {{ categoryText(scope.row.category) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="审核状态" width="100" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.auditedStatus === 'A' ? 'success' : 'warning'" size="small">
              {{ scope.row.auditedStatus === 'A' ? '已审核' : '待审核' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" align="center" />
        <el-table-column label="操作" width="200" align="center" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
            <el-button v-if="scope.row.auditedStatus !== 'A'" size="mini" type="success" plain @click="handleAudit(scope.row)">审核</el-button>
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

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="550px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-form-item label="员工姓名" prop="realName">
          <el-input v-model="formData.realName" placeholder="请输入员工姓名" />
        </el-form-item>
        <el-form-item label="手机号码" prop="mobile">
          <el-input v-model="formData.mobile" placeholder="请输入手机号码" />
        </el-form-item>
        <el-form-item label="所属店铺" prop="storeId">
          <el-select v-model="formData.storeId" placeholder="请选择店铺" style="width: 100%">
            <el-option v-for="item in storeOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="员工类别" prop="category">
          <el-select v-model="formData.category" placeholder="请选择类别" style="width: 100%">
            <el-option :value="1" label="店长" />
            <el-option :value="2" label="收银员" />
            <el-option :value="3" label="技师" />
            <el-option :value="4" label="销售人员" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="formData.description" type="textarea" :rows="2" placeholder="请输入备注" />
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
import { getStaffList, saveStaff, updateStaffStatus, getStoreList } from '@/api/store'

export default {
  name: 'StaffList',
  data() {
    return {
      loading: false,
      staffList: [],
      storeOptions: [],
      total: 0,
      queryParams: { page: 1, pageSize: 10, realName: '', mobile: '', storeId: '' },
      dialogVisible: false,
      dialogTitle: '',
      formData: { id: '', realName: '', mobile: '', storeId: '', category: '', description: '' },
      formRules: {
        realName: [{ required: true, message: '请输入员工姓名', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入手机号码', trigger: 'blur' }],
        storeId: [{ required: true, message: '请选择店铺', trigger: 'change' }],
        category: [{ required: true, message: '请选择类别', trigger: 'change' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchStores()
  },
  methods: {
    fetchData() {
      this.loading = true
      getStaffList(this.queryParams).then(res => {
        this.staffList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => { this.loading = false })
    },
    fetchStores() {
      getStoreList({ page: 1, pageSize: 100 }).then(res => {
        this.storeOptions = res.data.list || []
      })
    },
    categoryText(val) {
      const map = { 1: '店长', 2: '收银员', 3: '技师', 4: '销售' }
      return map[val] || '其他'
    },
    categoryTagType(val) {
      const map = { 1: 'danger', 2: 'warning', 3: 'success', 4: '' }
      return map[val] || 'info'
    },
    handleSearch() { this.queryParams.page = 1; this.fetchData() },
    handleReset() { this.queryParams = { page: 1, pageSize: 10, realName: '', mobile: '', storeId: '' }; this.fetchData() },
    handleSizeChange(val) { this.queryParams.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.queryParams.page = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增员工'
      this.formData = { id: '', realName: '', mobile: '', storeId: '', category: '', description: '' }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleEdit(row) {
      this.dialogTitle = '编辑员工'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        saveStaff(this.formData).then(() => {
          this.$message.success(this.formData.id ? '修改成功' : '新增成功')
          this.dialogVisible = false
          this.fetchData()
        })
      })
    },
    handleAudit(row) {
      this.$confirm('确定审核通过该员工？', '提示').then(() => {
        updateStaffStatus({ staffId: row.id, auditedStatus: 'A' }).then(() => {
          this.$message.success('审核通过')
          this.fetchData()
        })
      })
    },
    handleDelete(row) {
      this.$confirm('确定要删除该员工？', '提示', { type: 'warning' }).then(() => {
        updateStaffStatus({ staffId: row.id, status: 'D' }).then(() => {
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

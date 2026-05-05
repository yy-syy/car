<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="员工姓名">
          <el-input v-model="searchForm.staffName" placeholder="请输入员工姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增员工</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="staffList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="staffName" label="员工姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="storeName" label="所属门店" width="150" />
        <el-table-column prop="position" label="职位" width="120" />
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 'ENABLE' ? 'success' : 'danger'">
              {{ scope.row.status === 'ENABLE' ? '在职' : '离职' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="入职时间" width="160" />
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
        <el-form-item label="员工姓名" prop="staffName">
          <el-input v-model="formData.staffName" placeholder="请输入员工姓名" />
        </el-form-item>
        <el-form-item label="手机号码" prop="mobile">
          <el-input v-model="formData.mobile" placeholder="请输入手机号码" />
        </el-form-item>
        <el-form-item label="所属门店" prop="storeId">
          <el-select v-model="formData.storeId" placeholder="请选择门店">
            <el-option v-for="item in storeOptions" :key="item.id" :label="item.storeName" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="职位" prop="position">
          <el-input v-model="formData.position" placeholder="请输入职位" />
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
import { fetchStaffList, addStaff, updateStaff, deleteStaff } from '@/api/store'
import { fetchStoreList } from '@/api/store'

export default {
  name: 'StaffList',
  data() {
    return {
      searchForm: {
        staffName: ''
      },
      staffList: [],
      storeOptions: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false,
      dialogVisible: false,
      dialogTitle: '',
      formRef: '',
      formData: {
        id: '',
        staffName: '',
        mobile: '',
        storeId: '',
        position: '',
        status: 'ENABLE'
      },
      formRules: {
        staffName: [{ required: true, message: '请输入员工姓名', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入手机号码', trigger: 'blur' }],
        storeId: [{ required: true, message: '请选择门店', trigger: 'blur' }]
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
      fetchStaffList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.staffList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchStores() {
      fetchStoreList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.storeOptions = response.data.list
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { staffName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增员工'
      this.formData = { id: '', staffName: '', mobile: '', storeId: '', position: '', status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑员工'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteStaff(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateStaff : addStaff
          api(this.formData).then(() => {
            this.$message.success(this.formData.id ? '修改成功' : '新增成功')
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
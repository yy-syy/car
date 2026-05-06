<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="用户名">
          <el-input v-model="searchForm.username" placeholder="请输入用户名" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增账号</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="accountList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="username" label="用户名" width="120" />
        <el-table-column prop="realName" label="真实姓名" width="120" />
        <el-table-column prop="roleName" label="角色" width="120" />
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
        <el-form-item label="用户名" prop="username">
          <el-input v-model="formData.username" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="真实姓名" prop="realName">
          <el-input v-model="formData.realName" placeholder="请输入真实姓名" />
        </el-form-item>
        <el-form-item label="密码" :prop="formData.id ? '' : 'password'">
          <el-input v-model="formData.password" type="password" :placeholder="formData.id ? '不修改请留空' : '请输入密码'" />
        </el-form-item>
        <el-form-item label="角色" prop="roleId">
          <el-select v-model="formData.roleId" placeholder="请选择角色">
            <el-option v-for="item in roleOptions" :key="item.id" :label="item.roleName" :value="item.id" />
          </el-select>
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
import { fetchAccountList, addAccount, updateAccount, deleteAccount } from '@/api/system'
import { fetchRoleList } from '@/api/system'

export default {
  name: 'AccountList',
  data() {
    return {
      searchForm: {
        username: ''
      },
      accountList: [],
      roleOptions: [],
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
        username: '',
        realName: '',
        password: '',
        roleId: '',
        status: 'ENABLE'
      },
      formRules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
        roleId: [{ required: true, message: '请选择角色', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchRoles()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchAccountList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.accountList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchRoles() {
      fetchRoleList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.roleOptions = response.data.list
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { username: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增账号'
      this.formData = { id: '', username: '', realName: '', password: '', roleId: '', status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑账号'
      this.formData = { ...row, password: '' }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteAccount(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      const rules = this.formData.id ? {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
        roleId: [{ required: true, message: '请选择角色', trigger: 'blur' }]
      } : this.formRules
      
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateAccount : addAccount
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
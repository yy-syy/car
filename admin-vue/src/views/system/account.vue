<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="账户名">
          <el-input v-model="queryParams.accountName" placeholder="请输入账户名" clearable style="width: 180px" />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="queryParams.realName" placeholder="请输入姓名" clearable style="width: 150px" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.accountStatus" placeholder="全部" clearable style="width: 100px">
            <el-option label="有效" :value="1" />
            <el-option label="无效" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
          <el-button type="success" icon="el-icon-plus" @click="handleAdd">新增管理员</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table v-loading="loading" :data="accountList" border stripe>
        <el-table-column prop="acctId" label="ID" width="60" align="center" />
        <el-table-column prop="accountName" label="账户名" width="120" />
        <el-table-column prop="realName" label="真实姓名" width="120" />
        <el-table-column label="所属角色" min-width="120">
          <template slot-scope="scope">{{ scope.row.roleName || '-' }}</template>
        </el-table-column>
        <el-table-column label="所属商户" min-width="120">
          <template slot-scope="scope">{{ scope.row.merchantName || '平台' }}</template>
        </el-table-column>
        <el-table-column label="所属店铺" min-width="120">
          <template slot-scope="scope">{{ scope.row.storeName || '-' }}</template>
        </el-table-column>
        <el-table-column label="状态" width="80" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.accountStatus === 1 ? 'success' : 'danger'" size="small">
              {{ scope.row.accountStatus === 1 ? '有效' : '无效' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createDate" label="创建时间" width="160" align="center" />
        <el-table-column label="操作" width="220" align="center" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="warning" plain @click="handleResetPwd(scope.row)">重置密码</el-button>
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
        <el-form-item label="账户名" prop="accountName">
          <el-input v-model="formData.accountName" placeholder="请输入账户名" :disabled="!!formData.acctId" />
        </el-form-item>
        <el-form-item v-if="!formData.acctId" label="密码" prop="password">
          <el-input v-model="formData.password" type="password" placeholder="请输入密码" show-password />
        </el-form-item>
        <el-form-item label="真实姓名" prop="realName">
          <el-input v-model="formData.realName" placeholder="请输入真实姓名" />
        </el-form-item>
        <el-form-item label="角色" prop="roleIds">
          <el-select v-model="formData.roleIds" placeholder="请选择角色" style="width: 100%">
            <el-option v-for="item in roleOptions" :key="item.dutyId" :label="item.dutyName" :value="item.dutyId + ''" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属店铺">
          <el-select v-model="formData.storeId" placeholder="请选择（可选）" clearable style="width: 100%">
            <el-option v-for="item in storeOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="formData.accountStatus">
            <el-radio :label="1">有效</el-radio>
            <el-radio :label="0">无效</el-radio>
          </el-radio-group>
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
import { getAccountList, createAccount, updateAccount, deleteAccount, resetAccountPwd, getDutyList } from '@/api/system'
import { getStoreList } from '@/api/store'

export default {
  name: 'SystemAccount',
  data() {
    return {
      loading: false,
      accountList: [],
      roleOptions: [],
      storeOptions: [],
      total: 0,
      queryParams: { page: 1, pageSize: 10, accountName: '', realName: '', accountStatus: '' },
      dialogVisible: false,
      dialogTitle: '',
      formData: { acctId: '', accountName: '', password: '', realName: '', roleIds: '', storeId: '', merchantId: 0, accountStatus: 1 },
      formRules: {
        accountName: [{ required: true, message: '请输入账户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
        roleIds: [{ required: true, message: '请选择角色', trigger: 'change' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchRoles()
    this.fetchStores()
  },
  methods: {
    fetchData() {
      this.loading = true
      getAccountList(this.queryParams).then(res => {
        this.accountList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => { this.loading = false })
    },
    fetchRoles() {
      getDutyList({ page: 1, pageSize: 100 }).then(res => {
        this.roleOptions = res.data.list || res.data || []
      })
    },
    fetchStores() {
      getStoreList({ page: 1, pageSize: 100 }).then(res => {
        this.storeOptions = res.data.list || []
      })
    },
    handleSearch() { this.queryParams.page = 1; this.fetchData() },
    handleReset() { this.queryParams = { page: 1, pageSize: 10, accountName: '', realName: '', accountStatus: '' }; this.fetchData() },
    handleSizeChange(val) { this.queryParams.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.queryParams.page = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增管理员'
      this.formData = { acctId: '', accountName: '', password: '', realName: '', roleIds: '', storeId: '', merchantId: 0, accountStatus: 1 }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleEdit(row) {
      this.dialogTitle = '编辑管理员'
      this.formData = { ...row, roleIds: row.roleIds ? row.roleIds + '' : '' }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        const api = this.formData.acctId ? updateAccount : createAccount
        api(this.formData).then(() => {
          this.$message.success(this.formData.acctId ? '修改成功' : '新增成功')
          this.dialogVisible = false
          this.fetchData()
        })
      })
    },
    handleResetPwd(row) {
      this.$confirm(`确定重置 "${row.accountName}" 的密码？`, '提示').then(() => {
        resetAccountPwd({ userId: row.acctId }).then(() => {
          this.$message.success('密码已重置为默认值')
        })
      })
    },
    handleDelete(row) {
      this.$confirm(`确定删除管理员 "${row.accountName}"？`, '提示', { type: 'warning' }).then(() => {
        deleteAccount(row.acctId).then(() => {
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

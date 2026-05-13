<template>
  <div class="app-container">
    <!-- 搜索区域 -->
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="店铺名称">
          <el-input v-model="queryParams.name" placeholder="请输入店铺名称" clearable style="width: 240px" @keyup.enter.native="handleSearch" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="状态" clearable style="width: 120px">
            <el-option label="启用" value="A" />
            <el-option label="禁用" value="N" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
          <el-button type="success" icon="el-icon-plus" @click="handleAdd">新增店铺</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 数据表格 -->
    <div class="table-container">
      <el-table v-loading="loading" :data="storeList" border stripe style="width: 100%">
        <el-table-column prop="id" label="ID" width="60" align="center" />
        <el-table-column prop="name" label="店铺名称" min-width="120" />
        <el-table-column label="所属商户" min-width="100">
          <template slot-scope="scope">
            {{ scope.row.merchantName || '-' }}
          </template>
        </el-table-column>
        <el-table-column label="默认店铺" width="90" align="center">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.isDefault"
              active-value="Y"
              inactive-value="N"
              disabled
            />
          </template>
        </el-table-column>
        <el-table-column prop="contact" label="联系人" width="90" />
        <el-table-column prop="phone" label="手机号" width="120" />
        <el-table-column prop="address" label="地址" min-width="160" show-overflow-tooltip />
        <el-table-column prop="createTime" label="创建时间" width="160" align="center" />
        <el-table-column label="状态" width="80" align="center">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="A"
              inactive-value="N"
              @change="handleStatusChange(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="280" align="center" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain icon="el-icon-user" @click="handleAccount(scope.row)">后台帐号</el-button>
            <el-button size="mini" type="info" plain icon="el-icon-full-screen" @click="handleQrcode(scope.row)">二维码</el-button>
            <el-button size="mini" type="warning" plain icon="el-icon-edit" @click="handleEdit(scope.row)">修改</el-button>
            <el-button size="mini" type="danger" plain icon="el-icon-delete" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          :current-page="queryParams.page"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="queryParams.pageSize"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="650px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-form-item label="店铺名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入店铺名称" />
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="联系人" prop="contact">
              <el-input v-model="formData.contact" placeholder="请输入联系人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="formData.phone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="地址" prop="address">
          <el-input v-model="formData.address" placeholder="请输入详细地址" />
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="经度">
              <el-input v-model="formData.latitude" placeholder="经度" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="纬度">
              <el-input v-model="formData.longitude" placeholder="纬度" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="营业时间">
          <el-input v-model="formData.hours" placeholder="如: 08:00-22:00" />
        </el-form-item>
        <el-form-item label="是否默认">
          <el-switch v-model="formData.isDefault" active-value="Y" inactive-value="N" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="submitLoading" @click="handleSubmit">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 后台帐号弹窗 -->
    <el-dialog title="后台帐号管理" :visible.sync="accountDialogVisible" width="500px">
      <el-form ref="accountFormRef" :model="accountForm" :rules="accountRules" label-width="100px">
        <el-form-item label="所属店铺">
          <el-input :value="currentStore.name" disabled />
        </el-form-item>
        <el-form-item label="账户名" prop="accountName">
          <el-input v-model="accountForm.accountName" placeholder="请输入账户名" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="accountForm.password" type="password" placeholder="请输入密码" show-password />
        </el-form-item>
        <el-form-item label="真实姓名" prop="realName">
          <el-input v-model="accountForm.realName" placeholder="请输入真实姓名" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="accountDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleAccountSubmit">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 二维码弹窗 -->
    <el-dialog title="店铺二维码" :visible.sync="qrcodeDialogVisible" width="400px" center>
      <div class="qrcode-container">
        <div class="qrcode-placeholder">
          <i class="el-icon-full-screen" style="font-size: 120px; color: #409EFF;" />
          <p>{{ currentStore.name }}</p>
          <p class="qrcode-tip">店铺ID：{{ currentStore.id }}</p>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getStoreList, saveStore, updateStoreStatus, getStoreInfo } from '@/api/store'
import { createAccount } from '@/api/system'

export default {
  name: 'StoreList',
  data() {
    return {
      loading: false,
      submitLoading: false,
      storeList: [],
      total: 0,
      queryParams: {
        page: 1,
        pageSize: 10,
        name: '',
        status: ''
      },
      dialogVisible: false,
      dialogTitle: '',
      formData: {
        id: '',
        name: '',
        contact: '',
        phone: '',
        address: '',
        latitude: '',
        longitude: '',
        hours: '',
        isDefault: 'N',
        description: ''
      },
      formRules: {
        name: [{ required: true, message: '请输入店铺名称', trigger: 'blur' }],
        phone: [{ required: true, message: '请输入联系电话', trigger: 'blur' }]
      },
      accountDialogVisible: false,
      accountForm: {
        accountName: '',
        password: '',
        realName: '',
        storeId: '',
        merchantId: ''
      },
      accountRules: {
        accountName: [{ required: true, message: '请输入账户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }]
      },
      qrcodeDialogVisible: false,
      currentStore: {}
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      getStoreList(this.queryParams).then(res => {
        this.storeList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => {
        this.loading = false
      })
    },
    handleSearch() {
      this.queryParams.page = 1
      this.fetchData()
    },
    handleReset() {
      this.queryParams = { page: 1, pageSize: 10, name: '', status: '' }
      this.fetchData()
    },
    handleSizeChange(val) {
      this.queryParams.pageSize = val
      this.fetchData()
    },
    handleCurrentChange(val) {
      this.queryParams.page = val
      this.fetchData()
    },
    handleAdd() {
      this.dialogTitle = '新增店铺'
      this.formData = { id: '', name: '', contact: '', phone: '', address: '', latitude: '', longitude: '', hours: '', isDefault: 'N', description: '' }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleEdit(row) {
      this.dialogTitle = '修改店铺'
      this.formData = { ...row }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        this.submitLoading = true
        saveStore(this.formData).then(() => {
          this.$message.success(this.formData.id ? '修改成功' : '新增成功')
          this.dialogVisible = false
          this.fetchData()
        }).finally(() => {
          this.submitLoading = false
        })
      })
    },
    handleStatusChange(row) {
      const statusText = row.status === 'A' ? '启用' : '禁用'
      updateStoreStatus({ storeId: row.id, status: row.status }).then(() => {
        this.$message.success(`${statusText}成功`)
      }).catch(() => {
        row.status = row.status === 'A' ? 'N' : 'A'
      })
    },
    handleDelete(row) {
      this.$confirm('确定要删除该店铺吗？删除后不可恢复', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        updateStoreStatus({ storeId: row.id, status: 'D' }).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleAccount(row) {
      this.currentStore = row
      this.accountForm = {
        accountName: '',
        password: '',
        realName: '',
        storeId: row.id,
        merchantId: row.merchantId
      }
      this.accountDialogVisible = true
    },
    handleAccountSubmit() {
      this.$refs.accountFormRef.validate(valid => {
        if (!valid) return
        createAccount({
          ...this.accountForm,
          roleIds: '3'
        }).then(() => {
          this.$message.success('账号创建成功')
          this.accountDialogVisible = false
        })
      })
    },
    handleQrcode(row) {
      this.currentStore = row
      this.qrcodeDialogVisible = true
    }
  }
}
</script>

<style scoped>
.filter-container {
  padding: 20px;
  background: #fff;
  margin-bottom: 15px;
  border-radius: 4px;
}
.table-container {
  padding: 20px;
  background: #fff;
  border-radius: 4px;
}
.pagination-container {
  margin-top: 20px;
  text-align: right;
}
.qrcode-container {
  text-align: center;
  padding: 20px;
}
.qrcode-placeholder p {
  margin: 10px 0 0;
  font-size: 16px;
  color: #333;
}
.qrcode-tip {
  font-size: 12px !important;
  color: #999 !important;
}
</style>

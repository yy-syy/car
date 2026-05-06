<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="车牌号">
          <el-input v-model="searchForm.licensePlate" placeholder="请输入车牌号" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.realName" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增车辆</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="vehicleList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="licensePlate" label="车牌号" width="120" />
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="vehicleType" label="车型" width="120" />
        <el-table-column prop="brand" label="品牌" width="120" />
        <el-table-column prop="color" label="颜色" width="100" />
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
        <el-form-item label="车牌号" prop="licensePlate">
          <el-input v-model="formData.licensePlate" placeholder="请输入车牌号" />
        </el-form-item>
        <el-form-item label="会员姓名" prop="realName">
          <el-input v-model="formData.realName" placeholder="请输入会员姓名" />
        </el-form-item>
        <el-form-item label="手机号码" prop="mobile">
          <el-input v-model="formData.mobile" placeholder="请输入手机号码" />
        </el-form-item>
        <el-form-item label="车型" prop="vehicleType">
          <el-input v-model="formData.vehicleType" placeholder="请输入车型" />
        </el-form-item>
        <el-form-item label="品牌" prop="brand">
          <el-input v-model="formData.brand" placeholder="请输入品牌" />
        </el-form-item>
        <el-form-item label="颜色" prop="color">
          <el-input v-model="formData.color" placeholder="请输入颜色" />
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
import { fetchVehicleList, addVehicle, updateVehicle, deleteVehicle } from '@/api/service'

export default {
  name: 'VehicleList',
  data() {
    return {
      searchForm: {
        licensePlate: '',
        realName: ''
      },
      vehicleList: [],
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
        licensePlate: '',
        realName: '',
        mobile: '',
        vehicleType: '',
        brand: '',
        color: ''
      },
      formRules: {
        licensePlate: [{ required: true, message: '请输入车牌号', trigger: 'blur' }],
        realName: [{ required: true, message: '请输入会员姓名', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入手机号码', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchVehicleList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.vehicleList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { licensePlate: '', realName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增车辆'
      this.formData = { id: '', licensePlate: '', realName: '', mobile: '', vehicleType: '', brand: '', color: '' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑车辆'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteVehicle(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateVehicle : addVehicle
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
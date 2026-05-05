<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="卡券名称">
          <el-input v-model="searchForm.couponName" placeholder="请输入卡券名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item label="卡券组">
          <el-select v-model="searchForm.groupId" placeholder="请选择卡券组">
            <el-option label="全部" value="" />
            <el-option v-for="group in groupOptions" :key="group.groupId" :label="group.groupName" :value="group.groupId" />
          </el-select>
        </el-form-item>
        <el-form-item label="卡券类型">
          <el-select v-model="searchForm.couponType" placeholder="请选择卡券类型">
            <el-option label="全部" value="" />
            <el-option label="优惠券" value="COUPON" />
            <el-option label="礼品券" value="GIFT" />
            <el-option label="储值卡" value="CASH" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增卡券</el-button>
    </div>

    <div class="table-container">
      <el-table
        :data="couponList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="couponId" label="卡券ID" width="100" />
        <el-table-column prop="couponName" label="卡券名称" />
        <el-table-column prop="groupName" label="卡券组" width="150" />
        <el-table-column prop="couponType" label="卡券类型" width="120">
          <template slot-scope="scope">{{ getCouponTypeText(scope.row.couponType) }}</template>
        </el-table-column>
        <el-table-column prop="faceValue" label="面值" width="100">
          <template slot-scope="scope">￥{{ scope.row.faceValue }}</template>
        </el-table-column>
        <el-table-column prop="discount" label="折扣" width="100">
          <template slot-scope="scope">{{ scope.row.discount }}%</template>
        </el-table-column>
        <el-table-column prop="totalNum" label="总量" width="100" />
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
        <el-form-item label="卡券名称" prop="couponName">
          <el-input v-model="formData.couponName" placeholder="请输入卡券名称" />
        </el-form-item>
        <el-form-item label="卡券组" prop="groupId">
          <el-select v-model="formData.groupId" placeholder="请选择卡券组">
            <el-option v-for="group in groupOptions" :key="group.groupId" :label="group.groupName" :value="group.groupId" />
          </el-select>
        </el-form-item>
        <el-form-item label="卡券类型" prop="couponType">
          <el-select v-model="formData.couponType" placeholder="请选择卡券类型">
            <el-option label="优惠券" value="COUPON" />
            <el-option label="礼品券" value="GIFT" />
            <el-option label="储值卡" value="CASH" />
          </el-select>
        </el-form-item>
        <el-form-item label="面值" prop="faceValue">
          <el-input v-model="formData.faceValue" type="number" placeholder="请输入面值" />
        </el-form-item>
        <el-form-item label="折扣" prop="discount">
          <el-input v-model="formData.discount" type="number" placeholder="请输入折扣(%)" />
        </el-form-item>
        <el-form-item label="总量" prop="totalNum">
          <el-input v-model="formData.totalNum" type="number" placeholder="请输入总量" />
        </el-form-item>
        <el-form-item label="有效天数" prop="validDays">
          <el-input v-model="formData.validDays" type="number" placeholder="请输入有效天数" />
        </el-form-item>
        <el-form-item label="卡券描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入卡券描述" />
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
import { fetchCouponList, addCoupon, updateCoupon, deleteCoupon } from '@/api/coupon'
import { fetchCouponGroupList } from '@/api/coupon'

export default {
  name: 'CouponList',
  data() {
    return {
      searchForm: {
        couponName: '',
        groupId: '',
        couponType: ''
      },
      couponList: [],
      groupOptions: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false,
      dialogVisible: false,
      dialogTitle: '',
      formRef: '',
      formData: {
        couponId: '',
        couponName: '',
        groupId: '',
        couponType: 'COUPON',
        faceValue: 0,
        discount: 100,
        totalNum: 0,
        validDays: 30,
        description: '',
        status: 'ENABLE'
      },
      formRules: {
        couponName: [{ required: true, message: '请输入卡券名称', trigger: 'blur' }],
        groupId: [{ required: true, message: '请选择卡券组', trigger: 'blur' }],
        couponType: [{ required: true, message: '请选择卡券类型', trigger: 'blur' }],
        faceValue: [{ required: true, message: '请输入面值', trigger: 'blur' }],
        totalNum: [{ required: true, message: '请输入总量', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchGroups()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchCouponList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.couponList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchGroups() {
      fetchCouponGroupList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.groupOptions = response.data.list
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { couponName: '', groupId: '', couponType: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增卡券'
      this.formData = { couponId: '', couponName: '', groupId: '', couponType: 'COUPON', faceValue: 0, discount: 100, totalNum: 0, validDays: 30, description: '', status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑卡券'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteCoupon(row.couponId).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.couponId ? updateCoupon : addCoupon
          api(this.formData).then(() => {
            this.$message.success(this.formData.couponId ? '修改成功' : '新增成功')
            this.dialogVisible = false
            this.fetchData()
          })
        }
      })
    },
    getCouponTypeText(type) {
      const map = { COUPON: '优惠券', GIFT: '礼品券', CASH: '储值卡' }
      return map[type] || type
    }
  }
}
</script>

<style scoped>
.search-bar {
  margin-bottom: 20px;
}
.toolbar {
  margin-bottom: 20px;
}
.table-container {
  background: #fff;
  padding: 20px;
}
</style>
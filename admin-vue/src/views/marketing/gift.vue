<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="礼品名称">
          <el-input v-model="searchForm.giftName" placeholder="请输入礼品名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增礼品</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="giftList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="giftName" label="礼品名称" />
        <el-table-column prop="giftImage" label="礼品图片" width="150">
          <template slot-scope="scope">
            <img :src="scope.row.giftImage" style="width: 80px; height: 60px; object-fit: cover;" />
          </template>
        </el-table-column>
        <el-table-column prop="point" label="所需积分" width="120" />
        <el-table-column prop="stock" label="库存" width="100" />
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
        <el-form-item label="礼品名称" prop="giftName">
          <el-input v-model="formData.giftName" placeholder="请输入礼品名称" />
        </el-form-item>
        <el-form-item label="礼品图片" prop="giftImage">
          <el-input v-model="formData.giftImage" placeholder="请输入礼品图片链接" />
        </el-form-item>
        <el-form-item label="所需积分" prop="point">
          <el-input v-model="formData.point" type="number" placeholder="请输入所需积分" />
        </el-form-item>
        <el-form-item label="库存" prop="stock">
          <el-input v-model="formData.stock" type="number" placeholder="请输入库存" />
        </el-form-item>
        <el-form-item label="礼品描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入礼品描述" />
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
import { fetchGiftList, addGift, updateGift, deleteGift } from '@/api/marketing'

export default {
  name: 'GiftList',
  data() {
    return {
      searchForm: {
        giftName: ''
      },
      giftList: [],
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
        giftName: '',
        giftImage: '',
        point: 0,
        stock: 0,
        description: '',
        status: 'ENABLE'
      },
      formRules: {
        giftName: [{ required: true, message: '请输入礼品名称', trigger: 'blur' }],
        point: [{ required: true, message: '请输入所需积分', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchGiftList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.giftList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { giftName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增礼品'
      this.formData = { id: '', giftName: '', giftImage: '', point: 0, stock: 0, description: '', status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑礼品'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteGift(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateGift : addGift
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
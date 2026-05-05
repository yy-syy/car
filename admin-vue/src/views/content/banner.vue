<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="轮播图名称">
          <el-input v-model="searchForm.name" placeholder="请输入轮播图名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增轮播图</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="bannerList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="name" label="轮播图名称" />
        <el-table-column prop="imageUrl" label="图片" width="150">
          <template slot-scope="scope">
            <img :src="scope.row.imageUrl" style="width: 80px; height: 60px; object-fit: cover;" />
          </template>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-switch :value="scope.row.status === 'ENABLE'" @change="handleStatusChange(scope.row)" />
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
        <el-form-item label="轮播图名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入轮播图名称" />
        </el-form-item>
        <el-form-item label="图片链接" prop="imageUrl">
          <el-input v-model="formData.imageUrl" placeholder="请输入图片链接" />
        </el-form-item>
        <el-form-item label="跳转链接" prop="linkUrl">
          <el-input v-model="formData.linkUrl" placeholder="请输入跳转链接" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="formData.sort" type="number" placeholder="请输入排序号" />
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
import { fetchBannerList, addBanner, updateBanner, deleteBanner } from '@/api/content'

export default {
  name: 'BannerList',
  data() {
    return {
      searchForm: {
        name: ''
      },
      bannerList: [],
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
        name: '',
        imageUrl: '',
        linkUrl: '',
        sort: 0,
        status: 'ENABLE'
      },
      formRules: {
        name: [{ required: true, message: '请输入轮播图名称', trigger: 'blur' }],
        imageUrl: [{ required: true, message: '请输入图片链接', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchBannerList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.bannerList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { name: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增轮播图'
      this.formData = { id: '', name: '', imageUrl: '', linkUrl: '', sort: 0, status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑轮播图'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteBanner(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleStatusChange(row) {
      updateBanner({ ...row, status: row.status === 'ENABLE' ? 'DISABLE' : 'ENABLE' }).then(() => {
        this.$message.success('状态修改成功')
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateBanner : addBanner
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
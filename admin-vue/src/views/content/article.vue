<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="文章标题">
          <el-input v-model="searchForm.title" placeholder="请输入文章标题" style="width: 200px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增文章</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="articleList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="title" label="文章标题" />
        <el-table-column prop="author" label="作者" width="100" />
        <el-table-column prop="viewCount" label="浏览次数" width="100" />
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

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="800px">
      <el-form :model="formData" :rules="formRules" ref="formRef" label-width="80px">
        <el-form-item label="文章标题" prop="title">
          <el-input v-model="formData.title" placeholder="请输入文章标题" />
        </el-form-item>
        <el-form-item label="作者" prop="author">
          <el-input v-model="formData.author" placeholder="请输入作者" />
        </el-form-item>
        <el-form-item label="文章内容" prop="content">
          <el-input v-model="formData.content" type="textarea" :rows="8" placeholder="请输入文章内容" />
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
import { fetchArticleList, addArticle, updateArticle, deleteArticle } from '@/api/content'

export default {
  name: 'ArticleList',
  data() {
    return {
      searchForm: {
        title: ''
      },
      articleList: [],
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
        title: '',
        author: '',
        content: ''
      },
      formRules: {
        title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
        author: [{ required: true, message: '请输入作者', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchArticleList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.articleList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { title: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增文章'
      this.formData = { id: '', title: '', author: '', content: '' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑文章'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteArticle(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateArticle : addArticle
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
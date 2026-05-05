<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="商品名称">
          <el-input v-model="searchForm.goodsName" placeholder="请输入商品名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="searchForm.cateId" placeholder="请选择分类">
            <el-option label="全部" value="" />
            <el-option v-for="item in categoryOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增商品</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="goodsList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="goodsName" label="商品名称" />
        <el-table-column prop="cateName" label="分类" width="120" />
        <el-table-column prop="price" label="价格" width="100">
          <template slot-scope="scope">￥{{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column prop="stock" label="库存" width="100" />
        <el-table-column prop="sales" label="销量" width="100" />
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 'ENABLE' ? 'success' : 'danger'">
              {{ scope.row.status === 'ENABLE' ? '上架' : '下架' }}
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
        <el-form-item label="商品名称" prop="goodsName">
          <el-input v-model="formData.goodsName" placeholder="请输入商品名称" />
        </el-form-item>
        <el-form-item label="分类" prop="cateId">
          <el-select v-model="formData.cateId" placeholder="请选择分类">
            <el-option v-for="item in categoryOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input v-model="formData.price" type="number" placeholder="请输入价格" />
        </el-form-item>
        <el-form-item label="库存" prop="stock">
          <el-input v-model="formData.stock" type="number" placeholder="请输入库存" />
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入商品描述" />
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
import { fetchGoodsList, addGoods, updateGoods, deleteGoods } from '@/api/goods'
import { fetchCategoryList } from '@/api/goods'

export default {
  name: 'GoodsList',
  data() {
    return {
      searchForm: {
        goodsName: '',
        cateId: ''
      },
      goodsList: [],
      categoryOptions: [],
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
        goodsName: '',
        cateId: '',
        price: 0,
        stock: 0,
        description: '',
        status: 'ENABLE'
      },
      formRules: {
        goodsName: [{ required: true, message: '请输入商品名称', trigger: 'blur' }],
        cateId: [{ required: true, message: '请选择分类', trigger: 'blur' }],
        price: [{ required: true, message: '请输入价格', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchCategories()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchGoodsList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.goodsList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchCategories() {
      fetchCategoryList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.categoryOptions = response.data.list
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { goodsName: '', cateId: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增商品'
      this.formData = { id: '', goodsName: '', cateId: '', price: 0, stock: 0, description: '', status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑商品'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteGoods(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateGoods : addGoods
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
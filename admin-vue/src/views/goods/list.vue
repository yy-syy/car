<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="商品名称">
          <el-input v-model="queryParams.name" placeholder="请输入商品名称" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="商品分类">
          <el-select v-model="queryParams.cateId" placeholder="全部" clearable style="width: 140px">
            <el-option v-for="item in categoryOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="商品类型">
          <el-select v-model="queryParams.type" placeholder="全部" clearable style="width: 120px">
            <el-option label="服务" value="service" />
            <el-option label="实物" value="goods" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 100px">
            <el-option label="上架" value="A" />
            <el-option label="下架" value="N" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
          <el-button type="success" icon="el-icon-plus" @click="handleAdd">新增商品</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table v-loading="loading" :data="goodsList" border stripe>
        <el-table-column prop="id" label="ID" width="60" align="center" />
        <el-table-column label="商品信息" min-width="200">
          <template slot-scope="scope">
            <div class="goods-info">
              <div class="goods-name">{{ scope.row.name }}</div>
              <div class="goods-no">编码：{{ scope.row.goodsNo || '-' }}</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="类型" width="80" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.type === 'service' ? 'success' : ''" size="small">
              {{ scope.row.type === 'service' ? '服务' : '实物' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="分类" width="100">
          <template slot-scope="scope">{{ scope.row.cateName || '-' }}</template>
        </el-table-column>
        <el-table-column label="价格" width="120" align="right">
          <template slot-scope="scope">
            <span class="price">¥{{ scope.row.price }}</span>
            <span v-if="scope.row.linePrice > 0" class="line-price">¥{{ scope.row.linePrice }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="stock" label="库存" width="70" align="center" />
        <el-table-column prop="initSale" label="销量" width="70" align="center" />
        <el-table-column label="服务时长" width="90" align="center">
          <template slot-scope="scope">
            {{ scope.row.serviceTime ? scope.row.serviceTime + '分钟' : '-' }}
          </template>
        </el-table-column>
        <el-table-column label="状态" width="70" align="center">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.status" active-value="A" inactive-value="N" @change="handleStatusChange(scope.row)" />
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="150" align="center" />
        <el-table-column label="操作" width="150" align="center" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
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

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="700px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="商品名称" prop="name">
              <el-input v-model="formData.name" placeholder="请输入商品名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="商品编码">
              <el-input v-model="formData.goodsNo" placeholder="请输入商品编码" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="商品类型" prop="type">
              <el-select v-model="formData.type" placeholder="请选择" style="width: 100%">
                <el-option label="服务" value="service" />
                <el-option label="实物商品" value="goods" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="所属分类" prop="cateId">
              <el-select v-model="formData.cateId" placeholder="请选择分类" style="width: 100%">
                <el-option v-for="item in categoryOptions" :key="item.id" :label="item.name" :value="item.id" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="价格" prop="price">
              <el-input-number v-model="formData.price" :min="0" :precision="2" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="划线价">
              <el-input-number v-model="formData.linePrice" :min="0" :precision="2" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="库存" prop="stock">
              <el-input-number v-model="formData.stock" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="服务时长">
              <el-input-number v-model="formData.serviceTime" :min="0" placeholder="分钟" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="初始销量">
              <el-input-number v-model="formData.initSale" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="排序">
              <el-input-number v-model="formData.sort" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="卖点">
          <el-input v-model="formData.salePoint" placeholder="请输入商品卖点" />
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input v-model="formData.description" type="textarea" :rows="4" placeholder="请输入商品描述" />
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
import { getGoodsList, saveGoods, updateGoodsStatus, getCategoryList } from '@/api/goods'

export default {
  name: 'GoodsList',
  data() {
    return {
      loading: false,
      goodsList: [],
      categoryOptions: [],
      total: 0,
      queryParams: { page: 1, pageSize: 10, name: '', cateId: '', type: '', status: '' },
      dialogVisible: false,
      dialogTitle: '',
      formData: {
        id: '', name: '', goodsNo: '', type: 'service', cateId: '',
        price: 0, linePrice: 0, stock: 999, serviceTime: 0,
        initSale: 0, sort: 0, salePoint: '', description: ''
      },
      formRules: {
        name: [{ required: true, message: '请输入商品名称', trigger: 'blur' }],
        type: [{ required: true, message: '请选择类型', trigger: 'change' }],
        cateId: [{ required: true, message: '请选择分类', trigger: 'change' }],
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
      getGoodsList(this.queryParams).then(res => {
        this.goodsList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => { this.loading = false })
    },
    fetchCategories() {
      getCategoryList({ page: 1, pageSize: 100 }).then(res => {
        this.categoryOptions = res.data.list || []
      })
    },
    handleSearch() { this.queryParams.page = 1; this.fetchData() },
    handleReset() { this.queryParams = { page: 1, pageSize: 10, name: '', cateId: '', type: '', status: '' }; this.fetchData() },
    handleSizeChange(val) { this.queryParams.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.queryParams.page = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增商品'
      this.formData = { id: '', name: '', goodsNo: '', type: 'service', cateId: '', price: 0, linePrice: 0, stock: 999, serviceTime: 0, initSale: 0, sort: 0, salePoint: '', description: '' }
      this.dialogVisible = true
      this.$nextTick(() => { this.$refs.formRef && this.$refs.formRef.clearValidate() })
    },
    handleEdit(row) {
      this.dialogTitle = '编辑商品'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        saveGoods(this.formData).then(() => {
          this.$message.success(this.formData.id ? '修改成功' : '新增成功')
          this.dialogVisible = false
          this.fetchData()
        })
      })
    },
    handleStatusChange(row) {
      updateGoodsStatus({ goodsId: row.id, status: row.status }).then(() => {
        this.$message.success('操作成功')
      }).catch(() => {
        row.status = row.status === 'A' ? 'N' : 'A'
      })
    },
    handleDelete(row) {
      this.$confirm('确定要删除该商品？', '提示', { type: 'warning' }).then(() => {
        updateGoodsStatus({ goodsId: row.id, status: 'D' }).then(() => {
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
.goods-info .goods-name { font-weight: 500; }
.goods-info .goods-no { font-size: 12px; color: #999; margin-top: 4px; }
.price { color: #f56c6c; font-weight: 500; }
.line-price { color: #999; text-decoration: line-through; margin-left: 5px; font-size: 12px; }
</style>

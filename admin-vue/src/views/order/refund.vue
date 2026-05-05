<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="订单号">
          <el-input v-model="searchForm.orderSn" placeholder="请输入订单号" style="width: 200px;" />
        </el-form-item>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.realName" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="refundList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="orderSn" label="订单号" width="180" />
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="refundAmount" label="退款金额" width="120">
          <template slot-scope="scope">￥{{ scope.row.refundAmount }}</template>
        </el-table-column>
        <el-table-column prop="reason" label="退款原因" />
        <el-table-column prop="createTime" label="申请时间" width="160" />
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleView(scope.row)">查看详情</el-button>
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

    <el-dialog title="退款详情" :visible.sync="detailVisible" width="600px">
      <div v-if="detailData" class="detail-content">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="订单号">{{ detailData.orderSn }}</el-descriptions-item>
          <el-descriptions-item label="会员姓名">{{ detailData.realName }}</el-descriptions-item>
          <el-descriptions-item label="手机号码">{{ detailData.mobile }}</el-descriptions-item>
          <el-descriptions-item label="退款金额">￥{{ detailData.refundAmount }}</el-descriptions-item>
          <el-descriptions-item label="退款原因">{{ detailData.reason }}</el-descriptions-item>
          <el-descriptions-item label="申请时间">{{ detailData.createTime }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { fetchRefundList, getRefundDetail } from '@/api/order'

export default {
  name: 'RefundList',
  data() {
    return {
      searchForm: {
        orderSn: '',
        realName: ''
      },
      refundList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false,
      detailVisible: false,
      detailData: {}
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchRefundList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.refundList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { orderSn: '', realName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleView(row) {
      getRefundDetail(row.id).then(response => {
        this.detailData = response.data
        this.detailVisible = true
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
.detail-content {
  padding: 10px;
}
</style>
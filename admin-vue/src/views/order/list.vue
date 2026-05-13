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
        <el-form-item label="手机号码">
          <el-input v-model="searchForm.mobile" placeholder="请输入手机号码" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="订单状态">
          <el-select v-model="searchForm.status" placeholder="请选择订单状态">
            <el-option label="全部" value="" />
            <el-option label="待付款" value="A" />
            <el-option label="已付款" value="B" />
            <el-option label="已完成" value="C" />
            <el-option label="已取消" value="D" />
            <el-option label="已退款" value="E" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="orderList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="orderSn" label="订单号" width="180" />
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="totalAmount" label="订单金额" width="120">
          <template slot-scope="scope">￥{{ scope.row.totalAmount || 0 }}</template>
        </el-table-column>
        <el-table-column prop="payAmount" label="支付金额" width="120">
          <template slot-scope="scope">￥{{ scope.row.payAmount || 0 }}</template>
        </el-table-column>
        <el-table-column prop="payType" label="支付方式" width="120">
          <template slot-scope="scope">{{ getPayTypeText(scope.row.payType) }}</template>
        </el-table-column>
        <el-table-column prop="status" label="订单状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" />
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

    <el-dialog title="订单详情" :visible.sync="detailVisible" width="800px">
      <div v-if="detailData" class="detail-content">
        <div class="detail-header">
          <div class="order-info">
            <span class="order-sn">订单号：{{ detailData.orderSn }}</span>
            <el-tag :type="getStatusType(detailData.status)" class="status-tag">
              {{ getStatusText(detailData.status) }}
            </el-tag>
          </div>
          <div class="order-time">创建时间：{{ detailData.createTime }}</div>
        </div>
        
        <div class="detail-section">
          <h4>会员信息</h4>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="会员姓名">{{ detailData.realName }}</el-descriptions-item>
            <el-descriptions-item label="手机号码">{{ detailData.mobile }}</el-descriptions-item>
            <el-descriptions-item label="会员等级">{{ detailData.gradeName }}</el-descriptions-item>
          </el-descriptions>
        </div>

        <div class="detail-section">
          <h4>商品信息</h4>
          <el-table :data="detailData.orderItems || []" border>
            <el-table-column prop="goodsName" label="商品名称" />
            <el-table-column prop="skuName" label="规格型号" />
            <el-table-column prop="quantity" label="数量" width="80" />
            <el-table-column prop="price" label="单价" width="100">
              <template slot-scope="scope">￥{{ scope.row.price }}</template>
            </el-table-column>
            <el-table-column prop="amount" label="金额" width="100">
              <template slot-scope="scope">￥{{ scope.row.amount }}</template>
            </el-table-column>
          </el-table>
        </div>

        <div class="detail-section">
          <h4>支付信息</h4>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="支付方式">{{ getPayTypeText(detailData.payType) }}</el-descriptions-item>
            <el-descriptions-item label="订单金额">￥{{ detailData.totalAmount }}</el-descriptions-item>
            <el-descriptions-item label="支付金额">￥{{ detailData.payAmount }}</el-descriptions-item>
            <el-descriptions-item label="支付时间">{{ detailData.payTime }}</el-descriptions-item>
          </el-descriptions>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getOrderList, getOrderInfo } from '@/api/order'

export default {
  name: 'OrderList',
  data() {
    return {
      searchForm: {
        orderSn: '',
        realName: '',
        mobile: '',
        status: ''
      },
      orderList: [],
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
      getOrderList({
        page: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.orderList = response.data.list || []
        this.total = response.data.total || 0
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() {
      this.pageNum = 1
      this.fetchData()
    },
    handleReset() {
      this.searchForm = { orderSn: '', realName: '', mobile: '', status: '' }
      this.fetchData()
    },
    handleSizeChange(val) {
      this.pageSize = val
      this.fetchData()
    },
    handleCurrentChange(val) {
      this.pageNum = val
      this.fetchData()
    },
    handleView(row) {
      getOrderInfo(row.id).then(response => {
        this.detailData = response.data
        this.detailVisible = true
      })
    },
    getStatusText(status) {
      const map = {
        A: '待付款',
        B: '已付款',
        C: '已完成',
        D: '已取消',
        E: '已退款'
      }
      return map[status] || status
    },
    getStatusType(status) {
      const map = {
        A: 'warning',
        B: '',
        C: 'success',
        D: 'danger',
        E: 'info'
      }
      return map[status] || 'default'
    },
    getPayTypeText(type) {
      const map = {
        JSAPI: '微信支付',
        WECHAT: '微信支付',
        ALIPAY: '支付宝',
        BALANCE: '余额支付',
        CASH: '现金'
      }
      return map[type] || type || '-'
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
.detail-header {
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}
.order-info {
  display: flex;
  align-items: center;
  gap: 10px;
}
.order-sn {
  font-size: 16px;
  font-weight: bold;
}
.status-tag {
  margin-left: 10px;
}
.order-time {
  margin-top: 10px;
  color: #999;
}
.detail-section {
  margin-bottom: 20px;
}
.detail-section h4 {
  margin-bottom: 10px;
  font-size: 14px;
  color: #333;
}
</style>
<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="手机号码">
          <el-input v-model="searchForm.mobile" placeholder="请输入手机号码" style="width: 150px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="smsList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="content" label="短信内容" />
        <el-table-column prop="sendStatus" label="发送状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="scope.row.sendStatus === 'SUCCESS' ? 'success' : 'danger'">
              {{ scope.row.sendStatus === 'SUCCESS' ? '发送成功' : '发送失败' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="发送时间" width="160" />
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

    <div class="send-sms-section">
      <h3>发送短信</h3>
      <el-form :model="sendForm" :rules="sendRules" ref="sendRef" label-width="80px">
        <el-form-item label="手机号码" prop="mobile">
          <el-input v-model="sendForm.mobile" placeholder="请输入手机号码" />
        </el-form-item>
        <el-form-item label="短信内容" prop="content">
          <el-input v-model="sendForm.content" type="textarea" :rows="3" placeholder="请输入短信内容" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSend">发送短信</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { fetchSmsList, sendSms } from '@/api/marketing'

export default {
  name: 'SmsList',
  data() {
    return {
      searchForm: {
        mobile: ''
      },
      smsList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false,
      sendForm: {
        mobile: '',
        content: ''
      },
      sendRules: {
        mobile: [{ required: true, message: '请输入手机号码', trigger: 'blur' }],
        content: [{ required: true, message: '请输入短信内容', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchSmsList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.smsList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { mobile: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSend() {
      this.$refs.sendRef.validate((valid) => {
        if (valid) {
          sendSms(this.sendForm).then(() => {
            this.$message.success('发送成功')
            this.sendForm = { mobile: '', content: '' }
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
  margin-bottom: 20px;
}
.send-sms-section {
  background: #fff;
  padding: 20px;
}
.send-sms-section h3 {
  margin-bottom: 20px;
  font-size: 16px;
  font-weight: bold;
  color: #333;
}
</style>
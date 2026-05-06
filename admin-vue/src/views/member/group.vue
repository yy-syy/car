<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.realName" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
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
        :data="groupList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="realName" label="会员姓名" width="120" />
        <el-table-column prop="mobile" label="手机号码" width="130" />
        <el-table-column prop="gradeName" label="会员等级" width="120" />
        <el-table-column prop="balance" label="余额" width="120">
          <template slot-scope="scope">￥{{ scope.row.balance }}</template>
        </el-table-column>
        <el-table-column prop="point" label="积分" width="100" />
        <el-table-column prop="createTime" label="注册时间" width="160" />
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
  </div>
</template>

<script>
import { fetchMemberList } from '@/api/member'

export default {
  name: 'MemberList',
  data() {
    return {
      searchForm: {
        realName: '',
        mobile: ''
      },
      groupList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchMemberList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.groupList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { realName: '', mobile: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() }
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
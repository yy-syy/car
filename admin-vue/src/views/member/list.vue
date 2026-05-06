<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="会员ID">
          <el-input v-model="searchForm.id" placeholder="请输入会员ID" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="会员姓名">
          <el-input v-model="searchForm.name" placeholder="请输入会员姓名" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="searchForm.mobile" placeholder="请输入手机号码" style="width: 150px;" />
        </el-form-item>
        <el-form-item label="会员等级">
          <el-select v-model="searchForm.gradeId" placeholder="请选择会员等级">
            <el-option label="全部" value="" />
            <el-option v-for="grade in gradeOptions" :key="grade.gradeId" :label="grade.gradeName" :value="grade.gradeId" />
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
        :data="memberList"
        :loading="loading"
        border
        stripe
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="id" label="会员ID" width="100" />
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
import { fetchGradeList } from '@/api/member'

export default {
  name: 'MemberDetailList',
  data() {
    return {
      searchForm: {
        id: '',
        name: '',
        mobile: '',
        gradeId: ''
      },
      memberList: [],
      gradeOptions: [],
      selectedIds: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      layout: 'total, sizes, prev, pager, next, jumper',
      loading: false
    }
  },
  created() {
    this.fetchData()
    this.fetchGrades()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchMemberList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.memberList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchGrades() {
      fetchGradeList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.gradeOptions = response.data.list
      })
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { id: '', name: '', mobile: '', gradeId: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleSelectionChange(val) {
      this.selectedIds = val.map(item => item.id)
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
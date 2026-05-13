<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="会员ID">
          <el-input v-model="queryParams.id" placeholder="会员ID" clearable style="width: 120px" />
        </el-form-item>
        <el-form-item label="会员名称">
          <el-input v-model="queryParams.name" placeholder="请输入会员名称" clearable style="width: 160px" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="queryParams.mobile" placeholder="请输入手机号" clearable style="width: 160px" />
        </el-form-item>
        <el-form-item label="车牌号">
          <el-input v-model="queryParams.carNo" placeholder="请输入车牌号" clearable style="width: 140px" />
        </el-form-item>
        <el-form-item label="会员等级">
          <el-select v-model="queryParams.gradeId" placeholder="全部" clearable style="width: 120px">
            <el-option v-for="item in gradeOptions" :key="item.id" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 100px">
            <el-option label="激活" value="A" />
            <el-option label="禁用" value="N" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table v-loading="loading" :data="memberList" border stripe>
        <el-table-column prop="id" label="ID" width="60" align="center" />
        <el-table-column label="会员信息" min-width="160">
          <template slot-scope="scope">
            <div class="member-info">
              <span class="member-name">{{ scope.row.name || '未设置' }}</span>
              <span class="member-no">{{ scope.row.userNo }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="mobile" label="手机号" width="120" />
        <el-table-column prop="carNo" label="车牌号" width="100" />
        <el-table-column label="会员等级" width="100" align="center">
          <template slot-scope="scope">
            <el-tag size="small" type="warning">{{ scope.row.gradeName || '普通会员' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="balance" label="余额" width="90" align="right">
          <template slot-scope="scope">¥{{ scope.row.balance || '0.00' }}</template>
        </el-table-column>
        <el-table-column prop="point" label="积分" width="70" align="right" />
        <el-table-column label="状态" width="70" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 'A' ? 'success' : 'danger'" size="mini">
              {{ scope.row.status === 'A' ? '激活' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="注册时间" width="160" align="center" />
        <el-table-column label="操作" width="220" align="center" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" plain @click="handleDetail(scope.row)">详情</el-button>
            <el-button size="mini" type="warning" plain @click="handleEdit(scope.row)">编辑</el-button>
            <el-button v-if="scope.row.status === 'A'" size="mini" type="danger" plain @click="handleDisable(scope.row)">禁用</el-button>
            <el-button v-else size="mini" type="success" plain @click="handleEnable(scope.row)">启用</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-container">
        <el-pagination
          :current-page="queryParams.page"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="queryParams.pageSize"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!-- 会员详情/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="650px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="会员名称" prop="name">
              <el-input v-model="formData.name" placeholder="请输入会员名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="手机号" prop="mobile">
              <el-input v-model="formData.mobile" placeholder="请输入手机号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="车牌号">
              <el-input v-model="formData.carNo" placeholder="请输入车牌号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="会员等级">
              <el-select v-model="formData.gradeId" placeholder="请选择" style="width: 100%">
                <el-option v-for="item in gradeOptions" :key="item.id" :label="item.name" :value="item.id + ''" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="性别">
              <el-radio-group v-model="formData.sex">
                <el-radio :label="1">男</el-radio>
                <el-radio :label="0">女</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="生日">
              <el-input v-model="formData.birthday" placeholder="如: 1990-01-01" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="地址">
          <el-input v-model="formData.address" placeholder="请输入地址" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="formData.description" type="textarea" :rows="2" placeholder="请输入备注" />
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
import { getMemberList, saveMember, updateMemberStatus, getGradeList } from '@/api/member'

export default {
  name: 'MemberList',
  data() {
    return {
      loading: false,
      memberList: [],
      gradeOptions: [],
      total: 0,
      queryParams: { page: 1, pageSize: 10, id: '', name: '', mobile: '', carNo: '', gradeId: '', status: '' },
      dialogVisible: false,
      dialogTitle: '',
      formData: { id: '', name: '', mobile: '', carNo: '', gradeId: '', sex: 1, birthday: '', address: '', description: '' },
      formRules: {
        name: [{ required: true, message: '请输入会员名称', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入手机号', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchGrades()
  },
  methods: {
    fetchData() {
      this.loading = true
      getMemberList(this.queryParams).then(res => {
        this.memberList = res.data.list || []
        this.total = res.data.total || 0
      }).finally(() => { this.loading = false })
    },
    fetchGrades() {
      getGradeList({ page: 1, pageSize: 100 }).then(res => {
        this.gradeOptions = res.data.list || []
      })
    },
    handleSearch() { this.queryParams.page = 1; this.fetchData() },
    handleReset() { this.queryParams = { page: 1, pageSize: 10, id: '', name: '', mobile: '', carNo: '', gradeId: '', status: '' }; this.fetchData() },
    handleSizeChange(val) { this.queryParams.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.queryParams.page = val; this.fetchData() },
    handleDetail(row) {
      this.dialogTitle = '会员详情'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑会员'
      this.formData = { ...row }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        saveMember(this.formData).then(() => {
          this.$message.success('保存成功')
          this.dialogVisible = false
          this.fetchData()
        })
      })
    },
    handleDisable(row) {
      this.$confirm('确定禁用该会员？', '提示').then(() => {
        updateMemberStatus({ userId: row.id, status: 'N' }).then(() => {
          this.$message.success('已禁用')
          this.fetchData()
        })
      })
    },
    handleEnable(row) {
      updateMemberStatus({ userId: row.id, status: 'A' }).then(() => {
        this.$message.success('已启用')
        this.fetchData()
      })
    }
  }
}
</script>

<style scoped>
.filter-container { padding: 20px; background: #fff; margin-bottom: 15px; border-radius: 4px; }
.table-container { padding: 20px; background: #fff; border-radius: 4px; }
.pagination-container { margin-top: 20px; text-align: right; }
.member-info { display: flex; flex-direction: column; }
.member-name { font-weight: 500; }
.member-no { font-size: 12px; color: #999; }
</style>

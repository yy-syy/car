<template>
  <div class="app-container">
    <div class="search-bar">
      <el-form :model="searchForm" inline>
        <el-form-item label="角色名称">
          <el-input v-model="searchForm.roleName" placeholder="请输入角色名称" style="width: 200px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
          <el-button type="success" @click="handleAdd">新增角色</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="table-container">
      <el-table
        :data="roleList"
        :loading="loading"
        border
        stripe
      >
        <el-table-column prop="roleName" label="角色名称" />
        <el-table-column prop="menuNames" label="权限菜单" />
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 'ENABLE' ? 'success' : 'danger'">
              {{ scope.row.status === 'ENABLE' ? '启用' : '禁用' }}
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
        <el-form-item label="角色名称" prop="roleName">
          <el-input v-model="formData.roleName" placeholder="请输入角色名称" />
        </el-form-item>
        <el-form-item label="角色描述">
          <el-input v-model="formData.description" type="textarea" :rows="3" placeholder="请输入角色描述" />
        </el-form-item>
        <el-form-item label="权限菜单">
          <el-tree
            :data="menuTree"
            show-checkbox
            node-key="id"
            :default-checked-keys="formData.menuIds"
            @check-change="handleMenuCheck"
          />
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
import { fetchRoleList, addRole, updateRole, deleteRole } from '@/api/system'
import { fetchMenuList } from '@/api/system'

export default {
  name: 'RoleList',
  data() {
    return {
      searchForm: {
        roleName: ''
      },
      roleList: [],
      menuTree: [],
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
        roleName: '',
        description: '',
        menuIds: [],
        status: 'ENABLE'
      },
      formRules: {
        roleName: [{ required: true, message: '请输入角色名称', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.fetchData()
    this.fetchMenus()
  },
  methods: {
    fetchData() {
      this.loading = true
      fetchRoleList({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        ...this.searchForm
      }).then(response => {
        this.roleList = response.data.list
        this.total = response.data.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    fetchMenus() {
      fetchMenuList({ pageNum: 1, pageSize: 100 }).then(response => {
        this.menuTree = this.buildTree(response.data.list)
      })
    },
    buildTree(list, parentId = '') {
      return list
        .filter(item => item.parentId === parentId)
        .map(item => ({
          id: item.id,
          label: item.name,
          children: this.buildTree(list, item.id)
        }))
    },
    handleSearch() { this.pageNum = 1; this.fetchData() },
    handleReset() { this.searchForm = { roleName: '' }; this.fetchData() },
    handleSizeChange(val) { this.pageSize = val; this.fetchData() },
    handleCurrentChange(val) { this.pageNum = val; this.fetchData() },
    handleAdd() {
      this.dialogTitle = '新增角色'
      this.formData = { id: '', roleName: '', description: '', menuIds: [], status: 'ENABLE' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑角色'
      this.formData = { 
        ...row, 
        menuIds: row.menuIds ? row.menuIds.split(',').filter(Boolean) : []
      }
      this.dialogVisible = true
    },
    handleDelete(row) {
      this.$confirm('确定要删除这条记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteRole(row.id).then(() => {
          this.$message.success('删除成功')
          this.fetchData()
        })
      })
    },
    handleMenuCheck() {
      const checkedKeys = this.$refs.formRef.$el.querySelectorAll('.el-tree-node.is-checked')
      this.formData.menuIds = Array.from(checkedKeys).map(el => el.dataset.nodeKey)
    },
    handleSubmit() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const api = this.formData.id ? updateRole : addRole
          api({
            ...this.formData,
            menuIds: this.formData.menuIds.join(',')
          }).then(() => {
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
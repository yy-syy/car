<template>
  <div class="app-container">
    <h3>邀请明细</h3>
    <el-table :data="[]" border style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" label="名称" />
      <el-table-column prop="status" label="状态" width="100" />
      <el-table-column label="操作" width="180">
        <template slot-scope="">
          <el-button size="mini" type="primary">编辑</el-button>
          <el-button size="mini" type="danger">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>
<script>
export default { name: 'CommissionInvite' }
</script>
<style scoped>
.app-container { padding: 20px; }
</style>

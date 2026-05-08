<template>
  <div class="app-container">
    <el-card>
      <div slot="header"><span>积分设置</span></div>
      <el-form :model="form" label-width="180px">
        <el-form-item label="积分名称">
          <el-input v-model="form.pointName" placeholder="如：积分" style="width:300px;" />
        </el-form-item>
        <el-form-item label="消费1元获得积分">
          <el-input-number v-model="form.pointNeedConsume" :min="0" />
        </el-form-item>
        <el-form-item label="多少积分抵扣1元">
          <el-input-number v-model="form.rechargePointSpeed" :min="0" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSave">保存设置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
import { getPointSetting, savePointSetting } from '@/api/point'
export default {
  name: 'PointSetting',
  data() { return { form: { pointName: '积分', pointNeedConsume: 1, rechargePointSpeed: 100 } } },
  created() { this.fetchSetting() },
  methods: {
    fetchSetting() { getPointSetting().then(res => { if (res.data) this.form = { ...this.form, ...res.data } }).catch(() => {}) },
    handleSave() { savePointSetting(this.form).then(() => { this.$message.success('保存成功') }).catch(() => {}) }
  }
}
</script>

<template>
  <div class="app-container">
    <el-card>
      <div slot="header"><span>充值设置</span></div>
      <el-form :model="form" label-width="150px">
        <el-form-item label="充值规则说明">
          <el-input v-model="form.rechargeRuleDesc" type="textarea" :rows="3" style="width:400px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSave">保存</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
import { getRechargeSetting, saveRechargeSetting } from '@/api/recharge'
export default {
  name: 'RechargeSetting',
  data() { return { form: { rechargeRuleDesc: '' } } },
  created() { this.fetchSetting() },
  methods: {
    fetchSetting() { getRechargeSetting().then(res => { if (res.data) this.form = { ...this.form, ...res.data } }).catch(() => {}) },
    handleSave() { saveRechargeSetting(this.form).then(() => { this.$message.success('保存成功') }).catch(() => {}) }
  }
}
</script>

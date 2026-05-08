<template>
  <div class="app-container">
    <el-card>
      <div slot="header"><span>会员充值</span></div>
      <el-form :model="form" label-width="120px" :rules="rules" ref="form">
        <el-form-item label="会员手机号" prop="mobile">
          <el-input v-model="form.mobile" placeholder="请输入会员手机号" style="width:300px;" />
        </el-form-item>
        <el-form-item label="充值金额" prop="amount">
          <el-input-number v-model="form.amount" :min="1" :max="100000" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" placeholder="备注信息" style="width:300px;" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRecharge">确认充值</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
import { doRecharge } from '@/api/recharge'
export default {
  name: 'RechargeMember',
  data() {
    return {
      form: { mobile: '', amount: 100, remark: '' },
      rules: { mobile: [{ required: true, message: '请输入手机号', trigger: 'blur' }], amount: [{ required: true, message: '请输入金额', trigger: 'blur' }] }
    }
  },
  methods: {
    handleRecharge() {
      this.$refs.form.validate(valid => {
        if (valid) {
          doRecharge(this.form).then(() => { this.$message.success('充值成功'); this.form = { mobile: '', amount: 100, remark: '' } }).catch(() => {})
        }
      })
    }
  }
}
</script>

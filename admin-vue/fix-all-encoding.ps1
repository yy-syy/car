$files = Get-ChildItem -Path "src" -Recurse -Include "*.vue", "*.js"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    $content = $content -replace '鐠囩柉绶崗銉ㄥ閸?', '请输入账号'
    $content = $content -replace '绾喖鐣鹃崚鐘绘珟鐠囥儱.*?閹绘劗銇?', '确定要删除这条记录吗, 确认删除'
    $content = $content -replace '閸掔娀娅庨幋鎰', '删除成功'
    
    $content = $content -replace '閺堫亙濞囬悽?', '未使用'
    $content = $content -replace '瀹歌弓濞囬悽?', '已使用'
    $content = $content -replace '瀹歌尪绻冮張?', '已过期'
    
    $content = $content -replace '瀵板懏甯撮弨?', '待领取'
    $content = $content -replace '瀹稿弶甯撮弨?', '已领取'
    
    $content = $content -replace '閸欐垿鈧焦鍨氶崝?', '发送成功'
    
    $content = $content -replace '瀵板懏鏁禒?', '待付款'
    $content = $content -replace '瀵板懐鈥樼拋?', '待确认'
    $content = $content -replace '瀹告彃鐣幋?', '已完成'
    $content = $content -replace '瀹告彃褰囧☉?', '已取消'
    
    $content = $content -replace '瀵板懎顓搁弽?', '待审核'
    $content = $content -replace '瀹告煡鈧俺绻?', '已通过'
    $content = $content -replace '瀹稿弶瀚嗙紒?', '已拒绝'
    
    $content = $content -replace '閺傛澘顤冮悞锔惧仯閸?', '轮播图编辑'
    
    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)
    Write-Host "Fixed: $($file.FullName)"
}
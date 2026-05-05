$files = Get-ChildItem -Path "src" -Recurse -Include "*.vue", "*.js"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    $content = $content -replace '璇疯緭鍏ヨ处�?', '�������˺�'
    $content = $content -replace '璁よ瘉澶辫触锛岃閲嶆柊鐧诲綍銆?', '��֤ʧ�ܣ������µ�¼��'
    $content = $content -replace '认证失败，请重新登录�?', '��֤ʧ�ܣ������µ�¼��'
    $content = $content -replace '�?', '��'
    $content = $content -replace '一', 'һ'
    $content = $content -replace '�?', '��'
    $content = $content -replace '�?', '��'
    $content = $content -replace '�?', '��'
    $content = $content -replace '�?', '��'
    $content = $content -replace '�?', '��'
    $content = $content -replace '退款管�?', '�˿����'
    $content = $content -replace '商品管理', '��Ʒ����'
    
    $content = $content -replace '待付�?', '������'
    $content = $content -replace '待确�?', '��ȷ��'
    $content = $content -replace '已完�?', '�����'
    $content = $content -replace '已取�?', '��ȡ��'
    $content = $content -replace '待领�?', '����ȡ'
    $content = $content -replace '已领�?', '����ȡ'
    $content = $content -replace '已过�?', '�ѹ���'
    $content = $content -replace '鍏呭�?', '��ֵ'
    $content = $content -replace '娑堣�?', '����'
    $content = $content -replace '閫€�?', '�˿�'
    
    $content = $content -replace '闁哄倹婢橀·鍐棘閸モ晝�?', '���±༭'
    $content = $content -replace '杞挱鍥剧紪�?', '�ֲ�ͼ�༭'
    $content = $content -replace '闁哄倹婢橀·鍐礆閸℃瑧�?', '��ȯ��༭'
    $content = $content -replace '闁哄秵鎮傞弨銏ゅ箣閹邦剙�?', '��˳ɹ�'
    $content = $content -replace '闁告稏鍔嬬粩?', '��һ'
    $content = $content -replace '闁告稏鍔嬬花?', '�ܶ�'
    $content = $content -replace '闁告稏鍔嬬粭?', '����'
    $content = $content -replace '闁告稏鍔屽�?', '����'
    $content = $content -replace '闁告稏鍔岄崣?', '����'
    $content = $content -replace '闁告稏鍔嶅�?', '����'
    
    $content = $content -replace '瀵板懎顦╅悶?', '�����'
    $content = $content -replace '瀹�?弶澹掗崙?', '��ͨ��'
    $content = $content -replace '已拒�?', '�Ѿܾ�'
    $content = $content -replace '已完�?', '�����'
    
    $content = $content -replace '闁哄倹婢橀·鍐疮閸℃�?', '��Ʒ�༭'
    $content = $content -replace '闁哄倹婢橀·鍐矆閻撳骸�?', '��Ʒ�༭'
    
    $content = $content -replace '寰呴鍙?', '����ȡ'
    $content = $content -replace '宸查鍙?', '����ȡ'
    $content = $content -replace '宸茶繃鏈?', '�ѹ���'
    
    $content = $content -replace '鍙戦€佹垚鍔?', '���ͳɹ�'
    
    $content = $content -replace '闁哄倹婢橀·鍐╂償濡ゅ懏�?', '�ŵ�༭'
    $content = $content -replace '闁哄倹婢橀·鍐冀閹间焦鏁樺ù�?冩惈�?', 'Ա���༭'
    $content = $content -replace '闁哄倹婢橀·鍐嫻閿曗偓�?', '�˺ű༭'
    $content = $content -replace '闁哄倹婢橀·鍐嚕濠婂啫绀?', '�˵��༭'
    $content = $content -replace '闁哄倹婢橀·鍐喆閹烘洖�?', '��ɫ�༭'
    
    $content = $content -replace '待确�?', '��ȷ��'
    $content = $content -replace '瀹歌尙鈥樼拋?', '��ȷ��'
    $content = $content -replace '已取�?', '��ȡ��'
    
    $content = $content -replace '绾喖鐣鹃崚鐘绘珟鐠囥儴婧呮潏鍡楁偋�?', 'ȷ��Ҫɾ��������¼��'
    $content = $content -replace '閹绘劗銇?', 'ȷ��ɾ��'
    
    $content = $content -replace '纭畾鍒犻櫎璇ュ.*?鎻愮�?', 'ȷ��Ҫɾ��������¼��, ȷ��ɾ��'
    $content = $content -replace '鍒犻櫎鎴愬姛', 'ɾ���ɹ�'
    
    $content = $content -replace '鏈娇鐢?', 'δʹ��'
    $content = $content -replace '宸蹭娇鐢?', '��ʹ��'
    
    $content = $content -replace '寰呬粯娆?', '������'
    $content = $content -replace '寰呯‘璁?', '��ȷ��'
    $content = $content -replace '宸插畬鎴?', '�����'
    $content = $content -replace '宸插彇娑?', '��ȡ��'
    
    $content = $content -replace '寰呭鏍?', '�����'
    $content = $content -replace '宸查€氳�?', '��ͨ��'
    $content = $content -replace '宸叉嫆缁?', '�Ѿܾ�'
    
    $content = $content -replace '鎮ㄥ凡琚櫥鍑猴紝璇烽噸鏂扮櫥� ��?', '���ѱ��ǳ��������µ�¼'
    $content = $content -replace '纭鐧诲嚭', 'ȷ�ϵǳ�'
    $content = $content -replace '閲嶆柊鐧诲綍', '���µ�¼'
    $content = $content -replace '鍙栨�?', 'ȡ��'
    
    [System.IO.File]::WriteAllBytes($file.FullName, [System.Text.Encoding]::UTF8.GetBytes($content))
    Write-Host "Fixed: $($file.FullName)"
}
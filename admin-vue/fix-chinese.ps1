$files = Get-ChildItem -Path "src" -Recurse -Include "*.vue", "*.js"

foreach ($file in $files) {
    try {
        $content = [System.IO.File]::ReadAllText($file.FullName)
        
        $content = $content.Replace('瀵板懍绮▎?', '������')
        $content = $content.Replace('瀵板懐鈥樼拋?', '��ȷ��')
        $content = $content.Replace('瀹告彃鐣幋?', '�����')
        $content = $content.Replace('瀹告彃褰囧☉?', '��ȡ��')
        
        $content = $content.Replace('待付�?', '������')
        $content = $content.Replace('待确�?', '��ȷ��')
        $content = $content.Replace('已完�?', '�����')
        $content = $content.Replace('已取�?', '��ȡ��')
        
        $content = $content.Replace('待领�?', '����ȡ')
        $content = $content.Replace('已领�?', '����ȡ')
        $content = $content.Replace('已过�?', '�ѹ���')
        
        $content = $content.Replace('鍏呭�?', '��ֵ')
        $content = $content.Replace('娑堣�?', '����')
        $content = $content.Replace('閫€�?', '�˿�')
        
        $content = $content.Replace('鏈娇鐢?', 'δʹ��')
        $content = $content.Replace('宸蹭娇鐢?', '��ʹ��')
        
        $content = $content.Replace('寰呬粯娆?', '������')
        $content = $content.Replace('寰呯‘璁?', '��ȷ��')
        $content = $content.Replace('宸插畬鎴?', '�����')
        $content = $content.Replace('宸插彇娑?', '��ȡ��')
        
        $content = $content.Replace('寰呭鏍?', '�����')
        $content = $content.Replace('宸查€氳�?', '��ͨ��')
        $content = $content.Replace('宸叉嫆缁?', '�Ѿܾ�')
        
        $content = $content.Replace('瀵板懎顦╅悶?', '�����')
        $content = $content.Replace('瀹�?弶澹掗崙?', '��ͨ��')
        $content = $content.Replace('已拒�?', '�Ѿܾ�')
        
        $content = $content.Replace('闁哄倹婢橀·鍐棘閸モ晝�?', '���±༭')
        $content = $content.Replace('杞挱鍥剧紪�?', '�ֲ�ͼ�༭')
        $content = $content.Replace('闁哄倹婢橀·鍐礆閸℃瑧�?', '��ȯ��༭')
        $content = $content.Replace('闁哄倹婢橀·鍐疮閸℃�?', '��Ʒ�༭')
        $content = $content.Replace('闁哄倹婢橀·鍐矆閻撳骸�?', '��Ʒ�༭')
        $content = $content.Replace('闁哄倹婢橀·鍐╂償濡ゅ懏�?', '�ŵ�༭')
        $content = $content.Replace('闁哄倹婢橀·鍐冀閹间焦鏁樺ù�?冩惈�?', 'Ա���༭')
        $content = $content.Replace('闁哄倹婢橀·鍐嫻閿曗偓�?', '�˺ű༭')
        $content = $content.Replace('闁哄倹婢橀·鍐嚕濠婂啫绀?', '�˵��༭')
        $content = $content.Replace('闁哄倹婢橀·鍐喆閹烘洖�?', '��ɫ�༭')
        $content = $content.Replace('退款管�?', '�˿����')
        $content = $content.Replace('商品管理', '��Ʒ����')
        
        $content = $content.Replace('闁告稏鍔嬬粩?', '��һ')
        $content = $content.Replace('闁告稏鍔嬬花?', '�ܶ�')
        $content = $content.Replace('闁告稏鍔嬬粭?', '����')
        $content = $content.Replace('闁告稏鍔屽�?', '����')
        $content = $content.Replace('闁告稏鍔岄崣?', '����')
        $content = $content.Replace('闁告稏鍔嶅�?', '����')
        
        $content = $content.Replace('闁哄秵鎮傞弨銏ゅ箣閹邦剙�?', '��˳ɹ�')
        $content = $content.Replace('鍙戦€佹垚鍔?', '���ͳɹ�')
        $content = $content.Replace('鍒犻櫎鎴愬姛', 'ɾ���ɹ�')
        
        $content = $content.Replace('绾喖鐣鹃崚鐘绘珟鐠囥儴婧呮潏鍡楁偋�?', 'ȷ��Ҫɾ��������¼��')
        $content = $content.Replace('閹绘劗銇?', 'ȷ��ɾ��')
        $content = $content.Replace('纭鐧诲嚭', 'ȷ�ϵǳ�')
        $content = $content.Replace('閲嶆柊鐧诲綍', '���µ�¼')
        $content = $content.Replace('鍙栨�?', 'ȡ��')
        $content = $content.Replace('鎮ㄥ凡琚櫥鍑猴紝璇烽噸鏂扮櫥� ��?', '���ѱ��ǳ��������µ�¼')
        
        $content = $content.Replace('寰呴鍙?', '����ȡ')
        $content = $content.Replace('宸查鍙?', '����ȡ')
        $content = $content.Replace('宸茶繃鏈?', '�ѹ���')
        
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed: $($file.FullName)"
    } catch {
        Write-Host "Error fixing $($file.FullName): $_"
    }
}

Write-Host "Done!"
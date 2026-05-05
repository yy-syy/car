$files = Get-ChildItem -Path "src" -Recurse -Include "*.vue", "*.js"

foreach ($file in $files) {
    try {
        $gbkBytes = [System.IO.File]::ReadAllBytes($file.FullName)
        $content = [System.Text.Encoding]::GetEncoding("GBK").GetString($gbkBytes)
        $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
        [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)
        Write-Host "Converted: $($file.FullName)"
    } catch {
        Write-Host "Error converting $($file.FullName): $_"
    }
}
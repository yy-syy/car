$files = Get-ChildItem -Path "src" -Recurse -Filter "*.vue"
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)
    Write-Host "Fixed: $($file.FullName)"
}

$files = Get-ChildItem -Path "src" -Recurse -Filter "*.js"
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)
    Write-Host "Fixed: $($file.FullName)"
}
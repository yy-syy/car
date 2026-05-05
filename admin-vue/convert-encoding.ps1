$files = Get-ChildItem -Path "src" -Recurse -Include "*.vue", "*.js"

foreach ($file in $files) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding Default
        $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
        [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)
        Write-Host "Converted: $($file.FullName)"
    } catch {
        Write-Host "Error converting $($file.FullName): $_"
    }
}
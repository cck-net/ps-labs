<# 
CSV File Validator

This script validates all files in the selected directory, writting to console:
    1. headers out of selected range, and
    2. lines that do not matches the header format

The sample_files folder contains some use cases to showcase.
#>

$path = "C:\Users\Mark\Desktop\sample_files"
$spliter = "`t"
$minCols = 2
$maxCols = 10

$files = Get-ChildItem -Path $path -File

foreach ($file in $files) {

    $rows = Get-Content -Path $file.FullName
    $headCols = $rows[0].Split($spliter).Length

    if ($headCols -lt $minCols -or $headCols -gt $maxCols) {
        Write-Output "$($file.Name) HEADER: $($rows[0])"
        continue;
    }

    for ($i = 1; $i -lt $rows.Length; $i++) {
        $cols = $rows[$i].Split($spliter).Length

        if ($cols -ne $headCols) {
            Write-Output "$($file.Name) [$($i + 1)]: $rows[$i]"
        }
    }
}

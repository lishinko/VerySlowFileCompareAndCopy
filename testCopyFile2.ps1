. .\enumFile.ps1
$newFolder = 'some folder'
$oldFolder = 'some other folder'

$outputFolder = 'outputfolder'

$start = Get-Date
Copy-DiffFile-To $newFolder $oldFolder $outputFolder
$end = Get-Date

$usedTime = $end - $start
$usedTime.ToString()

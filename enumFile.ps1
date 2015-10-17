. .\comparefile.ps1
function Compare-Folder($newFolder, $oldFolder){
    $newFiles = @()
    Get-ChildItem $newFolder -Recurse |ForEach-Object {
        if($_.Directory){ #这里有问题吧。。Directory字段居然表示这个文件不是目录。。。
            $relativeName = $_.FullName.Remove(0, $newFolder.Length)
            $oldFileName = $oldFolder + $relativeName
            if(Compare-File $_.FullName $oldFileName){
                $obj = [pscustomobject]@{
                    FullName = $_.FullName
                    RelativeName = $relativeName
                }
                $newFiles += $obj
            }
        }
    }
    $newFiles
    Write-Host $newFiles
}
function Copy-DiffFile-To($newFolder, $oldFolder, $outputFolder){
    Compare-Folder $newFolder $oldFolder | ForEach-Object {
        $outputPath = $outputFolder + $_.RelativeName
        $outputDirectory = $outputPath.Remove($outputPath.LastIndexOf('\'))
        if(!(Test-Path $outputDirectory)){
            $nouse = mkdir $outputDirectory
        }
        Copy-Item $_.FullName $outputPath -Recurse
    }
}

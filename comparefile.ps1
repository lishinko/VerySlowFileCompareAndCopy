function Compare-File($newFile, $oldFile){
    if(!(Test-Path $oldFile)){
        return $true
    }
    $simpleCompare = diff (Get-Item $newFile) (Get-Item $oldFile) -Property Length, Name
    if($simpleCompare -eq $null){
        $contentCompare = diff (Get-Content $newFile) (Get-Content $oldFile)
        if($contentCompare -eq $null){
            return $false
        }
    }
    return $true
}
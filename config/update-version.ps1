# Arguments that get passed to the script when running it
param (
    [Parameter(Position=1)]
    $OldImageName,
    [Parameter(Position=2)]
    $NewImageName,
    [Parameter(Position=3)]
    $FileName
)
$content = Get-Content -Path $FileName
$newContent = $content -replace $OldImageName, $NewImageName
$newContent | Set-Content -Path $FileName
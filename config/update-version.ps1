# Arguments that get passed to the script when running it
param (
    [Parameter(Position=1)]
    $OldImageName,
    [Parameter(Position=2)]
    $NewImageName
)
$content = Get-Content -Path 'environment.yaml'
$newContent = $content -replace $OldImageName, $NewImageName
$newContent | Set-Content -Path 'environment.yaml'
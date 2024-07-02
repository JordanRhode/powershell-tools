#!/usr/bin/env pwsh
param([switch]$force)

git fetch --prune

$localBranches = (git for-each-ref refs/heads --format='%(upstream)') -replace "refs/remotes/", ""
$remoteBranches = ((git branch -r) -replace "\*", "") -replace " ", ""

$toDelete = $localBranches | Where-Object {$remoteBranches -NotContains $_ -and $_ -ne ""} | ForEach-Object {$_ -replace "azure/", "" -replace "origin/", ""}

if ($toDelete.count -gt 0) {
    "Deleting {0} Local Branches:" -f $toDelete.count | Write-host -ForegroundColor "Green"
    $toDelete | ForEach-Object { "`t" + $_ } | Write-Host
    "Press (y) to delete..." | Write-host -ForegroundColor "Red"
    if ($host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character -eq "y") {
        $toDelete | ForEach-Object {
            if ($force.IsPresent) {
                git branch -D $_
            }
            else {
                git branch -d $_
            }
        }
        "Complete" | Write-host -ForegroundColor "Cyan"
    }
    else {
        "Cancelled" | Write-host -ForegroundColor "Cyan"
    }
}
else {
    "No branches deleted" | Write-host -ForegroundColor "Cyan"
}
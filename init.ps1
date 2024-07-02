#!/usr/bin/env pwsh

param([switch]$local)

$dir = $PSScriptRoot -replace '\\', '/' -replace ' ', '\ '

git config --global alias.branch-cleanup "!$dir/git-branch-cleanup.ps1"

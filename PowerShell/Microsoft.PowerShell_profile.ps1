$poshTheme = "~\.dotfiles\poshthemes\material.omp.json"
if (!(Test-Path $poshTheme)) {
    $poshTheme = "~/jandedobbeleer.omp.json"
}

oh-my-posh --init --shell pwsh --config $poshTheme | Invoke-Expression
Import-Module posh-git
Import-Module PSReadLine

Push-Location (Split-Path -Parent $profile)
Get-ChildItem *.ps1 -Exclude "Microsoft.PowerShell_profile.ps1" | ForEach-Object -Process {Invoke-Expression ". $_"}
Pop-Location

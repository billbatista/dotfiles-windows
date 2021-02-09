Import-Module oh-my-posh
Import-Module posh-git
Import-Module PSReadLine

if ((Test-Path "~\.dotfiles\poshthemes\my-star.omp.json")) {
    Set-PoshPrompt -Theme ~\.dotfiles\poshthemes\my-star.omp.json
} else {
    Set-PoshPrompt -Theme star # fallback to original oh-my-posh theme
}

Push-Location (Split-Path -Parent $profile)
Get-ChildItem *.ps1 -Exclude "Microsoft.PowerShell_profile.ps1" | ForEach-Object -Process {Invoke-Expression ". $_"}
Pop-Location

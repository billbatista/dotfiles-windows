if ($PSVersionTable.PSEdition -ne "Core") { 
    Write-Warning "You should be using PowerShell core"
}

# Copy aliases file to PowerShell profile
$profileDir = Split-Path -Parent $profile
if (!(Test-Path $profileDir)) {
    New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
}

# Install PowerShell modules
# Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
# Install-Module PSReadLine -Scope CurrentUser -AllowPrerelease -Force
# Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force

# Create symlinks
$answer = Read-Host "The next step will overwrite the current configuration files, continue? [Y/n]"
if ($answer -eq "" -or $answer.ToLower() -eq "y") {

    $configFiles = "$($profileDir)\aliases.ps1",
                    "$($profileDir)\Microsoft.PowerShell_profile.ps1",
                    "$($home)\.gitconfig",
                    "$($home)\.wslconfig",
                    "$($profileDir)\functions.ps1",
                    "$($home)\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"

    foreach ($file in $configFiles) {
        Remove-Item -Path $file -Force -ErrorAction SilentlyContinue
    }
    
    $commands = "/c mklink $($profileDir)\aliases.ps1 $($PSScriptRoot)\PowerShell\aliases.ps1 & "
    $commands += "mklink $($profileDir)\functions.ps1 $($PSScriptRoot)\PowerShell\functions.ps1 & "
    $commands += "mklink $($profileDir)\Microsoft.PowerShell_profile.ps1 $($PSScriptRoot)\PowerShell\Microsoft.PowerShell_profile.ps1 & "
    $commands += "mklink $($home)\.gitconfig $($PSScriptRoot)\.gitconfig & "
    $commands += "mklink $($home)\.wslconfig $($PSScriptRoot)\.wslconfig & "
    $commands += "mklink $($home)\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json $($PSScriptRoot)\WindowsTerminal\settings.json & "
    $commands += "pause"
    Start-Process "cmd" -ArgumentList $commands -Verb runas
    
} else {
    Write-Host "Configuration files not written"
}

# Copy Windows Terminal settings file
# Copy-Item -Path ~\.dotfiles\WindowsTerminal\settings.json -Destination ~\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json -Force -ErrorAction SilentlyContinue

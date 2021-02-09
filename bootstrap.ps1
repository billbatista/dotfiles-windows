. .\helpers\helpers.ps1

if ($PSVersionTable.PSEdition -ne "Core") { 
    Write-Warning "You should be using PowerShell core"
}

# Copy aliases file to PowerShell profile
$profileDir = Split-Path -Parent $profile
if (!(Test-Path $profileDir)) {
    New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
}

# Install PowerShell modules
Write-Information "Updating PowerShell modules..."
# Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
# Install-Module PSReadLine -Scope CurrentUser -AllowPrerelease -Force
# Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force

# Create symlinks
$answer = Read-Host "The next step will overwrite the current configuration files, continue? [Y/n]"
if (Test-Answer -Answer $answer -Expected "y") {

    $configFiles = "$($profileDir)\aliases.ps1",
                    "$($profileDir)\Microsoft.PowerShell_profile.ps1",
                    "$($home)\.gitconfig",
                    "$($home)\.wslconfig",
                    "$($profileDir)\functions.ps1",
                    "$($home)\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json",
                    "$($home)\Documents\ShareX\ApplicationConfig.json",
                    "$($home)\Documents\ShareX\HotkeysConfig.json"

    foreach ($file in $configFiles) {
        Remove-Item -Path $file -Force -ErrorAction SilentlyContinue
    }
    
    $commands = "/c mklink $($profileDir)\aliases.ps1 $($PSScriptRoot)\PowerShell\aliases.ps1 & "
    $commands += "mklink $($profileDir)\functions.ps1 $($PSScriptRoot)\PowerShell\functions.ps1 & "
    $commands += "mklink $($profileDir)\Microsoft.PowerShell_profile.ps1 $($PSScriptRoot)\PowerShell\Microsoft.PowerShell_profile.ps1 & "
    $commands += "mklink $($home)\.gitconfig $($PSScriptRoot)\.gitconfig & "
    $commands += "mklink $($home)\.wslconfig $($PSScriptRoot)\.wslconfig & "
    $commands += "mklink $($home)\Documents\ShareX\ApplicationConfig.json $($PSScriptRoot)\ShareX\ApplicationConfig.json & "
    $commands += "mklink $($home)\Documents\ShareX\HotkeysConfig.json $($PSScriptRoot)\ShareX\HotkeysConfig.json & "
    $commands += "pause"
    Start-Process "cmd" -ArgumentList $commands -Verb runas

    # criar sync de settings do windows terminal
    
} else {
    Write-Host "Configuration files not written"
}

# Winget packages
$answer = Read-Host "Install winget packages? [Y/n]"
if (Test-Answer -Answer $answer -Expected "y") {
    if (!(Get-Command winget)) {
        Write-Host "winget not found, you can get it here https://github.com/microsoft/winget-cli"
    } else {
        $apps = "Microsoft.PowerToys",
                "Discord.Discord",
                "Microsoft.AzureDataStudio",
                "Mozilla.Firefox",
                "7zip.7zip",    
                "KeePassXCTeam.KeePassXC",
                "Spotify.Spotify",
                "Microsoft.VisualStudioCode-User-x64",
                "Notepad++.Notepad++",
                "Microsoft.Teams"

        foreach ($app in $apps) {
            winget install $($app)
        }
    } else {
        Write-Host "No packages will be installed"
    }
}

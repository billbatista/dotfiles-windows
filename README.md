# Windows and apps configuration files

## Installation

[Install the Agave font from Nerd Fonts](https://www.nerdfonts.com/font-downloads). If you prefer another font, just make sure it is powerline compatible (if you download it from Nerd Fonts you're most likely safe). This is to guarantee _oh-my-posh_ works best with Windows Terminal and no symbols/icons are missing.

_The following has not been tested in extense_

1. [Install PowerShell core](https://github.com/PowerShell/PowerShell)
1. Install Windows Terminal from the Store
1. clone the repo home folder ```git clone <repo link> ~\.dotfiles```
1. Using powershell, navigate to the repository root folder and run ```.\bootstrap.ps1```

The script will install/update the following PowerShell modules: oh-my-posh, PSReadLine, posh-git.

Then it will swap out current configuration files for Git, PowerShell, WSL and Windows Terminal with the ones in the repo, and also add a couple PowerShell scripts to the user profile. During this step it will ask for permission as it needs an elevated cmd.exe prompt. This works by removing the original files and creating symlinks for them. Then, by changing the files in the repository the symlinks in the original locations will reflect the changes.

I encourage you to fork this repo so you can change the files at your will and any major update on my repo you can just merge to yours.

### Windows Terminal with a modified oh-my-posh theme:

![](.\images\WindowsTerminal.png)

### PowerShell aliases:

![](.\images\PowerShell_aliases.png)

### Git aliases:

![](.\images\git_alias.png)

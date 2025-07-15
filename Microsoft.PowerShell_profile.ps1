### PowerShell Profile
### Version 2.0 - Refactored by Clue-ess-coder 🙂

# Admin Check and Prompt Customization
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt {
    if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
    ## Init Zoxide
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

#opt-out of telemetry before doing anything, only if PowerShell is run as admin
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

$adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()

# Some Random Shenanigans
function Clear-Cache {
    # add clear cache logic here
    Write-Host "Clearing cache..." -ForegroundColor Cyan

    # Clear Windows Prefetch
    Write-Host "Clearing Windows Prefetch..." -ForegroundColor Yellow
    Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

    # Clear Windows Temp
    Write-Host "Clearing Windows Temp..." -ForegroundColor Yellow
    Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

    # Clear User Temp
    Write-Host "Clearing User Temp..." -ForegroundColor Yellow
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

    # Clear Internet Explorer Cache
    Write-Host "Clearing Internet Explorer Cache..." -ForegroundColor Yellow
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Cache clearing completed." -ForegroundColor Green
}

# Utility Functions
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Editor Configuration
$EDITOR = if (Test-CommandExists micro) { 'micro' }
          elseif (Test-CommandExists code) { 'code' }
          elseif (Test-CommandExists notepad++) { 'notepad++' }
          else { 'notepad' }
Set-Alias -Name vim -Value $EDITOR

function Edit-Profile {
    vim $PROFILE.CurrentUserAllHosts
}

#################################################
# New Additions
#################################################
# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# Open WinUtil full-release
function winutil {
    irm https://christitus.com/win | iex
}

# Open WinUtil dev-release
function winutildev {
	# If function "WinUtilDev_Override" is defined in profile.ps1 file
    # then call it instead.
    if (Get-Command -Name "WinUtilDev_Override" -ErrorAction SilentlyContinue) {
        WinUtilDev_Override
    } else {
        irm https://christitus.com/windev | iex
    }
}

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command with elevated rights.
Set-Alias -Name su -Value admin

function touch($file) { "" | Out-File $file -Encoding ASCII }

function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.directory)\$($_)"
    }
}

# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# System Utilities
function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}

function reloadprofile {
    & $profile
}

# Original unzip function
# function unzip ($file) {
#     Write-Output("Extracting", $file, "to", $pwd)
#     $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
#     Expand-Archive -Path $fullFile -DestinationPath $pwd
# }

function unzip ($file) {
    $currentPath = Get-Location
    $fullFile = Join-Path -Path $currentPath -ChildPath $file
    
    if (Test-Path $fullFile) {
        Write-Output("Extracting", $file, "to", $currentPath)
        Expand-Archive -Path $fullFile -DestinationPath $currentPath -Force
    } else {
        Write-Error "File not found: $fullFile"
    }
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function df {
    get-volume
}

function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

# Quick File Creation
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

# Directory Management
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }

function trash($path) {
    $fullPath = (Resolve-Path -Path $path).Path

    if (Test-Path $fullPath) {
        $item = Get-Item $fullPath

        if ($item.PSIsContainer) {
          # Handle directory
            $parentPath = $item.Parent.FullName
        } else {
            # Handle file
            $parentPath = $item.DirectoryName
        }

        $shell = New-Object -ComObject 'Shell.Application'
        $shellItem = $shell.NameSpace($parentPath).ParseName($item.Name)

        if ($item) {
            $shellItem.InvokeVerb('delete')
            Write-Host "Item '$fullPath' has been moved to the Recycle Bin."
        } else {
            Write-Host "Error: Could not find the item '$fullPath' to trash."
        }
    } else {
        Write-Host "Error: Item '$fullPath' does not exist."
    }
}


### Quality of Life Aliases

# Navigation Shortcuts
function docs { 
    $docs = if(([Environment]::GetFolderPath("MyDocuments"))) {([Environment]::GetFolderPath("MyDocuments"))} else {$HOME + "\Documents"}
    Set-Location -Path $docs
}
    
function dtop { 
    $dtop = if ([Environment]::GetFolderPath("Desktop")) {[Environment]::GetFolderPath("Desktop")} else {$HOME + "\Documents"}
    Set-Location -Path $dtop
}

# Quick Access to Editing the Profile
function ep { vim $PROFILE }

# Simplified Process Management
function k9 { Stop-Process -Name $args[0] }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Git Shortcuts
function gs { git status }

function ga { git add . }

function gc { param($m) git commit -m "$m" }

function gpush { git push }

function gpull { git pull }

function g { __zoxide_z github }

function gcl { git clone "$args" }

function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Networking Utilities
function flushdns { 
    Clear-DnsClientCache 
    Write-Host "DNS cache flushed." -ForegroundColor Green
}

# Clipboard Utilities
function cpy { Set-Clipboard $args[0] }

function pst { Get-Clipboard }

# Enhanced PowerShell Experience
Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
}

function egc {
    vim "C:\Users\Abdul-Hameed\.glzr\glazewm\config.yaml"
}

function ezc {
    vim "C:\Users\Abdul-Hameed\.glzr\zebar\config.yaml"
}

function bm {
    zoxide add .
}

function hugo-dev {
    hugo server -D --disableFastRender --noHTTPCache --renderToMemory --gc --navigateToChanged
}

function compile-pdf {
    xelatex --shell-escape main.tex
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

function init {
    # Import Modules and External Profiles
    Import-Module -Name Terminal-Icons
    oh-my-posh init pwsh --config 'C:\Users\Abdul-Hameed\AppData\Local\Programs\oh-my-posh\themes\tonybaloney.omp.json' | Invoke-Expression
}

function clear-history {
    set-content -Path ((Get-PSReadLineOption).HistorySavePath) -value 'Write-Host "You manually cleared this history on (Get-Date)"'
}

# Aliases

Set-Alias -Name serve -Value hugo-dev

Import-Module 'gsudoModule'
Invoke-Expression (& { (zoxide init --cmd z powershell | Out-String) })

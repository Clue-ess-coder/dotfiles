### PowerShell Profile ### Version 2.0 - Refactored by Clue-ess-coder 🙂

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt {
    if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
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
Set-Alias -Name vim -Value "nvim"

function Edit-Profile {
    vim $PROFILE
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

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}
Set-Alias -Name su -Value admin

function touch($file) { "" | Out-File $file -Encoding ASCII }

### Profile Management
function Reload-Profile {
    & $PROFILE
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

# Directory Management
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Networking Utilities
function flushdns { 
    Clear-DnsClientCache 
    Write-Host "DNS cache flushed." -ForegroundColor Green
}

# Clipboard Utilities

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
Set-Alias -Name serve -Value hugo-dev

function compile-pdf {
    xelatex --shell-escape main.tex
}

function Clear-History {
    set-content -Path ((Get-PSReadLineOption).HistorySavePath) -Value "hello"
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

# function init {
#     Import-Module -Name Terminal-Icons
#
#     oh-my-posh init pwsh --config 'C:\Users\Abdul-Hameed\AppData\Local\Programs\oh-my-posh\themes\tonybaloney.omp.json' | Invoke-Expression
# }

Set-PSReadLineOption -EditMode vi
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

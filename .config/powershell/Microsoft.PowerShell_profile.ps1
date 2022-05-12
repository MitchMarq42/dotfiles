#!/bin/pwsh

# Powershell profile. Runs before entering a normal powershell session, and
# raises the interface from bearable to almost-comfy.

# a bunch of this stuff will be transposed from the zsh stuff...

# clear screen, but only a little bit
# & tput cup 0 0

switch ($env:TTY) {
    ("/dev/tty5") {& startx $env:XINITRC}
    ("/dev/tty7") {& sway; exit}
    default {}
}

switch -regex ($env:TMUX) {
    (".*") {$env:OLDTERM = $env:TERM}
    default {
	switch -regex ($env:TERM) {
	    (alacritty|eterm*|xterm-*) {}
	    default {$env:OLDTERM = $env:TERM ; & tmux ; exit}
	}
    }
}

# environment fixes
$env:XDG_DATA_HOME = "$env:HOME/.local/share"
$env:PATH = "$env:HOME/.local/bin/:" + $env:PATH

# Re-define the prompt() function. A simple imitation of my p10k config.
function Prompt(){
    write-host ((get-location).path -replace (($home).replace('\','/')),'~') `
      -foregroundcolor darkblue
    switch ($lastexitcode) {
	(0) {$color = "darkgreen"}        # Success = exit code 0
	# ($null) {$color = "darkgreen"}    # New shell = no exit code
	default {$color = "darkred"}      # All other exit codes are bad
    }
    write-host ">" -foregroundcolor $color -nonewline
    return " " #"`e[5 q"
}

# Vi-style line editing. Pretty good but no visual mode.
Set-PSReadLineOption -ViModeIndicator 'cursor'
set-psreadlineOption -editmode vi

# zsh-like interactive array completion. Very not-perfect.
Set-PSReadLineKeyHandler -chord tab -function MenuComplete
set-psreadlineOption -ShowToolTips:$False

# history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Packages/modules (broken)
$github = 'https://github.com/' 
$modulesdir = ($env:XDG_DATA_HOME + '/powershell/Modules/')
$startingdir = get-location

function use-module(){
    param([string]$name,
	  [string]$dev = 'powershell',
	  [string]$manifest,
	  [string]$build,
	  [string]$import,
	  [scriptblock]$if = {return $true})
    if ($if.invoke()) {
	# "loading " + $name # DEBUG
	$remote = ($github + $dev + '/' + $name)
	$local = $modulesdir + $name
	$absmanifest = $local + '/' + $manifest
	if (!(test-path $absmanifest)) {
	    "Installing " + $name
	    git clone $remote ($modulesdir + $name)
	    if ($build) {
		set-location $local
		invoke-expression $build
	    }
	}
	if ($import) {
	    set-location $local
	    import-module $import
	} else {
	    Import-Module $absmanifest
	}
	set-location $startingdir
    }
}
# posh-git
use-module 'posh-git' `
  -dev 'dahlbyk' `
  -manifest 'src/posh-git.psd1'
# unix-completers
use-module 'unixcompleters' `
  -if {$PSVersionTable.PSVersion.Major -ge 6} `
  -manifest 'Microsoft.PowerShell.UnixTabCompletion.psd1' `
  -build './build.ps1 -Clean' `
  -import './out/Microsoft.PowerShell.UnixTabCompletion/0.5.0/Microsoft.PowerShell.UnixTabCompletion.dll'

[Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()

#!/bin/pwsh

# Powershell profile. Runs before entering a normal powershell session, and
# raises the interface from bearable to almost-comfy.

# a bunch of this stuff will be transposed from the zsh stuff...


switch -regex (tty) {
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

$PSReadlineOptions = @{
    editmode = 'vi'
    vimodeindicator = 'cursor'
    HistorySearchCursorMovesToEnd = $true
    showtooltips = $false
}

set-psreadlineoption @PSReadlineOptions

# zsh-like interactive array completion. Very not-perfect.
Set-PSReadLineKeyHandler -chord tab -function MenuComplete

# history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Quote auto-matching-- see https://github.com/PowerShell/PSReadLine
Set-PSReadLineKeyHandler -Chord "'",'"' `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
      param($key, $arg)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState(
	  [ref]$line, [ref]$cursor)
      if ($line[$cursor] -eq $key.KeyChar) {
	  # Just move the cursor
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition(
	      $cursor + 1)
      } else {
	  # Insert matching quotes, move cursor to be in between the quotes
	  [Microsoft.PowerShell.PSConsoleReadLine]::Insert(
	      "$($key.KeyChar)" * 2)
	  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState(
	      [ref]$line, [ref]$cursor)
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition(
	      $cursor - 1)
      }
  }

# Packages/modules (broken)
$github = 'https://github.com/' 
$modulesdir = ($env:XDG_DATA_HOME + '/powershell/Modules/')
$startingdir = get-location

function get-typename {
    param($variable)
    ($variable.gettype()).name
}

function use-module(){
    param([string]$name,
	  [string]$dev = 'powershell',
	  $manifest = "$name.psd1",
	  [scriptblock]$build,
	  [string]$import ,
	  [scriptblock]$if = {return $true})
    if ($if.invoke()) {
	# "loading " + $name # DEBUG
	$remote = $github + ($dev + '/' + $name)
	$local = join-path $modulesdir $name
	if ( $manifest.gettype().name -eq 'Boolean' ) {
	    $absmanifest = join-path $local $manifest
	    $haslocal = (test-path $absmanifest)
	} else {
	    $haslocal = (test-path $local)
	    $nomanifest = $true
	}
	if (!($haslocal)) {
	    "Installing " + $name
	    git clone $remote (join-path $modulesdir $name)
	    if ($build) {
		set-location $local
		$build.invoke()
	    }}
	if ($import) {
	    set-location $local
	    import-module $import
	} elseif (!($nomanifest)) {
	    Import-Module $absmanifest
	}
	set-location $startingdir
    }
}
# posh-git
use-module 'posh-git' `
  -if {$PSVersionTable.PSVersion.Major -lt 6} `
  -dev 'dahlbyk' `
  -manifest 'src/posh-git.psd1'
# unix-completers
use-module 'unixcompleters' `
  -if {$PSVersionTable.PSVersion.Major -ge 6} `
  -manifest 'Microsoft.PowerShell.UnixTabCompletion.psd1' `
  -build {./build.ps1 -Clean} `
  -import './out/Microsoft.PowerShell.UnixTabCompletion/0.5.0/Microsoft.PowerShell.UnixTabCompletion.dll'
use-module 'neofetch' `
  -dev 'dylanaraps' `
  -manifest 'none' `
  -build {make PREFIX=$HOME/.local install}
use-module 'pfetch' `
  -dev 'dylanaraps' `
  -manifest 'none' `
  -build {make PREFIX=$HOME/.local install}

# clear screen
clear
# run fetch based on terminal height
if ($host.ui.RawUI.WindowSize.Width -gt 80) {
    neofetch
} else {
    pfetch
}
[Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()

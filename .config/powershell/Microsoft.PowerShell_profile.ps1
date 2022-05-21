#!/bin/pwsh

# Powershell profile. Runs before entering a normal powershell session, and
# raises the interface from bearable to almost-comfy.

# a bunch of this stuff will be transposed from the zsh stuff...

if ($IsLinux) {
    # startup redirection
    switch -regex ($env:TMUX) {
	(".*") {$env:OLDTERM = $env:TERM}
	default {
	    switch -regex ($env:TERM) {
		(alacritty|eterm*|xterm-*) {}
		(linux) {
		    switch (tty) {
			("/dev/tty5") { & startx $env:XINITRC }
			("/dev/tty7") { & sway; exit }
			default {sudo loadkeys "$env:XDG_DATA_HOME/imports/caps.kmap"}}}
		default {$env:OLDTERM = $env:TERM ; & tmux ; exit}
	    }
	}
    }
    # environment fixes
    $env:XDG_DATA_HOME = "$env:HOME/.local/share"
    $env:PATH = "$env:HOME/.local/bin/:" + $env:PATH
}

# default settings from the writer of PSReadLine
# . $env:HOME/.local/share/powershell/Modules/psreadline/PSReadLine/SamplePSReadLineProfile.ps1 | out-null

# LINUX

# Re-define the prompt() function. A simple imitation of my p10k config.
function Prompt(){
    write-host ($pwd.path -replace ($home).replace('\','\\'),'~') `
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
    PredictionSource = 'history'
}

set-psreadlineoption @PSReadlineOptions

# zsh-like interactive array completion. Very not-perfect.
Set-PSReadLineKeyHandler -chord tab -function MenuComplete

# history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Electric pairs-- copied from https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/SamplePSReadLineProfile.ps1
#region Smart Insert/Delete

# The next four key handlers are designed to make entering matched quotes
# parens, and braces a nicer experience.  I'd like to include functions
# in the module that do this, but this implementation still isn't as smart
# as ReSharper, so I'm just providing it as a sample.
Set-PSReadLineKeyHandler -Chord "'",'"' `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
      param($key, $arg)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
      if ($line[$cursor] -eq $key.KeyChar) {
	  # Just move the cursor
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      }
      else {
	  # Insert matching quotes, move cursor to be in between the quotes
	  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
	  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
      }
  }

Set-PSReadLineKeyHandler -Key '(','{','[' `
  -BriefDescription InsertPairedBraces `
  -LongDescription "Insert matching braces" `
  -ScriptBlock {
      param($key, $arg)
      $closeChar = switch ($key.KeyChar) {
	  <#case#> '(' { [char]')'; break }
	  <#case#> '{' { [char]'}'; break }
	  <#case#> '[' { [char]']'; break }
      }
      $selectionStart = $null
      $selectionLength = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
      if ($selectionStart -ne -1) {
	  # Text is selected, wrap it in brackets
	  [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
      } else {
	  # No text is selected, insert a pair
	  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      }
  }

Set-PSReadLineKeyHandler -Key ')',']','}' `
  -BriefDescription SmartCloseBraces `
  -LongDescription "Insert closing brace or skip" `
  -ScriptBlock {
      param($key, $arg)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
      if ($line[$cursor] -eq $key.KeyChar) {
	  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      } else {
	  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
      }
  }

Set-PSReadLineKeyHandler -Key Backspace `
  -BriefDescription SmartBackspace `
  -LongDescription "Delete previous character or matching quotes/parens/braces" `
  -ScriptBlock {
      param($key, $arg)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
      if ($cursor -gt 0) {
	  $toMatch = $null
	  if ($cursor -lt $line.Length) {
	      switch ($line[$cursor]) {
		  <#case#> '"' { $toMatch = '"'; break }
		  <#case#> "'" { $toMatch = "'"; break }
		  <#case#> ')' { $toMatch = '('; break }
		  <#case#> ']' { $toMatch = '['; break }
		  <#case#> '}' { $toMatch = '{'; break }
	      }
	  }
	  if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch) {
	      [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
	  } else {
	      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
	  }
      }
  }

# endregion Smart Insert/Delete

# Broken - hjkl tab-completion maybe?
# Set-PSReadLineKeyHandler -chord 'j' `
  #   -BriefDescription MenuViDown `
  #   -LongDescription "Go down in the tab-complete menu" `
  #   -ScriptBlock {
#       param($key, $arg)
#       $line = $null
#       $cursor = $null
#       [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState(
# 	  [ref]$line, [ref]$cursor)
#       if ( )
#   }

# Packages/modules (broken)
$github = 'https://github.com/' 
$modulesdir = ($env:XDG_DATA_HOME + '/powershell/Modules/')
$startingdir = get-location

# function get-typename {
#     param($variable)
#     ($variable.gettype()).name
# }

function use-module(){
    param([string]$name,
	  [string]$dev = 'powershell',
	  $manifest = "$name.psd1",
	  [string]$import ,
	  [scriptblock]$build,
	  [scriptblock]$if = {return $true},
	  $init = {})
    if ($if.invoke()) {
	# "loading " + $name # DEBUG
	$remote = $github + ($dev + '/' + $name)
	$local = join-path $modulesdir $name
	set-location $local
	if ( $manifest.gettype().name -eq 'Boolean' ) {
	    $absmanifest = join-path $local $manifest
	    $haslocal = (test-path $absmanifest)
	} else {
	    $haslocal = (test-path $local)
	    $nomanifest = $true}
	if (!($haslocal)) {
	    "Installing " + $name
	    git clone $remote (join-path $modulesdir $name)
	    if ($build) {
		# set-location $local
		$build.invoke()
	    }}
	if ($import) {
	    import-module $import
	} elseif (!($nomanifest)) {
	    Import-Module $absmanifest}
	$init.invoke()
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
  -if {! $IsWindows} `
  -dev 'dylanaraps' `
  -manifest 'none' `
  -build {make PREFIX=$HOME/.local install}
use-module 'pfetch' `
  -if {! $IsWindows} `
  -dev 'dylanaraps' `
  -manifest 'none' `
  -build {make PREFIX=$HOME/.local install}
use-module 'psreadline' `
  -manifest 'PSReadLine/PSReadLine.psd1'

# clear screen if it looks cool
if ($host.ui.RawUI.WindowSize.Height -lt 50) {
    clear}
# run fetch based on terminal height
if ($host.ui.RawUI.WindowSize.Width -gt 80) {
    neofetch
} else {
    pfetch}

[Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()

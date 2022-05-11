#!/bin/pwsh

# Powershell profile. Runs before entering a normal powershell session, and
# raises the interface from bearable to almost-comfy.

# a bunch of this stuff will be transposed from the zsh stuff...

switch ($env:TTY) {
    ("/dev/tty5") {startx $env:XINITRC}
    ("/dev/tty7") {& sway; exit}
    default {}
}

switch -regex ($env:TMUX) {
    (*) {$env:OLDTERM = $env:TERM}
    default {
	switch -regex ($env:TERM) {
	    (alacritty|eterm*|xterm-*) {}
	    default {$env:OLDTERM = $env:TERM ; & tmux ; exit}
	}
    }
}

# Re-define the prompt() function. A simple imitation of my p10k config.
function Prompt(){
    write-host ((get-location).path -replace (($home).replace('\','/')),'~') `
      -foregroundcolor darkblue #-nonewline
    switch ($lastexitcode) {
	(0) {$color = "darkgreen"}
	default {$color = "darkred"}
    }
    # & $GitPromptScriptBlock
    $directprompt = write-host ">" -foregroundcolor $color -nonewline
    return " "
}

# Vi-style line editing. Pretty good but no visual mode.
Set-PSReadLineOption -ViModeIndicator 'cursor'
set-psreadlineOption -editmode vi

# zsh-like interactive array completion. Very not-perfect.
Set-PSReadLineKeyHandler -chord tab -function MenuComplete

# Packages/modules (broken)
# Install-Module PSUnixUtilCompleters
# Import-Module '/home/mitch/.local/share/powershell/Modules/posh-git/1.1.0/posh-git.psd1'

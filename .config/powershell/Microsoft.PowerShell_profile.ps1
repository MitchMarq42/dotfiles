#!/bin/pwsh

# Powershell profile. Runs before entering a normal powershell session, and
# raises the interface from bearable to almost-comfy.

# Re-define the prompt() function. A simple imitation of my p10k config.
function Prompt(){
    write-host ((get-location).path -replace "$home",'~') -foregroundcolor darkblue
    switch ($lastexitcode) {
	(0) {$color = "darkgreen"}
	default {$color = "darkred"}
    }
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

function make-promptpath(){
    $location = get-location
    write-host ($location.path -replace "$home",'~') -foregroundcolor darkblue
}
function color-promptstr(){
    param([string]$promptstr = ">")
    switch ($lastexitcode) {
	(0) {$color = "green"}
	default {$color = "darkred"}
    }
    $directprompt = write-host $promptstr -foregroundcolor $color -nonewline
}
function Prompt(){
    make-promptpath
    color-promptstr ">"
    return " "
}

# Vi mode, with pretty cursor manipulation
# from https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption `
  -ViModeIndicator 'cursor'
set-psreadlineOption -editmode vi

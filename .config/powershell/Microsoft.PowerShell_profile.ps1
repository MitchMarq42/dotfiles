function Prompt(){
    "" + (Get-Location) + [environment]::newline + "> "
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
  -ViModeIndicator Script `
  -ViModeChangeHandler $Function:OnViModeChange
set-psreadlineOption -editmode vi

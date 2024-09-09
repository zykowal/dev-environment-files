# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# posh-git
Import-Module posh-git

# oh-my-posh
# https://ohmyposh.dev/docs
$omp_config = Join-Path $PSScriptRoot ".\xxx.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# terminal-icons
Import-Module -Name Terminal-Icons

# PSReadLine
# Get-Module PSReadLine -> check load PSReadLine status
# Install-Module -Name PSReadLine -Scope CurrentUser
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+u' -Function DeleteLine
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias -Name vim -Value nvim

# which command like Unix
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

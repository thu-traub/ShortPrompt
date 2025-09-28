<#
.SYNOPSIS
A simple shortened prompt for powershell. 
.NOTES
A simple shortened prompt for powershell. 
It can also display the current Git branch.
The prompt is cut in length. The length is given by $global:PromptLength.
If $global:PromptGit is set to $true, it displays the current git branch.
If $global:PromptSyncCD ist set to $true, it syncronized powershell's 
current-location with windows current directory.
If $global:ColorPrompt is set to true, the prompt symbol is displayed in color.

Author: S. Traub
#>
function prompt() { 
    $l = (Get-Location).Path
    $cut = $false
    while (($l.Length -ge $global:PromptLength) -and ($l.IndexOf("\") -gt 0)) {
        $cut = $true
        $l = $l.Substring($l.IndexOf("\")+1)
    }
  
    if ($cut) {
        $l = "...\"+$l
    }
  
    if ($global:PromptSyncCD) {
      [System.IO.Directory]::SetCurrentDirectory((Get-Location).Path)
    }

    if ($global:PromptGit) {
      $gitpresent = $false
      $cl = (Get-Location)
      while (-not ([String]::IsNullOrEmpty($cl)) ) {
        if (Test-Path "$cl\.git") { $gitpresent=$true; break }
        $cl = Split-Path $cl -Parent
      }

      if ($gitpresent) {
        $headpath = "$cl/.git/HEAD"
        if (Test-Path $headpath) {
          $head = Get-Content $headpath
          if ($head -match "refs/heads/(.*)") {
            $branch = $matches[1]
          } else {
            $branch = "DETACHED"
          }
        } else {
          $branch = "???"
        }
        $l = $l + " ($branch)"
      }

    }

    if ($global:PromptSyncCD) {
      $e=[char]27
      $pr=[convert]::ToChar(187)
      if ($ColorPrompt) {
        if ($PSVersionTable.PSEdition -eq "Core") {
          $col = "$e[32m$pr$e[0m"
        } else {
          $col = "$e[94m$pr$e[0m"
        }
      } else {
        $col = $pr
      }
      "$l$col "
      $host.ui.RawUI.WindowTitle = (Get-Location)
    } else {
      "$l> "
      $host.ui.RawUI.WindowTitle = (Get-Location).Path + " | " + ([System.IO.Directory]::GetCurrentDirectory())
    }
  }

$global:PromptLength=16
$global:PromptSyncCD=$true
$global:PromptGit=$true
$global:ColorPrompt=$true
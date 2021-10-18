<#
.SYNOPSIS
A simple truncated prompt for powershell. 
.NOTES
A simple truncated prompt for powershell. 
It can display the current git branch as well.
The prompt is cut to a specified length. The length is given by $global:PromptLength.
If $global:PromptGit is set to $true, it displays the current git branch as well.
If $global:PromptSyncCD ist set to $true, it syncronizes powershell's 
current-location with windows current directory.

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
        if (Test-Path ".git") { $gitpresent=$true; break }
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
      "$l"+[convert]::ToChar(187)+" "
      $host.ui.RawUI.WindowTitle = (Get-Location)
    } else {
      "$l> "
      $host.ui.RawUI.WindowTitle = (Get-Location).Path + " | " + ([System.IO.Directory]::GetCurrentDirectory())
    }
  }

$global:PromptLength=16
$global:PromptSyncCD=$true
$global:PromptGit=$true

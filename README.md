# ShortPrompt

Create a truncated prompt for powershell.

Example:

    ...\hsu\projects»

It can display the current git branch as well.

    ...\hsu\projects (master)»

It can synchronize windows "current directory" with powershells "current-location".

To use it, simple source it:

    . ./prompt.ps1

To enable it for all windows:

Copy `prompt.ps1` to your powershell users directory, typically `C:\Users\yourname\Documents\WindowsPowerShell`.


Add this line to your profile `profile.ps1`.

    . $PSScriptRoot\prompt.ps1

If `profile.ps1` does not exists, create it.
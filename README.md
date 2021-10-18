# ShortPrompt

Create a truncated prompt for powershell.

Example:

    ...\hsu\projects»

If can display the current git branch as well.

    ...\hsu\projects (master)»

To use it, simple source it:

    . ./prompt.ps1

To enable it for all windows:

Copy `prompt.ps1` to your powershell users directory, typically `C:\Users\yourname\Documents\WindowsPowerShell`.


Add this line to your profile `profile.ps1`.

    . $PSScriptRoot\prompt.ps1

If `profile.ps1` does not exists, create it.
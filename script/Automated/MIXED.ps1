# 🤔 Mixed - Uncategorized
slmgr /ato # Forces a Windows activation check
# takeown /r /a /d y /f $env:SystemDrive\Windows.old # Takes permissions before deleting old Windows, risky
Remove-Item -Path $env:SystemDrive\Windows.old -Recurse -Force # Removes old Windows data

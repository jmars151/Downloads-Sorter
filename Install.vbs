Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

' Define paths
strAppPath = objShell.ExpandEnvironmentStrings("%LOCALAPPDATA%\DownloadsSorter")
strDesktop = objShell.SpecialFolders("Desktop")
strSource = objShell.CurrentDirectory

' Create app folder
If Not objFSO.FolderExists(strAppPath) Then
    objFSO.CreateFolder(strAppPath)
End If

' Copy files
objFSO.CopyFile strSource & "\Sort-Downloads.exe", strAppPath & "\", True
objFSO.CopyFile strSource & "\Sort-Downloads.ps1", strAppPath & "\", True

' Create shortcut
Set objShortcut = objShell.CreateShortcut(strDesktop & "\Downloads Sorter.lnk")
objShortcut.TargetPath = strAppPath & "\Sort-Downloads.exe"
objShortcut.WorkingDirectory = strAppPath
objShortcut.Description = "Run the Downloads Sorter"
objShortcut.Save

MsgBox "Downloads Sorter installed successfully! A shortcut has been created on your desktop.", 64, "Installation Complete"

[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=
DisplayLicense=
FinishMessage=Sort Downloads Complete!
TargetName=C:\Users\jmars\DownloadsSorter\Sort-Downloads.exe
FriendlyName=Downloads Sorter
AppLaunched=powershell.exe -ExecutionPolicy Bypass -File .\Sort-Downloads.ps1
PostInstallCmd=<None>
[SourceFiles]
SourceFiles0=C:\Users\jmars\DownloadsSorter\
[SourceFiles0]
%File0%=
[Strings]
File0=Sort-Downloads.ps1

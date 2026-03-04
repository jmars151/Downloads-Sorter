$Downloads = "$env:USERPROFILE\Downloads"
$LogFile = Join-Path $Downloads "SortDownloads.log"

"--- Run at $(Get-Date) ---" | Out-File $LogFile -Append

# Ensure base folders exist
$folders = @("Installers", "Documents", "Media", "Archives", "Temporary", "To Review")
foreach ($f in $folders) {
    $path = Join-Path $Downloads $f
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        "Created folder: $path" | Out-File $LogFile -Append
    }
}

# Installer destination (D:\Installers if D: exists)
if (Test-Path "D:\") {
    $InstallerDest = "D:\Installers"
    if (-not (Test-Path $InstallerDest)) {
        New-Item -ItemType Directory -Path $InstallerDest | Out-Null
        "Created D-drive installer folder: $InstallerDest" | Out-File $LogFile -Append
    }
    "Using D-drive for installers." | Out-File $LogFile -Append
} else {
    $InstallerDest = Join-Path $Downloads "Installers"
    "D-drive not found. Using Downloads\Installers." | Out-File $LogFile -Append
}

# Helper function
function Move-And-Log {
    param (
        [string]$Pattern,
        [string]$Destination
    )

    $files = Get-ChildItem -Path $Downloads -Filter $Pattern -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        Move-Item $file.FullName $Destination -Force -ErrorAction SilentlyContinue
        "Moved: $($file.Name) -> $Destination" | Out-File $LogFile -Append
    }
}

# Installers
Move-And-Log "*.exe" $InstallerDest
Move-And-Log "*.msi" $InstallerDest
Move-And-Log "*.iso" $InstallerDest
Move-And-Log "*.img" $InstallerDest
Move-And-Log "*.apk" $InstallerDest

# Documents
$DocDest = "$Downloads\Documents"
Move-And-Log "*.pdf" $DocDest
Move-And-Log "*.docx" $DocDest
Move-And-Log "*.xlsx" $DocDest
Move-And-Log "*.pptx" $DocDest
Move-And-Log "*.ppt" $DocDest
Move-And-Log "*.csv" $DocDest
Move-And-Log "*.json" $DocDest
Move-And-Log "*.xml" $DocDest
Move-And-Log "*.rtf" $DocDest
Move-And-Log "*.txt" $DocDest

# Media
$MediaDest = "$Downloads\Media"
Move-And-Log "*.jpg" $MediaDest
Move-And-Log "*.jpeg" $MediaDest
Move-And-Log "*.png" $MediaDest
Move-And-Log "*.gif" $MediaDest
Move-And-Log "*.bmp" $MediaDest
Move-And-Log "*.webp" $MediaDest
Move-And-Log "*.mp4" $MediaDest
Move-And-Log "*.mp3" $MediaDest
Move-And-Log "*.wav" $MediaDest
Move-And-Log "*.mov" $MediaDest
Move-And-Log "*.avi" $MediaDest

# Archives
$ArchiveDest = "$Downloads\Archives"
Move-And-Log "*.zip" $ArchiveDest
Move-And-Log "*.rar" $ArchiveDest
Move-And-Log "*.7z" $ArchiveDest
Move-And-Log "*.tar" $ArchiveDest
Move-And-Log "*.gz" $ArchiveDest
Move-And-Log "*.bz2" $ArchiveDest
Move-And-Log "*.xz" $ArchiveDest

# Code / Config
# Move-And-Log "*.ps1" "$Downloads\To Review"
Move-And-Log "*.py" "$Downloads\To Review"
Move-And-Log "*.js" "$Downloads\To Review"
Move-And-Log "*.html" "$Downloads\To Review"
Move-And-Log "*.css" "$Downloads\To Review"
Move-And-Log "*.bat" "$Downloads\To Review"
Move-And-Log "*.reg" "$Downloads\To Review"

# Torrents
Move-And-Log "*.torrent" "$Downloads\To Review"

# Auto-clean Temporary (older than 14 days)
$TempFolder = Join-Path $Downloads "Temporary"
$OldFiles = Get-ChildItem $TempFolder -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-14) }

foreach ($file in $OldFiles) {
    Remove-Item $file.FullName -Force
    "Deleted old temp file: $($file.Name)" | Out-File $LogFile -Append
}

"Cleanup complete." | Out-File $LogFile -Append
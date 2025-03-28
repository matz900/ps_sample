<####################################################################
.SYNOPSIS
SecureString sample
.DESCRIPTION
sample.
.NOTES
Version: 0.1
Date: 2025-02-16
Author: matz900
.NOTES
ps2exe .\src\SecureString.ps1 .\bin\SecureString.exe -title 'Secure-String test'
#####################################################################>
# -----------------------------------------------------------------------------
# Assemblies
# -----------------------------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms

# -----------------------------------------------------------------------------
# Const
# -----------------------------------------------------------------------------
# Return Code
$RET_NORMAL = 0
$RET_ERROR = 1
# TempDir
#$TEMP_DIR = "C:\windows\temp"
# SleepTime
$SleepSec = 300

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------
# BaseDir
#$BaseDir = "${home}\Desktop"

# Credential
$ExecUser = ""
$ExecPswd  = ""

# -----------------------------------------------------------------------------
# FileHash 
# -----------------------------------------------------------------------------
$FileChooser = New-Object System.Windows.Forms.OpenFileDialog

$FileChooser.Filter = "All Files|*.*"
$FileChooser.Multiselect = $false
$FileChooser.Title = "select file to get filehash"

if ($FileChooser.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    $TargetFilePath = ""
    $TargetFileHash = ""
    $FileChooser.Dispose()
    #exit $RET_NORMAL
} else {
    $TargetFilePath = $FileChooser.FileName
    $TargetFileHash = (Get-FileHash $TargetFilePath -Algorithm SHA256).Hash
    $FileChooser.Dispose()
}

# -----------------------------------------------------------------------------
# Credential
# -----------------------------------------------------------------------------
$Cred = Get-Credential -Message "input credential to encode."

[byte[]] $EncKeyB = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32)

$ExecUser = $Cred.UserName
$EncPswd = ConvertFrom-SecureString -SecureString $Cred.Password -Key $EncKeyB

$ConvPswd = ConvertTo-SecureString -String $EncPswd -Key $EncKeyB
$BytePswd = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ConvPswd)
$ExecPswd = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BytePswd)

Write-Host "--- Result ----------------------"
Write-Host "FilePath : ${TargetFilePath}"
Write-Host "FileHash : ${TargetFileHash}"
Write-Host "ExecUser : ${ExecUser}"
Write-Host "ExecPswd : ${ExecPswd}"
Write-Host "EncPswd  : ${EncPswd}"
Write-Host "EncKey   : ${EncKeyB}"
Write-Host "---------------------------------"

# sleep
Start-Sleep -Seconds $SleepSec

exit $RET_NORMAL
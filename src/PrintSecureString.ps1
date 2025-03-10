<####################################################################
.SYNOPSIS
SecureString sample 2
.DESCRIPTION
sample.
.NOTES
Version: 0.1
Date: 2025-02-16
Author: matz900
.NOTES
ps2exe .\src\PrintSecureString.ps1 .\bin\PrintSecureString.exe -title 'Secure-String test2'
#####################################################################>
# -----------------------------------------------------------------------------
# Assemblies
# -----------------------------------------------------------------------------
#Add-Type -AssemblyName System.Windows.Forms

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
$ExecPswd  = ""

# -----------------------------------------------------------------------------
# Credential
# -----------------------------------------------------------------------------

$DummyUsr = "Dummy"
[byte[]] $EncKeyB = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32)

$EncPswd = Read-Host "input Encrypted Password String."

$ConvPswd = ConvertTo-SecureString -String $EncPswd -Key $EncKeyB
$BytePswd = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ConvPswd)
$ExecPswd = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BytePswd)

$Cred = New-Object System.Management.Automation.PsCredential $DummyUsr, $ConvPswd

Write-Host "--- Result ----------------------"
Write-Host "ExecUser : "($Cred.UserName)
Write-Host "ExecPswd : ${ExecPswd}"
Write-Host "EncPswd  : ${EncPswd}"
Write-Host "EncKey   : ${EncKeyB}"
Write-Host "---------------------------------"



# sleep
Start-Sleep -Seconds $SleepSec

exit $RET_NORMAL
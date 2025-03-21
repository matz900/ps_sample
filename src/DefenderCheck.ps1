<####################################################################
.SYNOPSIS
Microsoft Defender Checksample
.DESCRIPTION
sample.
.NOTES
Version: 0.1
Date: 2025-03-15
Author: matz900
.NOTES
ps2exe .\src\DefenderCheck.ps1 .\bin\DefenderCheck.exe -title 'Get-MpComputerStatus test'
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
#$SleepSec = 300

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------
# BaseDir
#$BaseDir = "${home}\Desktop"

# Credential
#$ExecUser = ""
#$ExecPswd  = ""

$DefenderVersions = @{
      AntispywareSignatureVersion = "1.425.53.0"
    ; AntivirusSignatureVersion = "1.425.53.0"
    ; RealTimeProtectionEnabled = "True"
    ; AntispywareEnabled = "True"
    ; AntiVirusEnabled = "True"
}

# -----------------------------------------------------------------------------
# FileHash 
# -----------------------------------------------------------------------------
$DefenderStatusAll = Get-MpComputerStatus

$ValAntiSpywaresignatureLastUpdated = $DefenderStatusAll.AntispywareSignatureLastUpdated
$ValAntiVirusSignatureLastUpdated = $DefenderStatusAll.AntivirusSignatureLastUpdated

$TotalStat = $true
foreach($key in $DefenderVersions.Keys) {
    $val = $DefenderVersions[$key]
    $stat = $false
    foreach($DefenderStatus in $DefenderStatusAll) {
        if($DefenderStatus.$key -eq $val) {
            $stat = $true
            Write-Host "Defender Status OK : ${key} = ${val} , $ValAntiSpywaresignatureLastUpdated, $ValAntiVirusSignatureLastUpdated"
            break
        }
    }
    if($stat -eq $false) {
        Write-Host "Defender Status NG : ${key} = ${val}"
    }
    $TotalStat = $TotalStat -and $stat
}

Write-host "TotalStat : $TotalStat"

exit $RET_NORMAL
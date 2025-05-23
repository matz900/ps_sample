###############################################################################
# アプリケーションバージョン取得
#  Set-ExecutionPolicy bypass -Scope Process
#  ps2exe .\hoge2applist.ps1 .\hoge2applist.exe -title 'exec test'
###############################################################################

# -----------------------------------------------------------------------------
# 定数設定
# -----------------------------------------------------------------------------
# リターンコード
$RET_NORMAL = 0  #正常
$RET_ERROR = 1   #異常
$VSCODE_STR = 'Visual Studio Code'
# -----------------------------------------------------------------------------
# 変数設定
# -----------------------------------------------------------------------------

# 当日年月日時分秒
$ymdhms = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

# スリープ時間(秒)
$SleepSec = 60

# 出力ファイル
$OutFile = ".\hoge.csv"

# 検索アプリ文字列
$TargetApps = @(
    'Microsoft Edge',
    'Visual C++ 2015-2022',
    'Adobe Acrobat',
    'TortoiseSVN',
    $VSCODE_STR
)

$VSCodeFlag = $false
$TargetVSCodeExts = @{
      "ms-vscode.powershell" = "2025.0.0"
    ; "ms-vscode.csharp" = "2025.0.0" 
}

# -----------------------------------------------------------------------------
# 事前チェック
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# 情報取得・出力実行
# -----------------------------------------------------------------------------

# 処理開始メッセージ
Write-Output "アプリ情報検索・出力開始 ${ymdhms}"

# ユーザー情報取得
$DomainName = $env:userdomain
$UserName = $env:username
$FullName = ([adsi]"WinNT://${DomainName}/${UserName},user").fullname
$ComName = $env:COMPUTERNAME

$UserInfoCSV = "`"${ymdhms}`",`"${ComName}`",`"${UserName}`",`"${FullName}`""

# ユーザー情報表示
Write-Output "ユーザー情報： ${UserName}`t${FullName}`t${ComName}"
Write-Output ""

# アプリケーションリスト取得
try {
    $AppList = Get-ChildItem -Path(
        'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
        'HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
        'HKLM:SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall') |
        ForEach-Object { Get-ItemProperty $_.PsPath |
        Select-Object DisplayName, DisplayVersion, InstallDate }
} catch [Exception] {
    Write-Output "アプリケーションリストの取得に失敗しました。`n" + $PSItem.Exception.Message
    Exit $RET_ERROR
}

# 出力ファイルチェック 既存ファイル削除
if ((Test-Path $OutFile) -eq $True) {
    Remove-Item $OutFile
}

# アプリ情報検索・出力
Foreach ($TargetApp in $TargetApps) {
    # TargetAppヒットフラグ
    $HitFlag = $false

    Foreach ($App in $AppList) {
        if (($App.DisplayName | Select-String -SimpleMatch ${TargetApp}).Length -gt 0) {
            $HitFlag = $true
            if ($TargetApp.Contains($VSCODE_STR) ){
                $VSCodeFlag = $true
            }    
            [string]$Dname = ${App}.DisplayName
            [string]$Dver = ${App}.DisplayVersion
            [string]$Idate = ${App}.InstallDate
            Write-Output "${Dname}`t`t${Dver}`t`t${Idate}"
            Write-Output "${UserInfoCSV},`"${TargetApp}`",`"${Dname}`",`"${Dver}`",`"${Idate}`"" >> $OutFile
        }
    }

    if (-not $HitFlag) {
        Write-Output "${TargetApp}はインストールされていません。"
        Write-Output "${UserInfoCSV},`"${TargetApp}`",`"`",`"`",`"`"" >> $OutFile
    }
}

# VSCode Extcheck
Write-Output "`n----- ${VSCODE_str} extension check -----"
if($VSCodeFlag) {
    $CodeExtentions = code --list-extensions --show-versions
    foreach ($CodeExt in $TargetVSCodeExts.Keys) {
        $HitFlag = $false

        foreach ($CodeExtIn in $CodeExtentions) {
            if ($CodeExtIn.Contains($CodeExt)) {
                $HitFlag = $true
                $ExtName = $CodeExtIn.Split('@')[0]
                $ExtVer = $CodeExtIn.Split('@')[1]
                if ($TargetVSCodeExts[$CodeExt] -ne $ExtVer) {
                    Write-Output "${ExtName}のバージョンが異なります。"
                    Write-Output "${UserInfoCSV},`"${CodeExt}`",`"${ExtName}`",`"${ExtVer}`",`"`"" >> $OutFile
                } else {
                    Write-Output "${ExtName}`t`t${ExtVer}"
                    Write-Output "${UserInfoCSV},`"${CodeExt}`",`"${ExtName}`",`"${ExtVer}`",`"`"" >> $OutFile
                }
            }
        }
        if (-not $HitFlag) {
            Write-Output "${CodeExt}はインストールされていません。"
            Write-Output "${UserInfoCSV},`"${CodeExt}`",`"`",`"`",`"`"" >> $OutFile
        }
    }
}

# -----------------------------------------------------------------------------
# 終了処理
# -----------------------------------------------------------------------------
# 当日年月日時分秒
$ymdhms = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

# 終了メッセージ
Write-Output ""
Write-Output "アプリ情報検索・出力終了 ${ymdhms}"
Write-Output ""
Write-Output "このウィンドウを閉じてください。"
#Write-Output "※ ${SleepSec} 秒後に自動でウィンドウを閉じます。"

#Get-Content $outFile
#Start-Sleep -Seconds $SleepSec

exit $RET_NORMAL
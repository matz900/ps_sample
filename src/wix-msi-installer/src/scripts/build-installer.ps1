# FILE: /wix-msi-installer/wix-msi-installer/src/scripts/build-installer.ps1
# This script builds the MSI installer using WiX Toolset

# Define the path to the WiX Toolset candle and light executables
$candlePath = "C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe"
$lightPath = "C:\Program Files (x86)\WiX Toolset v3.11\bin\light.exe"

# Define the path to the .wxs file and output directory
$wxsFile = "..\wix\sample.wxs"
$outputDir = "..\output"

# Create output directory if it doesn't exist
if (-Not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir
}

# Compile the .wxs file to .wixobj
& $candlePath $wxsFile -o "$outputDir\sample.wixobj"

# Link the .wixobj file to create the .msi installer
& $lightPath "$outputDir\sample.wixobj" -o "$outputDir\SampleProduct.msi"

Write-Host "MSI Installer has been created at $outputDir\SampleProduct.msi"

<#
# filepath: /c:/work/vmshare/workspace/wix-msi-installer/build.ps1
# WiX ツールセットのパスを設定
$wixPath = "C:\Program Files (x86)\WiX Toolset v3.11\bin"

# ソースファイルと出力ファイルのパスを設定
$sourceFile = "c:\work\vmshare\workspace\wix-msi-installer\Product.wxs"
$wixObjFile = "c:\work\vmshare\workspace\wix-msi-installer\Product.wixobj"
$msiFile = "c:\work\vmshare\workspace\wix-msi-installer\Product.msi"

# Candle.exe を使用して .wxs ファイルをコンパイル
& "$wixPath\candle.exe" -out $wixObjFile $sourceFile

# Light.exe を使用して .wixobj ファイルをリンクし、MSI ファイルを生成
& "$wixPath\light.exe" -out $msiFile $wixObjFile
#>


<#
cd c:\work\vmshare\workspace\wix-msi-installer
.\build.ps1
#>
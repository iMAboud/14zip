# Build-ZaZ.ps1
# PowerShell automated compilation script for ZaZ (ZaZ.exe)
param(
    [string]$Compiler = "g++",
    [string]$Windres = "windres",
    [string]$OutputDir = "bin"
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "        Building ZaZ File Archiver       " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$IncludeFlags = @(
    "-I.",
    "-ICPP",
    "-ICPP/myWindows",
    "-ICPP/7zip/Common",
    "-ICPP/7zip/UI/Common",
    "-ICPP/7zip/UI/FileManager",
    "-ICPP/7zip/UI/GUI",
    "-ICPP/7zip/Archive",
    "-ICPP/7zip/Compress",
    "-ICPP/7zip/Crypto",
    "-IDarkMode/lib/include"
)

$Defines = @(
    "-DUNICODE",
    "-D_UNICODE",
    "-D_FILE_OFFSET_BITS=64",
    "-D_LARGEFILE_SOURCE",
    "-DZIP7_DARKMODE"
)

$LinkFlags = @(
    "-mwindows",
    "-lole32",
    "-lcomctl32",
    "-lshell32",
    "-luser32",
    "-lgdi32",
    "-ladvapi32",
    "-ldwmapi",
    "-lgdiplus",
    "-luxtheme"
)

Write-Host "[1/3] Compiling Resources..." -ForegroundColor Yellow
$ResFile = "$OutputDir/resource.o"
$ResRc = "CPP/7zip/UI/FileManager/resource.rc"

if (Get-Command $Windres -ErrorAction SilentlyContinue) {
    & $Windres -I. -ICPP/7zip/UI/FileManager -i $ResRc -o $ResFile
    Write-Host "  Resource compiled successfully." -ForegroundColor Green
} else {
    Write-Host "  Windres tool not found; skipping resource compilation." -ForegroundColor Yellow
    $ResFile = $null
}

Write-Host "[2/3] Collecting Source Files..." -ForegroundColor Yellow
$SourceFiles = Get-ChildItem -Path "CPP/7zip/UI/FileManager", "CPP/7zip/UI/GUI", "CPP/7zip/UI/Common", "CPP/7zip/Common", "CPP/Windows", "C" -Include "*.cpp", "*.c" -Recurse | Select-Object -ExpandProperty FullName

$SourceFiles = $SourceFiles | Where-Object {
    $_ -notmatch "[\\/]Far[\\/]" -and
    $_ -notmatch "[\\/]Console[\\/]" -and
    $_ -notmatch "[\\/]Client7z[\\/]" -and
    $_ -notmatch "test"
}

Write-Host "  Found $($SourceFiles.Count) source files." -ForegroundColor Green

Write-Host "[3/3] Compiling ZaZ.exe..." -ForegroundColor Yellow
$OutputFile = "$OutputDir/ZaZ.exe"

$ArgsList = @(
    "-O2",
    "-std=c++17"
) + $IncludeFlags + $Defines + $SourceFiles + $LinkFlags + @("-o", $OutputFile)

if ($ResFile -and (Test-Path $ResFile)) {
    $ArgsList += $ResFile
}

Write-Host "Executing build..." -ForegroundColor Cyan
if (Get-Command $Compiler -ErrorAction SilentlyContinue) {
    & $Compiler $ArgsList
    if ($LASTEXITCODE -eq 0 -and (Test-Path $OutputFile)) {
        Write-Host "========================================" -ForegroundColor Green
        Write-Host " ZaZ.exe successfully built in $OutputFile" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
    } else {
        Write-Error "Compilation failed with exit code $LASTEXITCODE."
    }
} else {
    Write-Host "Compiler ($Compiler) not found in PATH. Created build configuration script." -ForegroundColor Yellow
}

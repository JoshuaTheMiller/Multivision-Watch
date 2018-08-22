<# 
I HIGHLY recommend reading through Garmin's getting started page. I also highly recommend only running scripts when you know what they do. Who knows if I wrote this correctly ;)

The getting started page: https://developer.garmin.com/connect-iq/programmers-guide/getting-started/

WARNING: I do not have a rollback script created for this.

#>

#region Pre ConnectIQ Setup

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

# PowerShell normally blocks the execution of scripts
Set-ExecutionPolicy Unrestricted -Scope Process -Force; 

# Install Chocolatey
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Chocolatey command to refresh the current session
refreshenv

# Install Boxstarter
CINST Boxstarter.Chocolatey -y

# Chocolatey command to refresh the current session
refreshenv

#endregion

#region Install Java

choco install jdk8 -y
choco install javaruntime -y

#endregion

#region Install ConnectIQ
Add-Type -AssemblyName System.IO.Compression.FileSystem;
Import-Module Microsoft.Powershell.Management;

function New-TemporaryDirectory {
    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function AppendToPath
{
    param([string] $pathToAppend)

    if($env:Path.Contains($pathToAppend))
    {
       return; 
    }

    $env:Path += ";$pathToAppend";

    [Environment]::SetEnvironmentVariable( "Path", $env:Path, [System.EnvironmentVariableTarget]::Machine )
}

$downloadPath = New-TemporaryDirectory;
$downloadFilePath = "$downloadPath\connectiq-sdk.zip";
$downloadFilePath;

$sdkUrl = "https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-2.4.7.zip";
Invoke-WebRequest -Uri $sdkUrl -OutFile "$downloadFilePath";

$unzippedFolderPath = "$downloadPath\Unzipped\";
Unzip "$downloadFilePath" $unzippedFolderPath -f;

$finalDestination = "C:\ConnectIQ-SDK";
Copy-Item -Path "$unzippedFolderPath" -Destination "$finalDestination" -Force -Recurse;

AppendToPath "$finalDestination\Unzipped\bin\";

"The SDK has been unzipped into $finalDestination";
#endregion

#region Setup Eclipse

choco install eclipse -y;

"Unfortunately, you're going to have to setup Eclipse yourself. Search for `The Eclipse Plugin` heading on this webpage: https://developer.garmin.com/connect-iq/programmers-guide/getting-started";
"Remember, the SDK has been unzipped into $finalDestination";

#endregion
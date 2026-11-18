param(
  [string]$AircraftDirectory = (Join-Path $env:USERPROFILE "Documents\FlightGear\Aircraft")
)
$ErrorActionPreference = "Stop"
$SourceDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$TargetDirectory = Join-Path $AircraftDirectory "BloxCraft-Airlines"
New-Item -ItemType Directory -Force -Path $TargetDirectory | Out-Null
Copy-Item -Path (Join-Path $SourceDirectory "*") -Destination $TargetDirectory -Recurse -Force
Write-Host "BC-001 installed to: $TargetDirectory"
Write-Host "Select BloxCraft-Airlines in FlightGear. If needed, add $AircraftDirectory as an aircraft path."
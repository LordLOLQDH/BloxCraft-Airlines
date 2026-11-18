param(
  [string]$AircraftDirectory = (Join-Path $env:USERPROFILE "Documents\FlightGear\Aircraft"),
  [string]$FlightGearRoot = ""
)
$ErrorActionPreference = "Stop"
$SourceDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$TargetDirectory = Join-Path $AircraftDirectory "BloxCraft-Airlines"
New-Item -ItemType Directory -Force -Path $TargetDirectory | Out-Null
Copy-Item -Path (Join-Path $SourceDirectory "*") -Destination $TargetDirectory -Recurse -Force
if ($FlightGearRoot -ne "") {
  $EngineDirectory = Join-Path $FlightGearRoot "Aircraft\Generic\JSBSim\Engines"
  if (-not (Test-Path $EngineDirectory)) {
    throw "JSBSim engine folder not found: $EngineDirectory"
  }
  Copy-Item (Join-Path $SourceDirectory "Engines\BC001-Turbojet.xml") (Join-Path $EngineDirectory "BC001-Turbojet.xml") -Force
  Write-Host "Custom engine installed to: $EngineDirectory"
} else {
  Write-Host "IMPORTANT: Copy Engines\BC001-Turbojet.xml into FG_ROOT\Aircraft\Generic\JSBSim\Engines\"
}
Write-Host "BC-001 installed to: $TargetDirectory"
Write-Host "If FlightGear does not find it, add this directory as an aircraft path: $AircraftDirectory"

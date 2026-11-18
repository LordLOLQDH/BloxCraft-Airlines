# BloxCraft Airlines — BC-001

A deliberately wingless, perfectly cubic FlightGear aircraft.

## Project contents
- 4 m × 4 m × 4 m matte-grey cube fuselage and square front window
- Three square wheels, rear nozzle with silent visual afterburner, landing cushion and parachute
- Nasal keyboard control logic and animated disco lighting
- Initial JSBSim flight-dynamics configuration and custom engine
- Responsive project website in index.html with a live 3D preview parsed from the same Models/bloxcraft.ac file used by FlightGear, plus interactive sound and animation controls
- Windows and Linux installation scripts

## Website
GitHub Pages can publish the root index.html from branch main at:
https://lordlolqdh.github.io/BloxCraft-Airlines/

## Controls
| Key | Action |
|---|---|
| I | Start/stop engine |
| A | Afterburner |
| H | Release wheels |
| G | Deploy landing cushion |
| P | Deploy parachute |
| E | Simulate engine failure and deploy parachute |
| R | Toggle radio/disco mode |

## Installation
Linux: run `bash ./install-linux.sh` and optionally pass your FlightGear user Aircraft directory.
Windows PowerShell: run .\install-windows.ps1 and optionally pass -AircraftDirectory "C:\path\to\FlightGear\Aircraft".

The aircraft-local Engines/ directory contains the custom JSBSim engine file. Keep it alongside BC-001.xml when installing. Select BloxCraft-Airlines in FlightGear.

## Audio
Four supplied audio files are integrated in Sounds/: engine-start.ogg, engine-stop.ogg, engine-loop.ogg and radio-song.ogg. The engine loop plays while the engine is running; the radio track loops in radio/disco mode. No separate afterburner sound is used.

## Development status
Version 0.2 is an experimental development build. The JSBSim file is an initial aerodynamic approximation, not a simulator-validated flight model. The parachute uses the speedbrake drag channel; the wheels and landing cushion currently have visual/control-state behavior only, not fully detachable wheel-body physics or an independently simulated airbag force. The Mach-10-in-10-seconds target is not achieved or validated. FlightGear testing is still required. This is a fictional entertainment aircraft, not a real aircraft.
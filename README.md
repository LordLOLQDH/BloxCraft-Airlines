# BloxCraft Airlines — BC-001

A deliberately wingless, perfectly cubic FlightGear aircraft.

## Project contents
- 4 m × 4 m × 4 m matte-grey cube fuselage and square front window
- Three square wheels, rear nozzle, visual afterburner, landing cushion and parachute
- Nasal keyboard control logic and animated disco lighting
- Initial JSBSim flight-dynamics configuration
- Responsive project website in index.html
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
Linux: run ./install-linux.sh and optionally pass the FlightGear Aircraft directory.
Windows PowerShell: run .\install-windows.ps1 and optionally pass -AircraftDirectory "C:\path\to\FlightGear\Aircraft".

The custom engine definition in Engines/BC001-Turbojet.xml must also be copied into the FlightGear data directory at Aircraft/Generic/JSBSim/Engines/. Then start FlightGear and select BloxCraft-Airlines. If FlightGear uses a different data directory, use its actual FG_ROOT.

## Audio
Exact filenames and export notes are in Sounds/README.txt. The sound configuration is prepared; add the requested OGG files directly to Sounds/.

## Development status
Version 0.2 is an experimental development build. The JSBSim file is an initial aerodynamic approximation, not a simulator-validated flight model. The parachute uses the speedbrake drag channel; the wheels and landing cushion currently have visual/control-state behavior only, not fully detachable wheel-body physics or an independently simulated airbag force. The Mach-10-in-10-seconds target is not achieved or validated. FlightGear testing is still required. This is a fictional entertainment aircraft, not a real aircraft.
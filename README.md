# BloxCraft Airlines — BC-001

A deliberately ridiculous, wingless, perfectly cubic FlightGear aircraft.

## Project

- 4 m × 4 m × 4 m matte-grey cube fuselage with square front window
- Three square wheels, rear engine nozzle and visual afterburner
- Keyboard control logic for engine, afterburner, wheel release, landing cushion, parachute and disco/radio mode
- Website: enable GitHub Pages from the repository root to publish `index.html`

## Website

The repository root contains a responsive project website. With GitHub Pages enabled for branch `main` and folder `/ (root)`, it is published at:

`https://lordlolqdh.github.io/BloxCraft-Airlines/`

## Controls

| Key | Action |
|---|---|
| I | Start/stop engine |
| A | Toggle afterburner |
| H | Drop the three wheels |
| G | Deploy landing cushion |
| P | Deploy parachute |
| E | Simulate engine failure and deploy parachute |
| R | Toggle radio/disco mode |

## Sound files

See [Sounds/README.txt](Sounds/README.txt) for exact filenames and requirements. Sound playback remains unconfigured until the user-provided audio files are available.

## Development status

The 3D cube and the initial Nasal control-state logic are in place. This is still a development build. The current `magic` flight model is a placeholder, not a physical flight model. It does not yet deliver a validated Mach-10 flight profile, true detachable wheel physics, or a physically modelled air-cushion landing. These require a dedicated JSBSim/YASim flight model and simulator testing. Do not treat the BC-001 as a real aircraft.

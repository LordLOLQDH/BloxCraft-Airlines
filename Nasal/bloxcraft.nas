# BloxCraft Airlines BC-001 control module.
var engineOn = 0;
var afterburner = 0;
var wheelsDropped = 0;
var cushionOut = 0;
var cushionPopped = 0;
var parachuteOut = 0;
var discoOn = 0;
var monitorTimer = nil;
var discoTimer = nil;
var discoPhase = 0;

var setState = func(name, value) {
    setprop("/bloxcraft/" ~ name, value);
};
var playOneShot = func(name) {
    var p = "/bloxcraft/sound/" ~ name;
    setprop(p, 0);
    setprop(p, 1);
    settimer(func { setprop(p, 0); }, 0.15);
};

var toggleEngine = func {
    if (engineOn) {
        engineOn = 0;
        afterburner = 0;
        setState("afterburner", 0);
        setprop("/controls/engines/engine[0]/throttle", 0);
        setprop("/controls/engines/engine[0]/starter", 0);
        setprop("/controls/engines/engine[0]/cutoff", 0);
        setState("engine-running", 0);
        setState("engine-state", "OFF");
        playOneShot("engine-stop");
    } else {
        engineOn = 1;
        setprop("/controls/engines/engine[0]/cutoff", 0);
        setprop("/controls/engines/engine[0]/starter", 1);
        setprop("/controls/engines/engine[0]/throttle", 0.20);
        setState("engine-running", 1);
        setState("engine-state", "STARTING");
        setState("engine-failure", 0);
        playOneShot("engine-start");
        settimer(func {
            if (engineOn) {
                setprop("/controls/engines/engine[0]/cutoff", 1);
                setprop("/controls/engines/engine[0]/starter", 0);
                setprop("/controls/engines/engine[0]/throttle", 0.65);
                setState("engine-state", "RUNNING");
            }
        }, 3.0);
    }
};
var toggleAfterburner = func {
    if (!engineOn) { print("BC-001: Start the engines first."); return; }
    afterburner = !afterburner;
    setState("afterburner", afterburner);
    if (afterburner) {
        setprop("/controls/engines/engine[0]/throttle", 1.0);
        setprop("/controls/engines/engine[0]/augmentation", 1);
        playOneShot("afterburner-on");
    } else {
        setprop("/controls/engines/engine[0]/throttle", 0.65);
        setprop("/controls/engines/engine[0]/augmentation", 0);
    }
};
var dropWheels = func {
    if (wheelsDropped) return;
    wheelsDropped = 1;
    setState("wheels-dropped", 1);
    print("BC-001: Wheel assemblies released (visual animation).");
};
var deployCushion = func {
    if (cushionPopped) { print("BC-001: Cushion has popped. Reset the aircraft to repack."); return; }
    if (cushionOut) return;
    cushionOut = 1;
    setState("cushion-deployed", 1);
};
var deployParachute = func {
    if (parachuteOut) return;
    parachuteOut = 1;
    setState("parachute-deployed", 1);
    setprop("/controls/flight/speedbrake", 1);
};
var engineFailure = func {
    engineOn = 0;
    afterburner = 0;
    setState("engine-running", 0);
    setState("engine-failure", 1);
    setState("engine-state", "FAILURE");
    setState("afterburner", 0);
    setprop("/controls/engines/engine[0]/throttle", 0);
    setprop("/controls/engines/engine[0]/starter", 0);
    setprop("/controls/engines/engine[0]/cutoff", 0);
    setprop("/controls/engines/engine[0]/augmentation", 0);
    playOneShot("engine-stop");
    deployParachute();
};
var toggleDisco = func {
    discoOn = !discoOn;
    setState("disco-enabled", discoOn);
    setState("radio-enabled", discoOn);
    if (discoOn) {
        discoPhase = 0;
        discoTimer = settimer(discoTick, 0.25);
    } else {
        if (discoTimer != nil) removetimer(discoTimer);
        discoTimer = nil;
        setState("disco-light-phase", 0);
        setState("bass-pulse", 0);
    }
};
var discoTick = func {
    if (!discoOn) return;
    discoPhase = (discoPhase + 1) % 4;
    setState("disco-light-phase", discoPhase);
    setState("bass-pulse", discoPhase == 0 ? 1 : 0.25);
    discoTimer = settimer(discoTick, 0.25);
};
var monitorLanding = func {
    if (cushionOut and !cushionPopped) {
        var wow0 = getprop("/gear/gear[0]/wow");
        var wow1 = getprop("/gear/gear[1]/wow");
        var wow2 = getprop("/gear/gear[2]/wow");
        if (wow0 or wow1 or wow2) {
            cushionPopped = 1;
            cushionOut = 0;
            setState("cushion-deployed", 0);
            setState("cushion-popped", 1);
            print("BC-001: Landing cushion popped on touchdown.");
        }
    }
    monitorTimer = settimer(monitorLanding, 0.2);
};

setState("engine-running", 0);
setState("engine-failure", 0);
setState("engine-state", "OFF");
setState("afterburner", 0);
setState("wheels-dropped", 0);
setState("cushion-deployed", 0);
setState("cushion-popped", 0);
setState("parachute-deployed", 0);
setState("disco-enabled", 0);
setState("radio-enabled", 0);
setState("disco-light-phase", 0);
setState("bass-pulse", 0);
setState("sound/engine-start", 0);
setState("sound/engine-stop", 0);
setState("sound/afterburner-on", 0);
monitorTimer = settimer(monitorLanding, 0.2);
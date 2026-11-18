# BloxCraft Airlines BC-001 control logic.
# Sounds are triggered through the aircraft sound XML and supplied OGG files.
var BloxCraft = {
    engineOn: 0, afterburner: 0, wheelsDropped: 0,
    cushionOut: 0, cushionPopped: 0, parachuteOut: 0, discoOn: 0,
    monitorTimer: nil, discoTimer: nil, discoPhase: 0
};
BloxCraft.setState = func(name, value) { setprop("/bloxcraft/" ~ name, value); };
BloxCraft.playOneShot = func(name) {
    var p = "/bloxcraft/sound/" ~ name;
    setprop(p, 0); setprop(p, 1);
    settimer(func { setprop(p, 0); }, 0.15);
};
BloxCraft.toggleEngine = func {
    if (BloxCraft.engineOn) {
        BloxCraft.engineOn = 0;
        if (BloxCraft.afterburner) BloxCraft.playOneShot("afterburner-off");
        BloxCraft.afterburner = 0;
        BloxCraft.setState("afterburner", 0);
        setprop("/controls/engines/engine[0]/throttle", 0);
        setprop("/controls/engines/engine[0]/starter", 0);
        BloxCraft.setState("engine-running", 0);
        BloxCraft.setState("engine-state", "OFF");
        BloxCraft.playOneShot("engine-stop");
    } else {
        BloxCraft.engineOn = 1;
        setprop("/controls/engines/engine[0]/starter", 1);
        setprop("/controls/engines/engine[0]/throttle", 0.65);
        BloxCraft.setState("engine-running", 1);
        BloxCraft.setState("engine-state", "RUNNING");
        BloxCraft.setState("engine-failure", 0);
        BloxCraft.playOneShot("engine-start");
    }
};
BloxCraft.toggleAfterburner = func {
    if (!BloxCraft.engineOn) { print("BC-001: Start the engines first."); return; }
    BloxCraft.afterburner = !BloxCraft.afterburner;
    BloxCraft.setState("afterburner", BloxCraft.afterburner);
    if (BloxCraft.afterburner) {
        setprop("/controls/engines/engine[0]/throttle", 1.0);
        setprop("/controls/engines/engine[0]/augmentation", 1);
        BloxCraft.playOneShot("afterburner-on");
    } else {
        setprop("/controls/engines/engine[0]/throttle", 0.65);
        setprop("/controls/engines/engine[0]/augmentation", 0);
    }
};
BloxCraft.dropWheels = func {
    if (BloxCraft.wheelsDropped) return;
    BloxCraft.wheelsDropped = 1;
    BloxCraft.setState("wheels-dropped", 1);
    print("BC-001: Wheel assemblies released (visual animation).");
};
BloxCraft.deployCushion = func {
    if (BloxCraft.cushionPopped) { print("BC-001: Cushion has popped. Reset the aircraft to repack."); return; }
    if (BloxCraft.cushionOut) return;
    BloxCraft.cushionOut = 1;
    BloxCraft.setState("cushion-deployed", 1);
};
BloxCraft.deployParachute = func {
    if (BloxCraft.parachuteOut) return;
    BloxCraft.parachuteOut = 1;
    BloxCraft.setState("parachute-deployed", 1);
    setprop("/controls/flight/speedbrake", 1);
};
BloxCraft.engineFailure = func {
    BloxCraft.engineOn = 0; BloxCraft.afterburner = 0;
    BloxCraft.setState("engine-running", 0);
    BloxCraft.setState("engine-failure", 1);
    BloxCraft.setState("engine-state", "FAILURE");
    BloxCraft.setState("afterburner", 0);
    setprop("/controls/engines/engine[0]/throttle", 0);
    setprop("/controls/engines/engine[0]/starter", 0);
    setprop("/controls/engines/engine[0]/augmentation", 0);
    BloxCraft.playOneShot("engine-stop");
    BloxCraft.deployParachute();
};
BloxCraft.toggleDisco = func {
    BloxCraft.discoOn = !BloxCraft.discoOn;
    BloxCraft.setState("disco-enabled", BloxCraft.discoOn);
    BloxCraft.setState("radio-enabled", BloxCraft.discoOn);
    if (BloxCraft.discoOn) {
        BloxCraft.discoPhase = 0;
        BloxCraft.discoTimer = settimer(BloxCraft.discoTick, 0.25);
    } else {
        if (BloxCraft.discoTimer != nil) removetimer(BloxCraft.discoTimer);
        BloxCraft.discoTimer = nil;
        BloxCraft.setState("disco-light-phase", 0);
        BloxCraft.setState("bass-pulse", 0);
    }
};
BloxCraft.discoTick = func {
    if (!BloxCraft.discoOn) return;
    BloxCraft.discoPhase = (BloxCraft.discoPhase + 1) % 4;
    BloxCraft.setState("disco-light-phase", BloxCraft.discoPhase);
    BloxCraft.setState("bass-pulse", BloxCraft.discoPhase == 0 ? 1 : 0.25);
    BloxCraft.discoTimer = settimer(BloxCraft.discoTick, 0.25);
};
BloxCraft.monitorLanding = func {
    if (BloxCraft.cushionOut and !BloxCraft.cushionPopped) {
        var wow = getprop("/gear/gear[0]/wow");
        var wow2 = getprop("/gear/gear[1]/wow");
        var wow3 = getprop("/gear/gear[2]/wow");
        if (wow or wow2 or wow3) {
            BloxCraft.cushionPopped = 1; BloxCraft.cushionOut = 0;
            BloxCraft.setState("cushion-deployed", 0);
            BloxCraft.setState("cushion-popped", 1);
            print("BC-001: Landing cushion popped on touchdown.");
        }
    }
    BloxCraft.monitorTimer = settimer(BloxCraft.monitorLanding, 0.2);
};
BloxCraft.setState("engine-running", 0);
BloxCraft.setState("engine-failure", 0);
BloxCraft.setState("engine-state", "OFF");
BloxCraft.setState("afterburner", 0);
BloxCraft.setState("wheels-dropped", 0);
BloxCraft.setState("cushion-deployed", 0);
BloxCraft.setState("cushion-popped", 0);
BloxCraft.setState("parachute-deployed", 0);
BloxCraft.setState("disco-enabled", 0);
BloxCraft.setState("radio-enabled", 0);
BloxCraft.setState("disco-light-phase", 0);
BloxCraft.setState("bass-pulse", 0);
BloxCraft.setState("sound/engine-start", 0);
BloxCraft.setState("sound/engine-stop", 0);
BloxCraft.setState("sound/afterburner-on", 0);
BloxCraft.setState("sound/afterburner-off", 0);
BloxCraft.monitorTimer = settimer(BloxCraft.monitorLanding, 0.2);
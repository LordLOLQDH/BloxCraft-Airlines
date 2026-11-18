# BloxCraft Airlines BC-001 control logic.
# User-provided audio playback will be connected when sound filenames are supplied.

var BloxCraft = {
    engineOn: 0, afterburner: 0, wheelsDropped: 0,
    cushionOut: 0, cushionPopped: 0, parachuteOut: 0, discoOn: 0
};

BloxCraft.toggleEngine = func {
    BloxCraft.engineOn = !BloxCraft.engineOn;
    setprop("/bloxcraft/engine-running", BloxCraft.engineOn);
    setprop("/controls/engines/engine[0]/starter", BloxCraft.engineOn);
    setprop("/controls/engines/engine[0]/throttle", BloxCraft.engineOn ? 0.65 : 0);
    setprop("/bloxcraft/engine-state", BloxCraft.engineOn ? "RUNNING" : "OFF");
    if (!BloxCraft.engineOn) {
        BloxCraft.afterburner = 0;
        setprop("/bloxcraft/afterburner", 0);
    }
};

BloxCraft.toggleAfterburner = func {
    if (!BloxCraft.engineOn) { print("BC-001: Start the engines first."); return; }
    BloxCraft.afterburner = !BloxCraft.afterburner;
    setprop("/bloxcraft/afterburner", BloxCraft.afterburner);
    setprop("/controls/engines/engine[0]/throttle", BloxCraft.afterburner ? 1.0 : 0.65);
};

BloxCraft.dropWheels = func {
    if (BloxCraft.wheelsDropped) return;
    BloxCraft.wheelsDropped = 1;
    setprop("/bloxcraft/wheels-dropped", 1);
    print("BC-001: Wheels released.");
};

BloxCraft.deployCushion = func {
    if (BloxCraft.cushionPopped) { print("BC-001: Cushion has already popped. Reset the aircraft to repack."); return; }
    BloxCraft.cushionOut = 1;
    setprop("/bloxcraft/cushion-deployed", 1);
};

BloxCraft.deployParachute = func {
    if (BloxCraft.parachuteOut) return;
    BloxCraft.parachuteOut = 1;
    setprop("/bloxcraft/parachute-deployed", 1);
    setprop("/controls/flight/speedbrake", 1);
};

BloxCraft.engineFailure = func {
    BloxCraft.engineOn = 0;
    BloxCraft.afterburner = 0;
    setprop("/bloxcraft/engine-running", 0);
    setprop("/bloxcraft/engine-failure", 1);
    setprop("/bloxcraft/engine-state", "FAILURE");
    setprop("/controls/engines/engine[0]/throttle", 0);
    BloxCraft.deployParachute();
};

BloxCraft.toggleDisco = func {
    BloxCraft.discoOn = !BloxCraft.discoOn;
    setprop("/bloxcraft/disco-enabled", BloxCraft.discoOn);
    setprop("/bloxcraft/radio-enabled", BloxCraft.discoOn);
    print(BloxCraft.discoOn ? "BC-001: Radio and disco mode ON." : "BC-001: Radio and disco mode OFF.");
};

# Initialise aircraft-specific properties.
setprop("/bloxcraft/engine-running", 0);
setprop("/bloxcraft/engine-failure", 0);
setprop("/bloxcraft/afterburner", 0);
setprop("/bloxcraft/wheels-dropped", 0);
setprop("/bloxcraft/cushion-deployed", 0);
setprop("/bloxcraft/cushion-popped", 0);
setprop("/bloxcraft/parachute-deployed", 0);
setprop("/bloxcraft/disco-enabled", 0);
setprop("/bloxcraft/radio-enabled", 0);

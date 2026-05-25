-- Anti Tamper
local SCRIPT_NAME = "TAHO-TEST"

if SCRIPT_NAME ~= "TAHO-TEST" then
    warn("Tamper Detected")
    return
end

-- Anti Debug
local start = tick()
task.wait(0.1)

if tick() - start > 2 then
    warn("Debugger detected")
    return
end

print("Taho Hub Loaded")

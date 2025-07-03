-- This is used for render prize car, wheel and player interact
local displayCarObj = nil

function SpawnDisplayCar()
    QBCore.Functions.SpawnVehicle(CONFIG.carPrizeDisplay.carModel, function(vehicle)
        displayCarObj = vehicle
        SetEntityAsMissionEntity(displayCarObj, true, true)
        SetVehicleHasBeenOwnedByPlayer(displayCarObj, true)
        FreezeEntityPosition(displayCarObj, true)
        SetEntityInvincible(displayCarObj, true)
        SetVehicleDoorsLocked(displayCarObj, 2)
    end, CONFIG.carPrizeDisplay.pos, false, false)
end

Citizen.CreateThread(function()
    local lastTick = GetGameTimer()
    while true do
        if displayCarObj ~= nil then
            local now = GetGameTimer()
            local delta = (now - lastTick) / 1000 -- seconds since last update
            lastTick = now

            local _heading = GetEntityHeading(displayCarObj)
            local _z = _heading - (CONFIG.carPrizeDisplay.rotationSpeed * delta)
            SetEntityHeading(displayCarObj, _z)
        end
        Citizen.Wait(16) -- ~60 FPS, adjust higher for less CPU usage
    end
end)
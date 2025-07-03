local wheelObj = nil

function PlayWheelAnim(prizeIndex)
    if wheelObj == nil then
        return false
    end
    
    -- Input validation
    if not prizeIndex or prizeIndex < 1 or prizeIndex > 20 then
        print("Error: Invalid prize index. Must be between 1 and 20.")
        return false
    end
    
    -- Prevent multiple animations running simultaneously
    if IsRolling then
        print("Wheel is already spinning!")
        return false
    end
    
    IsRolling = true
    
    Citizen.CreateThread(function()
        -- Get current rotation instead of resetting to zero
        local initialRotation = GetEntityRotation(wheelObj, 1).y
        local startTime = GetGameTimer()
        local spinDuration = CONFIG.rollTime -- Total spin duration
        local endTime = startTime + spinDuration
        
        -- Calculate target angle (18 degrees per segment for 20 prizes)
        local targetAngle = (prizeIndex - 1) * 18
        local totalRotation = (360 * 8) + targetAngle -- 8 full rotations + target
        
        -- Track rotation for sound triggers
        local lastSoundAngle = math.floor(initialRotation / 18) * 18
        local totalRotationCompleted = 0
        
        -- Easing function for smooth acceleration/deceleration
        local function easeInOutQuad(t)
            if t < 0.5 then
                return 2 * t * t
            else
                return -1 + (4 - 2 * t) * t
            end
        end
        
        -- Main animation loop
        while GetGameTimer() < endTime do
            local currentTime = GetGameTimer()
            local progress = (currentTime - startTime) / spinDuration
            local easedProgress = easeInOutQuad(progress)
            
            -- Calculate current rotation (relative to initial rotation)
            local currentRotation = initialRotation - (easedProgress * totalRotation)
            local currentRotationDegrees = currentRotation % 360
            if currentRotationDegrees < 0 then currentRotationDegrees = currentRotationDegrees + 360 end
            
            -- Check if we've passed another 18-degree segment
            local currentSegment = math.floor(currentRotationDegrees / 18)
            local lastSegment = math.floor(lastSoundAngle / 18)
            
            if currentSegment ~= lastSegment then
                -- Play the tick sound when passing each segment
                PlaySoundFrontend(-1, "Spin_Single_Ticks", "dlc_vw_casino_lucky_wheel_sounds", true)
                lastSoundAngle = currentSegment * 18
            end
            
            -- Apply rotation (use 2 for interpolation to smooth out changes)
            SetEntityRotation(wheelObj, 0.0, currentRotation, 0.0, 2, true)
            
            -- Adjust wait time for smoother animation
            local waitTime = progress < 0.7 and 5 or 10
            Citizen.Wait(waitTime)
        end
        
        -- Ensure final position is exactly correct (no interpolation)
        SetEntityRotation(wheelObj, 0.0, initialRotation - totalRotation, 0.0, 1, true)
        
        -- Animation complete
        IsRolling = false
    end)
    
    return true
end

function InitWheel()
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')

    Citizen.CreateThread(function()
        -- Wheel
        QBCore.Functions.LoadModel(model)
        wheelObj = CreateObject(model, CONFIG.wheelInfo.wheelPos.x, CONFIG.wheelInfo.wheelPos.y, CONFIG.wheelInfo.wheelPos.z, false, false, true)
        SetEntityHeading(wheelObj, CONFIG.wheelInfo.wheelHeading)
        SetModelAsNoLongerNeeded(model)
        -- Display Car
        SpawnDisplayCar()
        -- Add the target zone
        exports['qb-target']:AddCircleZone('lucky-wheel-target-zone', vector3(CONFIG.wheelInfo.rollPosition.x, CONFIG.wheelInfo.rollPosition.y, CONFIG.wheelInfo.rollPosition.z), 2.0,{
            name = 'lucky-wheel-target-zone',
            debugPoly = false,
            useZ=true
        }, {
            options = {
                {
                    label = 'Quay (' .. CONFIG.rollPrice .. '$)',
                    icon = 'fa-solid fa-wheel',
                    action = function()
                        DoRoll()
                    end
                }
            },
            distance = 2.0
        })
    end)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- On player logged in
    InitWheel()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        InitWheel()
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if wheelObj ~= nil then
            DeleteEntity(wheelObj)
        end
	end
end)
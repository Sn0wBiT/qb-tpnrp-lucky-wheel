local wheelObj = nil
local baseWheelObj = nil

function PlayWheelAnim(prizeIndex)
    -- Input validation
    if not prizeIndex or prizeIndex < 1 or prizeIndex > 20 then
        print("Error: Invalid price index. Must be between 1 and 20.")
        return false
    end
    
    -- Prevent multiple animations running simultaneously
    if IsRolling then
        print("Wheel is already spinning!")
        return false
    end
    
    IsRolling = true
    
    -- Reset wheel rotation
    SetEntityRotation(wheelObj, 0.0, 0.0, 0.0, 1, true)
    
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        
        -- Calculate target angle (18 degrees per segment for 20 prizes)
        local _winAngle = (prizeIndex - 1) * 18
        
        -- Add extra rotations for dramatic effect (8 full rotations + target)
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        
        local intCnt = 0
        local maxSpeed = 15 -- Maximum speed multiplier for more dramatic spinning
        local minSpeed = 0.1 -- Minimum speed for fine control at the end
        
        -- Main animation loop
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(wheelObj, 1)
            
            -- Acceleration phase (first half)
            if _rollAngle > _midLength then
                speedIntCnt = math.min(speedIntCnt + 0.5, maxSpeed) -- Gradual acceleration
            else
                -- Deceleration phase (second half)
                speedIntCnt = speedIntCnt - 0.3 -- Gradual deceleration
                
                -- Ensure we don't go below minimum speed until very close to target
                if _rollAngle > 5.0 and speedIntCnt < minSpeed then
                    speedIntCnt = minSpeed
                elseif _rollAngle <= 5.0 then
                    -- Fine control for precise landing
                    speedIntCnt = math.max(speedIntCnt - 0.1, 0.05)
                end
                
                -- Stop when speed reaches zero
                if speedIntCnt <= 0 then
                    speedIntCnt = 0
                end
            end
            
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
            
            -- Precision landing - ensure we stop exactly at target
            if _rollAngle <= 0.5 then
                -- Calculate exact final position
                local currentRotation = GetEntityRotation(wheelObj, 1).y
                local targetRotation = -_winAngle -- Negative because we're subtracting
                
                -- Smoothly interpolate to exact position
                local diff = targetRotation - currentRotation
                if math.abs(diff) > 180 then
                    -- Handle 360-degree wraparound
                    if diff > 0 then
                        diff = diff - 360
                    else
                        diff = diff + 360
                    end
                end
                
                -- Apply final precise rotation
                _y = currentRotation + (diff * 0.1)
                
                -- Stop if we're very close to target
                if math.abs(diff) < 0.1 then
                    _y = targetRotation
                    speedIntCnt = 0
                end
            end
            
            -- Apply rotation
            SetEntityRotation(wheelObj, 0.0, _y, 0.0, 1, true)
            
            -- Adaptive wait time based on speed for smoother animation
            local waitTime = math.max(1, math.floor(20 - speedIntCnt))
            Citizen.Wait(waitTime)
        end
        
        -- Ensure final position is exactly correct
        local finalAngle = -_winAngle
        SetEntityRotation(wheelObj, 0.0, finalAngle, 0.0, 1, true)
        
        -- Animation complete
        IsRolling = false
    end)
    
    return true
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- On player logged in
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')
    local baseWheelModel = GetHashKey('vw_prop_vw_luckywheel_01a')

    Citizen.CreateThread(function()
        -- Base wheel
        QBCore.Functions.LoadModel(baseWheelModel)
        baseWheelObj = CreateObject(baseWheelModel, CONFIG.wheelInfo.baseWheelPos.x, CONFIG.wheelInfo.baseWheelPos.y, CONFIG.wheelInfo.baseWheelPos.z, false, false, true)
        SetEntityHeading(baseWheelObj, CONFIG.wheelInfo.baseWheelHeading)
        SetModelAsNoLongerNeeded(baseWheelModel)
        
        -- Wheel
        QBCore.Functions.LoadModel(model)
        wheelObj = CreateObject(model, CONFIG.wheelInfo.wheelPos.x, CONFIG.wheelInfo.wheelPos.y, CONFIG.wheelInfo.wheelPos.z, false, false, true)
        SetEntityHeading(wheelObj, CONFIG.wheelInfo.wheelHeading)
        SetModelAsNoLongerNeeded(model)
        -- Display Car
        SpawnDisplayCar()
        -- Add target zone
        exports['qb-target']:AddCircleZone('lucky-wheel-target-zone', vector3(CONFIG.wheelInfo.rollPosition.x, CONFIG.wheelInfo.rollPosition.y, CONFIG.wheelInfo.rollPosition.z), 2.0,{
            name = 'lucky-wheel-target-zone',
            debugPoly = false,
            useZ=true
        }, {
            options = {
                {
                    label = 'Quay (' .. CONFIG.rollPrize .. '$)',
                    icon = 'fa-solid fa-wheel',
                    action = function()
                        DoRoll()
                    end
                }
            },
            distance = 2.0
        })
    end)
end)
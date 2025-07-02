QBCore = exports["qb-core"]:GetCoreObject()
IsRolling = false

RegisterNetEvent('qb-tpnrp-lucky-wheel:client:doRoll', function(prizeIndex)
    PlayWheelAnim(prizeIndex)
end)

--- Do roll function trigger by player who play rolling
function DoRoll()
    if IsRolling then
        return
    end
    local playerPed = PlayerPedId()

    local animLib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
    if IsPedMale(playerPed) then
        animLib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
    end
    local animName = 'enter_right_to_baseidle'
    -- Ped goto roll pos
    TaskGoStraightToCoord(playerPed, CONFIG.wheelInfo.rollPosition.x, CONFIG.wheelInfo.rollPosition.y, CONFIG.wheelInfo.rollPosition.z, 1.0, -1, 34.52, 0.0)
    local isMoved = false
    while not isMoved do
        local coords = GetEntityCoords(playerPed)
        if coords.x >= (CONFIG.wheelInfo.rollPosition.x - 0.01) and coords.x <= (CONFIG.wheelInfo.rollPosition.x + 0.01) and coords.y >= (CONFIG.wheelInfo.rollPosition.y - 0.01) and coords.y <= (CONFIG.wheelInfo.rollPosition.y + 0.01) then
            isMoved = true
        end
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, animLib, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
    while IsEntityPlayingAnim(playerPed, animLib, animName, 3) do
        Citizen.Wait(0)
        DisableAllControlActions(0)
    end
    -- Play enter to arm raised idle animation
    TaskPlayAnim(playerPed, animLib, 'enter_to_armraisedidle', 8.0, -4.0, -1, 0, 0, false, false, false)
    while IsEntityPlayingAnim(playerPed, animLib, 'enter_to_armraisedidle', 3) do
        Citizen.Wait(0)
        DisableAllControlActions(0)
    end
    
    QBCore.Functions.TriggerCallback('qb-tpnrp-lucky-wheel:server:doRoll', function(cbResult)
        if not cbResult.isSuccess then
            QBCore.Functions.Notify(cbResult.message, 'error')
            return
        end
        -- Play arm raised idle to spinning idle high animation
        TaskPlayAnim(playerPed, animLib, 'armraisedidle_to_spinningidle_high', 4.0, -4.0, -1, 0, 0, false, false, false)
        -- Only play wheel animation when flag is false (onlyOnePlayerRollAtTime)
        -- Everyone can roll there own wheel
        if not CONFIG.onlyOnePlayerRollAtTime then
            PlayWheelAnim()
        end
        while IsEntityPlayingAnim(playerPed, animLib, 'armraisedidle_to_spinningidle_high', 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        Citizen.Wait(2000)

        TaskPlayAnim(playerPed, animLib, 'spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        

        local animWinName = 'win'
        for _, prizeInfo in ipairs(CONFIG.prize) do
            if prizeInfo.prizeIndex == cbResult.prizeIndex then
                animWinName = prizeInfo.anim_win_name
                break
            end
        end
        Citizen.Wait(CONFIG.rollTime - 2000)
        PlaySoundFrontend(-1, "Win", "dlc_vw_casino_lucky_wheel_sounds", true)
        -- Play win animation
        TaskPlayAnim(playerPed, animLib, animWinName, 8.0, -8.0, -1, 0, 0, false, false, false)
        while IsEntityPlayingAnim(playerPed, animLib, animWinName, 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        -- END
    end)

    
end

QBCore = exports["qb-core"]:GetCoreObject()
IsRolling = false

RegisterNetEvent('qb-tpnrp-lucky-wheel:client:doRoll', function(prizeIndex)
    print('qb-tpnrp-lucky-wheel:doRoll', prizeIndex)
    PlayWheelAnim(prizeIndex)
end)

--- Do roll function trigger by player who play rolling
function DoRoll()
    if IsRolling then
        return
    end
    IsRolling = true
    local playerPed = PlayerPedId()

    local animLib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
    if IsPedMale(playerPed) then
        animLib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
    end
    local animName = 'enter_right_to_baseidle'
    -- Ped goto roll pos
    TaskGoStraightToCoord(playerPed, CONFIG.wheelInfo.rollPosition.x, CONFIG.wheelInfo.rollPosition.y, CONFIG.wheelInfo.rollPosition.z, 1.0, -1, 34.52, 0.0)
    -- Play roll animation
    QBCore.Functions.PlayAnim(animLib, animName, false, -1)

    while IsEntityPlayingAnim(playerPed, animLib, animName, 3) do
        Citizen.Wait(0)
        DisableAllControlActions(0)
    end
    -- Play arm raised idle animation
    QBCore.Functions.PlayAnim(animLib, 'enter_to_armraisedidle', false, -1)
    while IsEntityPlayingAnim(playerPed, animLib, 'enter_to_armraisedidle', 3) do
        Citizen.Wait(0)
        DisableAllControlActions(0)
    end

    QBCore.Functions.TriggerCallback('qb-tpnrp-lucky-wheel:server:getLucky', function(cbResult)
        print('qb-tpnrp-lucky-wheel:getLucky', json.encode(cbResult))
        if not cbResult.isSuccess then
            QBCore.Functions.Notify(cbResult.message, 'error')
            return
        end
        -- Only play wheel animation when flag is false (onlyOnePlayerRollAtTime)
        -- Everyone can roll there own wheel
        if not CONFIG.onlyOnePlayerRollAtTime then
            PlayWheelAnim()
        end
    end)

    QBCore.Functions.PlayAnim(animLib, 'armraisedidle_to_spinningidle_high', false, -1)
end

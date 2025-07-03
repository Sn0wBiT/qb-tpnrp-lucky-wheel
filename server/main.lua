QBCore = exports['qb-core']:GetCoreObject()
local isRoll = false

--- Roll the wheel
---@param source number
---@param cb function Callback function
QBCore.Functions.CreateCallback('qb-tpnrp-lucky-wheel:server:doRoll', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    -- Player does not exist
    if not Player then
        cb({
            isSuccess = false,
            message = "Player doesn't exist!",
        })
        return
    end

    -- Only one player can roll the wheel at a time (Other player have to wait)
    if CONFIG.onlyOnePlayerRollAtTime and isRoll then
        cb({
            isSuccess = false,
            message = "Vòng quay đang được sử dụng. Bạn không thể dùng!",
        })
        return
    end
    local money = Player.PlayerData.money['cash']
    if money < CONFIG.rollPrice then
        -- Player doesn't have enough money
        -- TriggerClientEvent("esx_tpnrp_luckywheel:rollFinished", -1)
        cb({
            isSuccess = false,
            message = "Bạn không có đủ tiền trong ví để chơi! Yêu cầu " .. CONFIG.rollPrice .. "$ cho 1 lần quay!",
        })
        return
    end
    -- Remove player cash
    Player.Functions.RemoveMoney('cash', CONFIG.rollPrice, 'qb-tpnrp-lucky-wheel:server:OnRollFinished')
    -- Set isRoll to true if only one player can roll the wheel at a time
    if CONFIG.onlyOnePlayerRollAtTime then
        isRoll = true
    end
    -- Random prize
    local prize = RandomPrize()
    
    -- Timeout for prize
    SetTimeout(CONFIG.rollTime, function()
        isRoll = false
        local prizeInfo = prize.prizeInfo
        if prizeInfo.type == 'money' then
            Player.Functions.AddMoney('cash', prizeInfo.amount, 'qb-tpnrp-lucky-wheel:server:OnRollFinished')
        elseif prizeInfo.type == 'inventory_item' then
            Player.Functions.AddItem(prizeInfo.name, prizeInfo.amount, nil, prizeInfo.info, 'qb-tpnrp-lucky-wheel:server:OnRollFinished')
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[prizeInfo.name], 'add')
        elseif prizeInfo.type == 'car' then
            -- Give player a vehicle at garage
            GivePlayerCar(Player, prizeInfo.name)
        end
    end)

    if CONFIG.onlyOnePlayerRollAtTime then
        -- Send to all players (including current player) that the wheel is rolling with a prizeIndex
        TriggerClientEvent("qb-tpnrp-lucky-wheel:client:doRoll", -1, prize.prizeIndex)
    end

    cb({
        isSuccess = true,
        prizeIndex = prize.prizeIndex,
        message = "Vòng quay đã được bắt đầu!",
    })
end)


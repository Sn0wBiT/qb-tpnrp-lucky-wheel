-- Build cumulative probability table for efficient random selection
local function buildCumulativeTable(config)
    local cumulative = {}
    local total = 0
    
    for i, prize in ipairs(config) do
        total = total + prize.probability
        cumulative[i] = {
            prizeIndex = prize.prizeIndex,
            prizeInfo = prize.prize,
            cumulativeProb = total
        }
    end
    
    return cumulative, total
end

-- Pre-build the cumulative table
local CUMULATIVE_PRIZES, TOTAL_PROBABILITY = buildCumulativeTable(CONFIG.prize)

-- Main random prize function
function RandomPrize()
    -- Generate random number from 0 to total probability
    local randomValue = math.random() * TOTAL_PROBABILITY
    
    -- Find the prize using binary search for efficiency
    for i, prize in ipairs(CUMULATIVE_PRIZES) do
        if randomValue <= prize.cumulativeProb then
            return prize
        end
    end
    
    -- Fallback (should never reach here with proper configuration)
    return CUMULATIVE_PRIZES[#CUMULATIVE_PRIZES]
end

function GivePlayerCar(QBPlayer, carName)
    local src = QBPlayer.PlayerData.source
    local plate = exports['qb-vehicleshop']:GeneratePlate()
    if not carName then
        print('ERROR: Vehicle not found')
        return
    end
    SetTimeout(0, function()
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            QBPlayer.PlayerData.license,
            QBPlayer.PlayerData.citizenid,
            carName,
            GetHashKey(carName),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
    end)

    local veh = QBCore.Functions.SpawnVehicle(source, carName, CONFIG.carPrizeDisplay.rewardVehiclePosition, false)
    local vehNetId = NetworkGetNetworkIdFromEntity(veh)
    -- Send reward to player
    TriggerClientEvent('qb-tpnrp-lucky-wheel:client:rewardVehicle', src, vehNetId, plate)
    TriggerClientEvent('QBCore:Notify', src, 'Bạn đã nhận được chiếc xe ' .. carName, 'success')
end
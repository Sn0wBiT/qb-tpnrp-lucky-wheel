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
            return prize.prizeIndex
        end
    end
    
    -- Fallback (should never reach here with proper configuration)
    return CUMULATIVE_PRIZES[#CUMULATIVE_PRIZES]
end


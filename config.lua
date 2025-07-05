CONFIG = {}
CONFIG.rollTime = 12000 -- Time to wait for prize return (in milisecond)
CONFIG.rollPrice = 500 -- Price to roll the wheel
CONFIG.onlyOnePlayerRollAtTime = true -- Only one player can roll the wheel at a time (Other players have to wait)

--- Wheel info [DONOT CHANGE THIS]
CONFIG.wheelInfo = {
    rollPosition = {x = 1109.86, y = 229.07, z = -49.64},
    wheelPos = {x = 1111.05, y = 229.85, z = -50.37},
    wheelHeading = 0.0
}

--- Car prize display
CONFIG.carPrizeDisplay = {
    pos = {x = 1100.58, y = 219.81, z = -48.75},
    carModel = 't20',
    heading = 90.0,
    rotationSpeed = 18, -- degrees per second (adjust as needed) (Car rotation speed)
    rewardVehiclePosition = {x = 975.28, y = 9.02, z = 81.04},
    rewardVehicleHeading = 143.94,
}

-- Prize configuration table with probabilities
CONFIG.prize = {
    -- Ultra rare prizes
    {
        prizeIndex = 19,   -- 0.1% - Win car (ultra rare)
        probability = 0.1,
        prize = {
            type = 'car',
            name = CONFIG.carPrizeDisplay.carModel,
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    
    -- Rare prizes  
    {
        prizeIndex = 12,     -- 0.5% - weapon_assaultrifle
        probability = 0.5,
        prize = {
            type = 'inventory_item',
            name = 'weapon_assaultrifle',
            amount = 1,
            info = {}
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 5,      -- 1.0% - $100,000
        probability = 1.0,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 100000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    
    -- Uncommon prizes
    {
        prizeIndex = 3,      -- 2.0%
        probability = 2.0,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 4,     -- 2.25% - Money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 6000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 8,     -- 2.25% - Money  
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 6000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 11,    -- 2.25% - Money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 6000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 16,    -- 2.25% - Money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 6000
        },
        anim_win_name = 'win_big', -- anim_win_name only have 'win_big' or 'win'
    },
    
    -- Common prizes
    {
        prizeIndex = 1,     -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework1',
            amount = 5
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 9,     -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework2',
            amount = 5
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 13,    -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework3',
            amount = 5
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 17,    -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework4',
            amount = 5
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    
    -- More common prizes
    {
        prizeIndex = 2,      -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'painkillers',
            amount = 10
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 6,      -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'ifaks',
            amount = 10
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 10,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'painkillers',
            amount = 10
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 14,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'firstaid',
            amount = 10
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 18,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'bandage',
            amount = 10
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    
    -- Most common prizes
    {
        prizeIndex = 7,      -- 9.0%
        probability = 9.0,
        prize = {
            type = 'inventory_item',
            name = 'cloth_undershirts_white',
            amount = 1
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 15,     -- 9.0%
        probability = 9.0,
        prize = {
            type = 'inventory_item',
            name = 'casinochips',
            amount = 500
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
    {
        prizeIndex = 20,    -- 41.0% - Most common fallback prize
        probability = 41.0,
        prize = {
            type = 'inventory_item',
            name = 'beer',
            amount = 100
        },
        anim_win_name = 'win', -- anim_win_name only have 'win_big' or 'win'
    },
}
CONFIG = {}
CONFIG.rollTime = 12000 -- Time to wait for prize return
CONFIG.rollPrize = 500 -- Price to roll the wheel
CONFIG.onlyOnePlayerRollAtTime = true -- Only one player can roll the wheel at a time (Other player have to wait)

--- Wheel info
CONFIG.wheelInfo = {
    rollPosition = {x = 948.39, y = 62.14, z = 75.99},
    baseWheelPos = {x = 948.5, y = 63.37, z = 75.01},
    wheelPos = {x = 949.02, y = 63.05, z = 75.99},
    wheelHeading = 90.0,
    baseWheelHeading = 58.32,
}

--- Car prize display
CONFIG.carPrizeDisplay = {
    pos = {x = 953.7, y = 70.08, z = 75.23},
    carModel = 't20',
    heading = 90.0,
    rotationSpeed = 18, -- degrees per second (adjust as needed)
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
        }
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
        }
    },
    {
        prizeIndex = 5,      -- 1.0% - $100,000
        probability = 1.0,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 100000
        }
    },
    
    -- Uncommon prizes
    {
        prizeIndex = 3,      -- 2.0%
        probability = 2.0,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        }
    },
    {
        prizeIndex = 4,     -- 2.25% - Black money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        }
    },
    {
        prizeIndex = 8,     -- 2.25% - Black money  
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        }
    },
    {
        prizeIndex = 11,    -- 2.25% - Black money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        }
    },
    {
        prizeIndex = 16,    -- 2.25% - Black money
        probability = 2.25,
        prize = {
            type = 'money',
            name = 'cash',
            amount = 10000
        }
    },
    
    -- Common prizes
    {
        prizeIndex = 1,     -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework1',
            amount = 5
        }
    },
    {
        prizeIndex = 9,     -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework2',
            amount = 5
        }
    },
    {
        prizeIndex = 13,    -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework3',
            amount = 5
        }
    },
    {
        prizeIndex = 17,    -- 3.75%
        probability = 3.75,
        prize = {
            type = 'inventory_item',
            name = 'firework4',
            amount = 5
        }
    },
    
    -- More common prizes
    {
        prizeIndex = 2,      -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'painkillers',
            amount = 10
        }
    },
    {
        prizeIndex = 6,      -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'ifaks',
            amount = 10
        }
    },
    {
        prizeIndex = 10,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'painkillers',
            amount = 10
        }
    },
    {
        prizeIndex = 14,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'firstaid',
            amount = 10
        }
    },
    {
        prizeIndex = 18,     -- 4.0%
        probability = 4.0,
        prize = {
            type = 'inventory_item',
            name = 'bandage',
            amount = 10
        }
    },
    
    -- Most common prizes
    {
        prizeIndex = 7,      -- 9.0%
        probability = 9.0,
        prize = {
            type = 'inventory_item',
            name = 'cloth_undershirts_white',
            amount = 1
        }
    },
    {
        prizeIndex = 15,     -- 9.0%
        probability = 9.0,
        prize = {
            type = 'inventory_item',
            name = 'casinochips',
            amount = 500
        }
    },
    {
        prizeIndex = 20,    -- 41.0% - Most common fallback prize
        probability = 41.0,
        prize = {
            type = 'inventory_item',
            name = 'beer',
            amount = 100
        }
    },
}
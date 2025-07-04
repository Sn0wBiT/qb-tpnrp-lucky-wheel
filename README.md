# qb-tpnrp-lucky-wheel

A **Lucky Wheel** script for the **Diamond Casino**. Inspired by the in-game casino feature, this version is tailored for servers running QB-Core and **Game Build 3407 (#DLC Agents of Sabotage)**.

---

## Features

- **Single Player Interaction**  
  Option to **network the wheel** to ensure **only one player can roll at a time**. Other players must wait their turn.

- **Best Prize Display**  
  The **T20 car** is shown at the prize display.

- **Configurable Roll Price**  
  Customize the cost to roll the wheel (default: `$500`).

---

## Requirements

- [oxmysql](https://github.com/overextended/oxmysql)
- [qb-core](https://github.com/qbcore-framework/qb-core) 
- [qb-vehicleshop](https://github.com/qbcore-framework/qb-vehicleshop) GeneratePlate function (Can be replaced with your server function)
- [qb-mechanicjob](https://github.com/qbcore-framework/qb-mechanicjob) SaveVehicleProps function (Can be replaced with your server function)
- Game build **3407** or higher (DLC: *Agents of Sabotage*)

---

## Configuration

You can adjust the roll price and network behavior directly in the script's configuration section.

Example:
```lua
CONFIG.rollTime = 12000 -- Time to wait for prize return
CONFIG.rollPrice = 500 -- Price to roll the wheel
CONFIG.onlyOnePlayerRollAtTime = true -- Only one player can roll the wheel at a time (Other player have to wait)

-- All prizes can be customized at
CONFIG.prize -- (From 1 to 20) There are 20 prizes
```

---

## Installation

1. Download or clone this repository into your `resources` folder:
   ```bash
   git clone https://github.com/Sn0wBiT/qb-tpnrp-lucky-wheel.git
   ```

2. Export GeneratePlate function in `qb-vehicleshop/server.lua`
   ```lua
   exports('GeneratePlate', GeneratePlate)
   ```
3. Add this function at bottom of `qb-inventory/server/main.lua`
   ```lua
   ---Create Drop bag from 'source' position and heading
    ---@param source number
    ---@param item table
    ---@param isOpen boolean
    ---@return number dropId netId of drop item
    function CreateDrop(source, item, isOpen)
        local src = source
        local isOpen = isOpen or true
        local playerPed = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        local distance = 1.0 -- meters in front
        local x = playerCoords.x + (distance * math.sin(-heading * math.pi / 180.0))
        local y = playerCoords.y + (distance * math.cos(-heading * math.pi / 180.0))
        
        local bag = CreateObjectNoOffset(Config.ItemDropObject, x, y, playerCoords.z, true, true, false)
        local dropId = NetworkGetNetworkIdFromEntity(bag)

        local newDropId = 'drop-' .. dropId
        local itemsTable = setmetatable({ item }, {
            __len = function(t)
                local length = 0
                for _ in pairs(t) do length += 1 end
                return length
            end
        })
        if not Drops[newDropId] then
            Drops[newDropId] = {
                name = newDropId,
                label = 'Drop',
                items = itemsTable,
                entityId = dropId,
                createdTime = os.time(),
                coords = playerCoords,
                maxweight = Config.DropSize.maxweight,
                slots = Config.DropSize.slots,
                isOpen = isOpen
            }
            TriggerClientEvent('qb-inventory:client:setupDropTarget', -1, dropId)
        else
            table.insert(Drops[newDropId].items, item)
        end

        return dropId
    end
    exports('CreateDrop', CreateDrop)
   ```
4. Add the resource to your `server.cfg`:
   ```cfg
   ensure qb-tpnrp-lucky-wheel
   ```

---

## Screenshots / Demo

*(Add some images or videos here if you have any to showcase the feature.)*

---

## License

This resource is provided **as-is**. Feel free to modify it for your server. Not for resale.

---

## Credits

Created by **TPNRP Dev Team**

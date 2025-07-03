# qb-tpnrp-lucky-wheel

A **Lucky Wheel** script for the **Diamond Casino** built on top of **QB-Core**. Inspired by the in-game casino feature, this version is tailored for servers running **Game Build 3407 (#DLC Agents of Sabotage)**.

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
- [qb-vehicleshop](https://github.com/qbcore-framework/qb-vehicleshop)
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
CONFIG.prize
```

---

## Installation

1. Download or clone this repository into your `resources` folder:
   ```bash
   git clone https://github.com/Sn0wBiT/qb-tpnrp-lucky-wheel.git
   ```

2. Export GeneratePlate function in `qb-vehicleshop/server.lua`
   ```bash
   exports('GeneratePlate', GeneratePlate)
   ```

3. Add the resource to your `server.cfg`:
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

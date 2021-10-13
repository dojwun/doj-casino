# W.I.P [ qb-casino (bank) ] W.I.P


Edited Casino Pack 



## Casino Entrance
- Casino IPL: (casino accessible without the use of teleports)
- preview: https://streamable.com/jem98k
- source: https://forum.cfx.re/t/cayo-perico-casino-dlc-ipl-loader/2099391

## Casino Luckywheel
- Luckywheel: (peek to spin the luckywheel with $5000 a V.I.P membership)
- preview: https://streamable.com/ucv48w
- source: https://github.com/Sn0wBiT/esx_tpnrp_luckywheel

## Casino Inside Track
- Inside Track: (bet on virtual racehorses with a casino membership and a $100 min bet)
- preview: https://streamable.com/m5eykj
- source: https://github.com/MRV6/mp_insidetrack

## Casino Blackjack
- Blackjack: (play 14 blackjack tables with a casino membership and a $10 min bet)
- preview: https://streamable.com/jpabhl
- source: https://github.com/Xinerki/kgv-blackjack

## Casino Slot Machines
- Slot Machines: (play 44 slotmachines with a casino membership and a different bet each slot)
- preview: https://streamable.com/5xwkki
- source: https://forum.cfx.re/t/qb-casino-slots-machine-with-sounds/4766305 (leaked)

## Casino Roulette
- Roulette: (w.i.p more info coming soon)
- preview: https://streamable.com/85vjqc
- source: https://forum.cfx.re/t/standalone-paid-aquiver-casino-roulette/2925508 (leaked)

## Casino Ui
- replaces draw3d & helper texts

- nh-context preview:
- source: https://github.com/nerohiro/nh-context

![General](https://i.imgur.com/hDbTfbt.png)

- textUi & casinoUi preview:
- source: https://github.com/dsheedes/cd_drawtextui
 
![General](https://i.imgur.com/ywWq9sT.png)

![General](https://i.imgur.com/9fPvYyv.png)

## qb-core/shared.lua info
```
["member"]= {
    ["name"] = "member",
    ["label"] = "Casino Membership",
    ["weight"] = 500,
    ["type"] = "item",
    ["image"] = "member.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = false,
    ["combinable"] = nil,
    ["description"] = "Diamond Casino Member Card"
},

["vip"]= {
    ["name"] = "vip",
    ["label"] = "V.I.P Membership",
    ["weight"] = 500,
    ["type"] = "item",
    ["image"] = "vip.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = false,
    ["combinable"] = nil,
    ["description"] = "Diamond Casino V.I.P Card"
},
```

## qb-target info
```
-- Lucky wheel
exports['qb-target']:AddCircleZone("LuckyWheel", vector3(949.391, 44.72, 71.638), 2.0, {
    name="LuckyWheel",
    heading=160,
    debugPoly=false,
    useZ=true,
    }, {
        options = {
            {
                event = "luckywheel:client:startWheel",
                icon = "fas fa-sync-alt",
                label = "Try Your Luck",
            },
        },
    distance = 2.0 
})

-- Horse Bets
exports['qb-target']:AddCircleZone("Betting", vector3(956.121,70.185,70.433), 1.0, {
    name="Betting",
    heading=160,
    debugPoly=false,
    useZ=true,
}, {
    options = {
        {
            event = "QBCore:client:openInsideTrack",
            icon = "fas fa-coins",
            label = "Start Betting",
        },
    },
    distance = 3.0 
})

-- Casino Shop
exports['qb-target']:AddTargetModel(`U_F_M_CasinoCash_01`, {
	options = {
        { 
            event = "doj:casinoChipMenu", --NotUsed
            icon = "fas fa-exchange-alt",
            label = "Exchange Casino Chips", 
        },
        {
            event = "qb-casino:client:openCasinoChips", --NotUsed
            icon = "fas fa-coins",
            label = "Purchase Casino Chips", 
        },
        {
            event = "qb-casino:client:openCasinoMembersips", 
            icon = "fas fa-id-card",
            label = "Purchase Casino Memberships", 
        },
	},
	distance = 3.0 
})
```



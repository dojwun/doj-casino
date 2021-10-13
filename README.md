# W.I.P [ qb-casino (bank) ] W.I.P


Coming Soon
- qb-casino (chips)
- Roulette




## Casino Entrance
- preview: https://streamable.com/jem98k
- Casino IPL
(casino accessible without the use of teleports)


## Casino Luckywheel
- preview: https://streamable.com/ucv48w
- Luckywheel
(peek to spin the luckywheel with $5000 a V.I.P membership)


## Casino Slot Machines
- preview: https://streamable.com/5xwkki
- Slot Machines
(play 44 slotmachines around the casino)


## Casino Inside Track
- preview: https://streamable.com/m5eykj
- Inside Track
(bet on virtual racehorses)


## Casino Blackjack
- preview: https://streamable.com/jpabhl
- Blackjack
(play 14 blackjack tables with a casino membership and a $10 min bet)


## Casino Roulette
- preview: (coming soon)
- Roulette
(info coming soon)

## Casino Ui
(replaces draw3d & helper texts)
- nh-context preview:

![General](https://i.imgur.com/hDbTfbt.png)

- textUi preview:

![General](https://i.imgur.com/ywWq9sT.png)

- casinoUi preview:

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



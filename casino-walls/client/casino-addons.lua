local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('doj:casinoChipMenu', function()
    TriggerEvent('drawtextui:HideUI')
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Chip Exchange",
            isMenuHeader = true,
        },
        {
            header = "Sell All White Casino Chips", 
            txt = "Current Value: $"..Config.whiteChipPrice.." per chip",
            params = {
                event = "qb-casino:server:WhiteSell",
                isServer = true,
            }
        },
        {
            header = "Sell All Red Casino Chips", 
            txt = "Current Value: $"..Config.redChipPrice.." per chip",
            params = {
                event = "qb-casino:server:RedSell",
                isServer = true,
            }
        },
        {
            header = "Sell All Blue Casino Chips", 
            txt = "Current Value: $"..Config.blueChipPrice.." per chip",
            params = {
                event = "qb-casino:server:BlueSell", 
                isServer = true,
            }
        },
        {
            header = "Sell All Black Casino Chips", 
            txt = "Current Value: $"..Config.blackChipPrice.." per chip",
            params = {
                event = "qb-casino:server:BlackSell",
                isServer = true,
            }
        },
        {
            header = "Sell All Gold Casino Chips", 
            txt = "Current Value: $"..Config.goldChipPrice.." per chip",
            params = {
                
                event = "qb-casino:server:GoldSell",
                isServer = true,
            }
        },
        {
            header = "< Return",
			txt = "",
			params = {
                event = "doj:casinoMainMenu"
            }
        },
    })
end)

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
            event = "doj:casinoMainMenu",
            icon = "fas fa-circle",
            label = "Speak with Casino Employee", 
        },
	},
	distance = 3.0 
})

RegisterNetEvent('qb-casino:client:openCasinoShop', function()
    local ShopItems = {}
    ShopItems.label = "Diamond Casino Shop"
    ShopItems.items = Config.CasinoShop
    ShopItems.slots = #Config.CasinoShop 
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_", ShopItems)
end)


RegisterNetEvent('doj:casinoMainMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino",
            isMenuHeader = true,
        },
        {
            header = "Chip Exchange", 
            txt = "See current prices",
            params = {
                event = "doj:casinoChipMenu",
            }
        },
        {
            header = "Browse Shop", 
            txt = "See what we have to offer",
            params = {
                event = "qb-casino:client:openCasinoShop",
            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = ""
            }
        },
    })
end)


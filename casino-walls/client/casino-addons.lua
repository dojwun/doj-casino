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

CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        wait = 5
        local inZone = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        local dist = #(PlayerPos - vector3(948.739, 34.114, 71.839))
        if dist <= 2.0 then
            wait = 5
            inZone  = true
            if Config.CasinoEmployeePrompt == 'press' then 
                text = '<b>Diamond Casino Exchange</b></p>Press [E] to talk to employee'
                if IsControlJustPressed(0, 38) then -- E
                    Wait(200)
                    TriggerEvent('doj:casinoMainMenu') 
                end
            elseif Config.CasinoEmployeePrompt == 'peek' then
                text = '<b>Diamond Casino Exchange</b>'
                exports['qb-target']:AddTargetModel(`U_F_M_CasinoCash_01`, {
                    options = {
                        { 
                            event = "doj:casinoMainMenu",
                            icon = "fab fa-speakap",
                            label = "Speak with Casino Employee", 
                        },
                    },
                    distance = 3.0 
                })
            end
        end
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            exports['textUi']:DrawTextUi('show', text)
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            exports['textUi']:HideTextUi('hide')
        end
        Wait(wait)
    end
end)

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


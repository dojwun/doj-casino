local function CreateCasinoInteractions(name, zone)
    CreateThread(function()
        lib.zones.box({
            coords = zone.coords.xyz,
            size = zone.size,
            rotation = zone.coords.w,
            onEnter = function()
                lib.showTextUI('E - interact: '..zone.text)
            end,
            onExit = function()
                lib.hideTextUI()
            end,
            inside = function()
                if IsControlJustReleased(0, 38) then
                    TriggerEvent(zone.event)
                end
            end,
            debug = false,
        })
    end)
end


RegisterNetEvent("doj:casinoMembershipMenu", function()
    lib.hideTextUI()
    exports['envi-interact']:OpenChoiceMenu({
        title = 'Diamond Casino Memberships',
        speech = 'Hello, How can i help you?',
        duration = 750,
        menuID = 'source-menu',
        position = 'right',
        options = {
            { 
                key = 'E',
                label = 'Casino Membership',
                selected = function()
                    local HasItem = exports.ox_inventory:GetItemCount("casino_member")
                    if HasItem >= 1 then
                        exports['envi-interact']:OpenChoiceMenu({
                            title = 'Diamond Casino Memberships (unavailable)',
                            speech = 'You already have a Membership.',
                            duration = 1000,
                            menuID = 'source-menu-denied',
                            position = 'right',
                            options = {
                                {
                                    key = 'X',
                                    label = 'Leave',
                                 selected = function(data)
                                        exports['envi-interact']:CloseEverything()
                                    end
                                }
                            }
                        })
                    else
                        exports['envi-interact']:OpenChoiceMenu({
                            title = 'Casino Membership $'..Config.Casino.MemberCost,
                            speech = 'Would you like to purchase?',
                            duration = 750,
                            menuID = 'membership-menu',
                            position = 'right',
                            options = {
                                {
                                    key = 'E',
                                    label = 'Yes',
                                    selected = function()
                                        TriggerServerEvent('doj:server:purchaseMembership')
                                        -- exports['envi-interact']:CloseEverything()
                                    end
                                },
                                {
                                    key = 'F',
                                    label = 'No',
                                    selected = function()
                                        TriggerEvent('doj:casinoMembershipMenu')
                                    end
                                },
                            }
                        })
                    end
                end
            },
            {
                key = 'F',
                label = 'V.I.P Membership',
                selected = function()
                    local HasItem = exports.ox_inventory:GetItemCount("casino_vip")
                    if HasItem >= 1 then
                        exports['envi-interact']:OpenChoiceMenu({
                            title = 'Diamond Casino Memberships (unavailable)',
                            speech = 'You already have a V.I.P Membership.',
                            duration = 1000,
                            menuID = 'source-menu-denied',
                            position = 'right',
                            options = {
                                {
                                    key = 'X',
                                    label = 'Leave',
                                 selected = function(data)
                                        exports['envi-interact']:CloseEverything()
                                    end
                                }
                            }
                        })
                    else
                        exports['envi-interact']:OpenChoiceMenu({
                            title = 'V.I.P Membership $'..Config.Casino.VipCost,
                            speech = 'Would you like to purchase?',
                            duration = 750,
                            menuID = 'vip-menu',
                            position = 'right',
                            options = {
                                {
                                    key = 'E',
                                    label = 'Yes',
                                    selected = function()
                                        TriggerServerEvent('doj:server:purchaseVIPMembership')
                                        -- exports['envi-interact']:CloseEverything()
                                    end
                                },
                                {
                                    key = 'F',
                                    label = 'No',
                                    selected = function()
                                        TriggerEvent('doj:casinoMembershipMenu')
                                    end
                                },
                            }
                        })
                    end
                end
            },
            {
                key = 'X',
                label = 'Leave', 
                selected = function(data)
                    exports['envi-interact']:CloseEverything()
                end
            }
        }
    })
end)

RegisterNetEvent("doj:casinoCashierMenu", function()
    lib.hideTextUI()
    local HasItem = exports.ox_inventory:GetItemCount("casino_member")
    if HasItem >= 1 then
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino Cashier',
            speech = 'Hello, How can i help you?',
            duration = 750,
            menuID = 'cashier-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Purchase Chips',
                    selected = function()
                        exports['envi-interact']:UseSlider('cashier-menu', {
                            title = '[Chip Price: $'..Config.Casino.ChipPrice..'] Amount:',
                            min = 1, 
                            max = 100, 
                            sliderState = 'unlocked',
                            sliderValue = 1, 
                            nextState = 'unlocked',
                            confirm = function(newVal)
                                TriggerServerEvent('doj:server:buySelectedAmount', newVal)
                            end
                        })
                    end
                },
                {
                    key = 'F',
                    label = 'Chip Exchange',
                    selected = function()
                        exports['envi-interact']:OpenChoiceMenu({
                            title = 'Current Value: $'..Config.Casino.ChipPrice..' per chip',
                            speech = 'How would you like to sell your Casino Chips?',
                            duration = 1000,
                            menuID = 'exchange-menu',
                            position = 'right',
                            options = {
                                { 
                                    key = 'E',
                                    label = 'Sell All',
                                    selected = function()
                                        TriggerServerEvent('doj:server:sellAllChips')
                                    end
                                },
                                { 
                                    key = 'F',
                                    label = 'Choose Amount',
                                    selected = function()
                                        exports['envi-interact']:UseSlider('exchange-menu', {
                                            title = 'Sell Amount: ', 
                                            min = 1, 
                                            max = 250, 
                                            sliderState = 'unlocked', 
                                            sliderValue = 1, 
                                            nextState = 'unlocked', 
                                            confirm = function(newVal)
                                                TriggerServerEvent('doj:server:sellSelectedAmount', newVal)
                                            end
                                        })
                                    end
                                },
                            }
                        })
                    end
                },
            }
        })
    else
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino Cashier (unavailable)',
            speech = 'You are not a member of the casino, Please go visit the front desk.',
            duration = 2000,
            menuID = 'cashier-menu-denied',
            position = 'right',
            options = {
                {
                    key = 'X',
                    label = 'Leave', 
                    selected = function(data)
                        exports['envi-interact']:CloseEverything()
                    end
                }
            }
        })
    end
end)

RegisterNetEvent("doj:casinoShopMenu", function()
    lib.hideTextUI()
    local HasItem = exports.ox_inventory:GetItemCount("casino_member")
    if HasItem >= 1 then
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino Shop',
            speech = 'Hello, How can i help you?',
            duration = 750,
            menuID = 'shop-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Browse',
                    selected = function()
                        TriggerEvent('doj:client:casinoShopCatalog')
                    end
                },
                {
                    key = 'X',
                    label = 'Leave',
                    selected = function()
                        exports['envi-interact']:CloseEverything()
                    end
                },
            }
        })
    else
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino Cashier (unavailable)',
            speech = 'You are not a member of the casino, Please go visit the front desk.',
            duration = 2000,
            menuID = 'cashier-menu-denied',
            position = 'right',
            options = {
                {
                    key = 'X',
                    label = 'Leave',
                    selected = function(data)
                        exports['envi-interact']:CloseEverything()
                    end
                }
            }
        })
    end
end)


RegisterNetEvent("doj:client:casinoShopCatalog", function()
    exports['envi-interact']:CloseEverything()
    local VendingItems = {}
    for k, v in pairs(Config.Vending) do
        VendingItems[#VendingItems + 1] =
        {
            title = exports.ox_inventory:Items(v.Items).label,
            metadata = {'Price: $'..v.Price},
            onSelect = function()
                TriggerServerEvent("doj:server:addVendingItems", v.Items, v.Price)
            end
        }
    end
    lib.registerContext({
        id = 'CasinoShops',
        title = 'Diamond Casino Consumeables',
        canClose = true,
        options = VendingItems,
    })
    lib.showContext('CasinoShops')
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end
    for name, zone in pairs(Config.CasinoInteractions) do
        CreateCasinoInteractions(name, zone)
    end
    TriggerEvent('doj:client:CreateCasinoZones')
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    for name, zone in pairs(Config.CasinoInteractions) do
        CreateCasinoInteractions(name, zone)
    end
    TriggerEvent('doj:client:CreateCasinoZones')
end)

RegisterNetEvent('doj:client:UpdateInteractSpeech', function(menu, text, time)
    exports['envi-interact']:UpdateSpeech(menu, text, time)
    exports['envi-interact']:CloseEverything()
end)





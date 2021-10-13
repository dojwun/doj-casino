local isLoggedIn = false 

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('qb-casino:client:RedSell')
AddEventHandler('qb-casino:client:RedSell', function()
    TriggerServerEvent('qb-casino:server:RedSell')
end)

RegisterNetEvent('qb-casino:client:WhiteSell')
AddEventHandler('qb-casino:client:WhiteSell', function()
    TriggerServerEvent('qb-casino:server:WhiteSell')
end)

RegisterNetEvent('qb-casino:client:BlueSell')
AddEventHandler('qb-casino:client:BlueSell', function()
    TriggerServerEvent('qb-casino:server:BlueSell')
end)

RegisterNetEvent('qb-casino:client:BlackSell')
AddEventHandler('qb-casino:client:BlackSell', function()
    TriggerServerEvent('qb-casino:server:BlackSell')
end)

RegisterNetEvent('qb-casino:client:GoldSell')
AddEventHandler('qb-casino:client:GoldSell', function()
    TriggerServerEvent('qb-casino:server:GoldSell')
end)
 

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(948.237, 34.287, 71.839))
        if dist <= 3.0 then
            wait = 5
            inZone  = true
            text = '<b>Diamond Casino</b></p>Cashier'

        else
            wait = 2000
        end
        
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('drawtextui:ShowUI', 'show', text)
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('drawtextui:HideUI')
        end
        Citizen.Wait(wait)
    end
end)

RegisterNetEvent('doj:casinoChipMenu', function()
    TriggerEvent('drawtextui:HideUI')
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Diamond Casino",
            txt = "Chip Exchange"
        },
        {
            id = 2,
            header = "Sell All White Casino Chips", 
            txt = "Current Value: $1 per chip",
            params = {
                event = "qb-casino:client:WhiteSell",
                args = {
                    
                }
            }
        },
        {
            id = 3,
            header = "Sell All Red Casino Chips", 
            txt = "Current Value: $5 per chip",
            params = {
                event = "qb-casino:client:RedSell",
                args = {
                    
                }
            }
        },
        {
            id = 4,
            header = "Sell All Blue Casino Chips", 
            txt = "Current Value: $10 per chip",
            params = {
                event = "qb-casino:client:BlueSell", 
                args = {
                    
                }
            }
        },
        {
            id = 5,
            header = "Sell All Black Casino Chips", 
            txt = "Current Value: $50 per chip",
            params = {
                event = "qb-casino:client:BlackSell",
                args = {
                     
                }
            }
        },
        {
            id = 6,
            header = "Sell All Gold Casino Chips", 
            txt = "Current Value: $100 per chip",
            params = {
                event = "qb-casino:client:GoldSell",
                args = {
                    
                }
            }
        },
    })
end)


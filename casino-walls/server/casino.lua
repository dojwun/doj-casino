local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["casino_whitechip"] = 1,
}
RegisterServerEvent("qb-casino:server:WhiteSell")
AddEventHandler("qb-casino:server:WhiteSell", function()
    local src = source
    local price = Config.whiteChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_whitechip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_whitechip'], "remove", Player.PlayerData.items[k].amount)
                    TriggerClientEvent('QBCore:Notify', src, "You sold "..Player.PlayerData.items[k].amount.." White chips for $"..price)
                    TriggerClientEvent("doj:casinoChipMenu", src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any white casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_redchip"] = 1,
}
RegisterServerEvent("qb-casino:server:RedSell")
AddEventHandler("qb-casino:server:RedSell", function()
    local src = source
    local price = Config.redChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_redchip")
    if xItem ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_redchip'], "remove", Player.PlayerData.items[k].amount)
                    TriggerClientEvent('QBCore:Notify', src, "You sold "..Player.PlayerData.items[k].amount.." Red chips for $"..price)
                    TriggerClientEvent("doj:casinoChipMenu", src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any red casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_bluechip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlueSell")
AddEventHandler("qb-casino:server:BlueSell", function()
    local src = source
    local price = Config.blueChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_bluechip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_bluechip'], "remove", Player.PlayerData.items[k].amount)
                    TriggerClientEvent('QBCore:Notify', src, "You sold "..Player.PlayerData.items[k].amount.." Blue chips for $"..price)
                    TriggerClientEvent("doj:casinoChipMenu", src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any blue casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_blackchip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlackSell")
AddEventHandler("qb-casino:server:BlackSell", function()
    local src = source
    local price = Config.blackChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_blackchip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_blackchip'], "remove", Player.PlayerData.items[k].amount)
                    TriggerClientEvent('QBCore:Notify', src, "You sold "..Player.PlayerData.items[k].amount.." Black chips for $"..price)
                    TriggerClientEvent("doj:casinoChipMenu", src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_goldchip"] = 1,
}
RegisterServerEvent("qb-casino:server:GoldSell")
AddEventHandler("qb-casino:server:GoldSell", function()
    local src = source
    local price = Config.goldChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_goldchip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_goldchip'], "remove", Player.PlayerData.items[k].amount)
                    TriggerClientEvent('QBCore:Notify', src, "You sold "..Player.PlayerData.items[k].amount.." Gold chips for $"..price)
                    TriggerClientEvent("doj:casinoChipMenu", src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any gold casino chips...", "error") 
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

















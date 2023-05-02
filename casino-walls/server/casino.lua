local QBCore = exports['qb-core']:GetCoreObject()

local quantity = 0
local ItemList = {
    ["casino_whitechip"] = 1,
	["casino_redchip"] = 1,
    ["casino_bluechip"] = 1,
	["casino_blackchip"] = 1,
	["casino_goldchip"] = 1,
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
                    quantity = quantity + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        price = price * quantity
        Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_whitechip'], "remove", quantity)
        TriggerClientEvent('QBCore:Notify', src, "You sold "..quantity.." white chips for "..price.."€")
        TriggerEvent('qb-log:server:CreateLog', 'soldchips', 'Sale Money | '..Player.PlayerData.name, 'default', quantity.." white chips for "..price.."€")
        TriggerClientEvent("doj:casinoChipMenu", src)
        quantity = 0
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any white chips to sell.", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

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
                    quantity = quantity + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        price = price * quantity
        Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_redchip'], "remove", quantity)
        TriggerClientEvent('QBCore:Notify', src, "You sold "..quantity.." Red chips for $"..price)
        TriggerEvent('qb-log:server:CreateLog', 'guedesteste', 'Dinheiro Venda | '..Player.PlayerData.name, 'default', quantity.." fichas vermelhas por "..price.."€")
        TriggerClientEvent("doj:casinoChipMenu", src)
        quantity = 0
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any red casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

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
                    quantity = quantity + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        price = price * quantity
        Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_bluechip'], "remove", quantity)
        TriggerClientEvent('QBCore:Notify', src, "You sold "..quantity.." Blue chips for $"..price)
        TriggerEvent('qb-log:server:CreateLog', 'guedesteste', 'Dinheiro Venda | '..Player.PlayerData.name, 'default', quantity.." fichas azuis por "..price.."€")
        TriggerClientEvent("doj:casinoChipMenu", src)
        quantity = 0
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any blue casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

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
                    quantity = quantity + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        price = price * quantity
        Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_blackchip'], "remove", quantity)
        TriggerClientEvent('QBCore:Notify', src, "You sold "..quantity.." black chips for $"..price)
        TriggerEvent('qb-log:server:CreateLog', 'blackchip-sell', 'Money Earned | '..Player.PlayerData.name, 'default', quantity.." black chips for $"..price)
        TriggerClientEvent("doj:casinoChipMenu", src)
        quantity = 0
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

RegisterServerEvent("qb-casino:server:GoldSell")
AddEventHandler("qb-casino:server:GoldSell", function()
    local src = source
    local price = Config.goldChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_goldchip")
    if xItem ~= nil then
        local quantity = 0
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    quantity = quantity + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        price = price * quantity
        Player.Functions.AddMoney(Config.payment, price, "sold-casino-chips")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casino_goldchip'], "remove", quantity)
        TriggerClientEvent('QBCore:Notify', src, "You sold "..quantity.." Gold chips for $"..price)
        TriggerEvent('qb-log:server:CreateLog', 'guedesteste', 'Dinheiro Venda | '..Player.PlayerData.name, 'default', quantity.." fichas de ouro por "..price.."€")
        TriggerClientEvent("doj:casinoChipMenu", src)
		quantity = 0
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any gold casino chips...", "error") 
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)









-- QBCore.Functions.CreateCallback("insidetrack:server:getbalance", function(source, cb) 
--     local Player = QBCore.Functions.GetPlayer(source)
--     local Chips = Player.Functions.GetItemByName("whitechip")

--     if Chips ~= nil then 
--         Chips = Chips
--     else
--         return TriggerClientEvent('QBCore:client:closeBets', source)
--     end
-- end)


QBCore.Functions.CreateCallback("insidetrack:server:getbalance", function(source, cb)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local bankBalance = Player.PlayerData.money["bank"]
    local MinAmount = 100

    if bankBalance >= MinAmount then
        
    else
        return TriggerClientEvent('QBCore:client:closeBets', source)
    end
    
end)


RegisterServerEvent("insidetrack:server:placebet")
AddEventHandler("insidetrack:server:placebet", function(bet)

    local Player = QBCore.Functions.GetPlayer(source)

    if Player ~= nil then
        Player.Functions.RemoveMoney("bank", tonumber(bet), "inside-track-bet")
        TriggerClientEvent('QBCore:Notify', source, "You placed a $"..bet.." bet")
    end
end) 

RegisterServerEvent("insidetrack:server:winnings")
AddEventHandler("insidetrack:server:winnings", function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        Player.Functions.AddMoney("bank", tonumber(amount), "inside-track-won")
        TriggerClientEvent('QBCore:Notify', source, "You Won $"..amount.."!")

    end
end) 


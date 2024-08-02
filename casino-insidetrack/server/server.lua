
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("insidetrack:server:getbalance", function(source, cb)
    local src = source 
    local Player = exports.qbx_core:GetPlayer(src)
    local Chips = Player.Functions.GetItemByName("casinochips")
    local minAmount = 100
    if Chips ~= nil then
        if Chips.amount >= minAmount then
            cb(Chips.amount)
        else
            return TriggerClientEvent('QBCore:client:closeBetsNotEnough', src)
        end
    else
        return TriggerClientEvent('QBCore:client:closeBetsZeroChips', src)
    end
end)

RegisterServerEvent("insidetrack:server:placebet", function(bet)
    local src = source 
    local Player = exports.qbx_core:GetPlayer(src)
    local Chips = Player.Functions.GetItemByName("casinochips")
    if Chips ~= nil then 
        if Chips.amount >= bet then
            Player.Functions.RemoveItem("casinochips", bet)
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = "You placed a "..bet.." casino chips bet"})
        else
            return TriggerClientEvent('QBCore:client:closeBetsNotEnough', src)
        end
    else
        return TriggerClientEvent('QBCore:client:closeBetsZeroChips', src)
    end
end) 

RegisterServerEvent("insidetrack:server:winnings", function(amount)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if Player ~= nil then
        if Player.Functions.AddItem('casinochips', amount) then
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = "You Won "..amount.." casino chips!"})
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "You have to much in your pockets"})

        end
    end
end) 


local ox_inventory = exports.ox_inventory
local qbx_core = exports.qbx_core

RegisterNetEvent("doj:server:purchaseMembership", function()
    local Player = qbx_core:GetPlayer(source)
    if Player.Functions.RemoveMoney(Config.Casino.Payment, Config.Casino.MemberCost) then 
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, 'membership-menu', 'Membership Purchased.', 750)
        ox_inventory:AddItem(source, 'casino_member', 1)
    else
        local missingMoney = Player.Functions.GetMoney(Config.Casino.Payment) - Config.Casino.MemberCost
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "membership-menu", 'You are missing $'..missingMoney, 1000)
    end
end)

RegisterNetEvent("doj:server:purchaseVIPMembership", function()
    local Player = qbx_core:GetPlayer(source)
    if Player.Functions.RemoveMoney(Config.Casino.Payment, Config.Casino.VipCost) then 
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, 'vip-menu', 'V.I.P Purchased.', 750)
        ox_inventory:AddItem(source, 'casino_vip', 1)
    else
        local missingMoney = Player.Functions.GetMoney(Config.Casino.Payment) - Config.Casino.VipCost
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "vip-menu", 'You are missing $'..missingMoney, 1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('doj:server:sellAllChips', function()
    local Player = qbx_core:GetPlayer(source)
    local item = ox_inventory:GetItem(source, Config.Casino.Item, nil, true)
    local price = item * Config.Casino.ChipPrice
    if ox_inventory:RemoveItem(source, Config.Casino.Item, item) then 
        Player.Functions.AddMoney(Config.Casino.Payment, price , "casino") 
        ox_inventory:RemoveItem(source, Config.Casino.Item, item)
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "exchange-menu", 'You sold '..item..' Casino Chips for $'..price..'.', 1250)
    else
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "exchange-menu", 'You dont have any chips!', 750)
    end
end)

RegisterNetEvent('doj:server:sellSelectedAmount', function(amount)
    local Player = qbx_core:GetPlayer(source)
    local item = ox_inventory:GetItem(source, Config.Casino.Item, nil, true)
    local price = amount * Config.Casino.ChipPrice
    if item >= amount then
        Player.Functions.AddMoney(Config.Casino.Payment, price , "casino")
        ox_inventory:RemoveItem(source, Config.Casino.Item, amount)
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "exchange-menu", 'You sold '..amount..' Casino Chip(s) for $'..price..'.', 1500)
    else
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "exchange-menu", 'Not enough chips!', 500)
    end
end)

RegisterNetEvent('doj:server:buySelectedAmount', function(amount)
    local Player = qbx_core:GetPlayer(source)
    local totalAmount = amount * Config.Casino.ChipPrice
    if Player.Functions.RemoveMoney(Config.Casino.Payment, totalAmount) then
        Player.Functions.RemoveMoney(Config.Casino.Payment, totalAmount)
        ox_inventory:AddItem(source, Config.Casino.Item, amount)
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "cashier-menu", 'You bought '..amount..' Casino Chip(s) for $'..totalAmount..'.', 1250)
    else
        TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "cashier-menu", 'You dont have enough money! Goodbye.', 1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('doj:server:checkItemsForGumball', function()
    if Config.SecretGumball.Machine.Payment == 'items' then
        local items = ox_inventory:Search(source, 'count', {'casino_member', 'casino_vip', Config.Casino.Item})
        if items and items.casino_member >= 1 and items.casino_vip >= 1 and items.Config.Casino.Item >= Config.SecretGumball.Machine.Price then
            ox_inventory:RemoveItem(source, 'casino_member', 1)
            ox_inventory:RemoveItem(source, 'casino_vip', 1)
            ox_inventory:RemoveItem(source, Config.Casino.Item, Config.SecretGumball.Machine.Price)
            TriggerClientEvent('doj:client:acceptTradeForGumball', source)
        elseif items and items.casino_member <= 1 or items.casino_vip <= 1 or items.Config.Casino.Item <= Config.SecretGumball.Machine.Price then
            TriggerClientEvent('doj:client:UpdateInteractSpeech', source, 'gumball-menu', 'Membership: ['..items.casino_member..']  V.I.P: ['..items.casino_vip..'] Casino Chips: ['..items.Config.Casino.Item..']', 2000)
            TriggerClientEvent('doj:client:RefreshZones', source)
        end
    elseif Config.SecretGumball.Machine.Payment == 'cash' then
        local Player = qbx_core:GetPlayer(source)
        if Player.Functions.RemoveMoney(Config.SecretGumball.Machine.Payment, Config.SecretGumball.Machine.Price) then 
            TriggerClientEvent('doj:client:acceptTradeForGumball', source)
        else
            local missingMoney = Player.Functions.GetMoney(Config.SecretGumball.Machine.Payment) - Config.SecretGumball.Machine.Price
            TriggerClientEvent('doj:client:UpdateInteractSpeech', source, "gumball-menu", 'You are missing $'..missingMoney, 1000)
            TriggerClientEvent('doj:client:RefreshZones', source)
        end
    end
end)

RegisterNetEvent('doj:server:giveGumball', function()
    ox_inventory:AddItem(source, 'casino_gumball', 1)
end)

RegisterNetEvent('doj:server:AddRandomGumballLoot', function()
    local items = Config.SecretGumball.Loot.Items[math.random(#Config.SecretGumball.Loot.Items)]
    ox_inventory:AddItem(source, items, Config.SecretGumball.Loot.Amount)
end)

exports.qbx_core:CreateUseableItem('casino_gumball', function(source)
    TriggerClientEvent('doj:client:consumeGumball', source)
    ox_inventory:RemoveItem(source, 'casino_gumball', 1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('doj:server:addVendingItems', function(item, price)
    local Player = qbx_core:GetPlayer(source)
    local balance = Player.Functions.GetMoney(Config.Casino.Payment)
    if balance >= price then
		ox_inventory:AddItem(source, item, 1)
        Player.Functions.RemoveMoney(Config.Casino.Payment, price, "vending")
        TriggerClientEvent('ox_lib:notify', source, {title= 'Bought $'..price..' '..exports.ox_inventory:Items(item).label, type='success'})
        TriggerClientEvent('doj:client:casinoShopCatalog', source)
    else
        TriggerClientEvent('ox_lib:notify', source, {title= 'Not Enough Money', type='error'})
    end
end)











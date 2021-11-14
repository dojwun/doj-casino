
local QBCore = exports['qb-core']:GetCoreObject()


isRoll = false
math.randomseed(os.time())

RegisterServerEvent('luckywheel:getwheel')
AddEventHandler('luckywheel:getwheel', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local bankBalance = Player.PlayerData.money["bank"]
    local MinAmount = Config.startingPrice

    if bankBalance >= MinAmount then
        Player.Functions.RemoveMoney("bank", tonumber(MinAmount), "lucky-wheel")
		TriggerEvent("luckywheel:startwheel", Player, source)
    else
        return TriggerClientEvent('QBCore:Notify', source, "You have enough in the bank to spin", "error")
    end
end)

RegisterServerEvent('luckywheel:startwheel')
AddEventHandler('luckywheel:startwheel', function(xPlayer, source)
    local _source = source
    if not isRoll then
        if xPlayer ~= nil then
			isRoll = true
			local rnd = math.random(1, 1000)
			local price = 0
			local priceIndex = 0
			for k,v in pairs(Config.Prices) do
				if (rnd > v.probability.a) and (rnd <= v.probability.b) then
					price = v
					priceIndex = k
					break
				end
			end
			TriggerClientEvent("luckywheel:syncanim", _source, priceIndex)
			TriggerClientEvent("luckywheel:startroll", -1, _source, priceIndex, price)
		end
	end
end)

RegisterServerEvent('luckywheel:give')
AddEventHandler('luckywheel:give', function(source, price)
	local Player = QBCore.Functions.GetPlayer(source)
	isRoll = false
	if price.type == 'car' then
		TriggerClientEvent("dojLuckywheel:winCar", source)
		TriggerClientEvent("chCasinoWall:bigWin", source)

	elseif price.type == 'item' then
		TriggerClientEvent("chCasinoWall:bigWin", source)

		Player.Functions.AddItem(price.name, price.count, slot, {["quality"] = 100})
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won "..price.count.." "..price.name.."!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",price.count )

	elseif price.type == 'money' then
		TriggerClientEvent("chCasinoWall:bigWin", source)

		Player.Functions.AddMoney('bank', tonumber(price.count), 'banking-quick-depo')
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won $"..price.count, 'success')

	elseif price.type == 'weapon' then
		TriggerClientEvent("chCasinoWall:bigWin", source)

		Player.Functions.AddItem(price.name, 1, slot, {["quality"] = 100})
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won a Pistol!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",1)
	end
	TriggerClientEvent("luckywheel:rollFinished", -1)
end)

RegisterServerEvent('luckywheel:stoproll')
AddEventHandler('luckywheel:stoproll', function()
	isRoll = false
end)

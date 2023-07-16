math.randomseed(os.time())

local QBCore = exports['qb-core']:GetCoreObject()
isRoll = false
-- local car = Config.Cars[math.random(#Config.Cars)] 

if Config.LimitedSpins then
	Citizen.CreateThread(function()
		while true do
			Wait(1000*60)
			if os.date('%H:%M') == Config.LimitedSpins then
				exports.oxmysql:execute('UPDATE players SET luckywheel_spins = 0')
			end
		end
	end)
end

RegisterNetEvent('luckywheel:getwheel', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Config.LimitedSpins == true then 
		local result = exports.oxmysql:scalarSync('SELECT luckywheel_spins FROM players where citizenid= ?', {Player.PlayerData.citizenid})
		if result == '0' then
			TriggerEvent("luckywheel:startwheel", Player, src)
		else
			TriggerClientEvent('QBCore:Notify', src, "You have already had a spin on the wheel today", "error")
		end
	elseif Config.LimitedSpins == false then
		if Player.PlayerData.money["bank"] >= Config.startingPrice then
			Player.Functions.RemoveMoney("bank", tonumber(Config.startingPrice), "lucky-wheel")
			TriggerEvent("luckywheel:startwheel", Player, src)
		else
			-- return TriggerClientEvent('QBCore:Notify', src, "You have enough in the bank to spin", "error")
			TriggerClientEvent('QBCore:Notify', src, "You have enough in the bank to spin", "error")
		end
	end
end)

RegisterNetEvent('luckywheel:startwheel', function(Player, source)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not isRoll then
        if Player ~= nil then
            exports.oxmysql:execute('UPDATE players SET luckywheel_spins = 1 where citizenid= ?', {Player.PlayerData.citizenid})
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
			TriggerClientEvent("luckywheel:syncanim", src, priceIndex)
			TriggerClientEvent("luckywheel:startroll", -1, src, priceIndex, price)
		end
	end
end)

RegisterNetEvent('luckywheel:give', function(source, price)
	local Player = QBCore.Functions.GetPlayer(source)
	isRoll = false
	if price.type == 'car' then
		TriggerClientEvent("dojLuckywheel:winCar", source)
		TriggerClientEvent("chCasinoWall:bigWin", source)
	elseif price.type == 'item' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, price.count, slot) 
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won "..price.count.." "..price.name.."!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",price.count )
	elseif price.type == 'money' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddMoney('bank', tonumber(price.count), 'banking-quick-depo')
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won $"..price.count, 'success')
	elseif price.type == 'weapon' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, 1, slot)
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won a Pistol!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",1)
	end
	TriggerClientEvent("luckywheel:rollFinished", -1)
end)

RegisterNetEvent('luckywheel:stoproll', function()
	isRoll = false
end)

RegisterNetEvent('luckywheel:server:setVehicleOwner', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local vehicle = Config.VehiclePrize
	local plate = GeneratePlate()
	exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		Player.PlayerData.license,
		cid,
		vehicle,
		GetHashKey(vehicle),
		'{}',
		-- plate,
		Config.VehiclePlateText,
		0
	})
	TriggerClientEvent('QBCore:Notify', src, "YOU WON THE SHOW CAR! congratulations!", 'success')
end)


function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end



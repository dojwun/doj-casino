
IsRoll = false

RegisterNetEvent('luckywheel:getwheel', function()
    local Player = exports.qbx_core:GetPlayer(source)
		if Player.PlayerData.money["bank"] >= Config.startingPrice then
			TriggerClientEvent('doj:client:UpdateInteractSpeech', source, 'luckywheel-menu', 'Good Luck!', 500)
			Player.Functions.RemoveMoney("bank", tonumber(Config.startingPrice), "lucky-wheel")
			TriggerEvent("luckywheel:startwheel", source)
		else
			TriggerClientEvent('doj:client:UpdateInteractSpeech', source, 'luckywheel-menu', 'You dont have enough money to spin! Goodbye.', 1500)
		end
end)

RegisterNetEvent('luckywheel:startwheel', function(source)
	local src = source
	local Player = exports.qbx_core:GetPlayer(src)
    if not IsRoll then
        if Player ~= nil then
			-- MySQL.Sync.execute('UPDATE users SET wheel = @wheel WHERE identifier = @identifier', {
			-- 	['@identifier'] = xPlayer.identifier,
			-- 	['@wheel'] = '1'
			-- })
			IsRoll = true
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
	local Player = exports.qbx_core:GetPlayer(source)
	IsRoll = false
	if price.type == 'car' then
		TriggerClientEvent("doj:client:winCar", source)
		TriggerClientEvent("chCasinoWall:bigWin", source)
	elseif price.type == 'item' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, price.count)
		TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = "Congratulations! You won "..price.count.." "..price.name.."!"})
	elseif price.type == 'money' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddMoney('bank', tonumber(price.count), 'lucky-wheel')
		TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = "Congratulations! You won $"..price.count})
	elseif price.type == 'weapon' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, 1)
		TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = "Congratulations! You won a Pistol!"})
	end
	TriggerClientEvent("luckywheel:rollFinished", -1)
end)

RegisterNetEvent('luckywheel:stoproll', function()
	IsRoll = false
end)


function DoesVehicleEntityExist(plate)
    local count = MySQL.scalar.await('SELECT COUNT(*) FROM player_vehicles WHERE plate = ?', {plate})
    return count > 0
end

local function generateUniquePlate()
    while true do
        local plate = qbx.generateRandomPlate('11AAA111')
        if not DoesVehicleEntityExist(plate) and not exports.qbx_vehicles:DoesPlayerVehiclePlateExist(plate) then return plate end
        Wait(0)
    end
end

lib.callback.register('doj:server:spawnVehicle', function(source, plate, vehicleId)
	for i = 1, #Config.Vehicle do
        local v = Config.Vehicle[i]
		local netId, veh = qbx.spawnVehicle({model = v.car, spawnSource = v.spawn, warp = GetPlayerPed(source)})
		if not netId or netId == 0 then return end
		if not veh or veh == 0 then return end
		if vehicleId then Entity(veh).state:set('vehicleid', vehicleId, false) end
		local plate = generateUniquePlate()
		SetVehicleNumberPlateText(veh, plate)
		TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)
		return netId
	end
end)

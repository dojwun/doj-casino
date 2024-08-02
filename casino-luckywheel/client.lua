

local h
local _wheel, _base, _lights1, _lights2, _arrow1, _arrow2 = nil, nil, nil, nil, nil, nil
local _isRolling = false

CreateThread(function()
	lib.requestAudioBank("DLC_VINEWOOD\\CASINO_GENERAL")
	local model1 = GetHashKey('vw_prop_vw_luckywheel_02a')
	local model2 = GetHashKey('vw_prop_vw_luckywheel_01a')
	local m1a = GetHashKey('vw_prop_vw_luckylight_off')
	local m1b = GetHashKey('vw_prop_vw_luckylight_on')
	local m2a = GetHashKey('vw_prop_vw_jackpot_off')
	local m2b = GetHashKey('vw_prop_vw_jackpot_on')
	lib.RequestModel(model1)
	lib.RequestModel(model2)
	lib.RequestModel(m1a)
	lib.RequestModel(m1b)
	lib.RequestModel(m2a)
	lib.RequestModel(m2b)
	ClearArea(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 5.0, true, false, false, false)
	_wheel = CreateObject(model1, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, false, false, true)
	SetEntityHeading(_wheel, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(model1)
	_base = CreateObject(model2, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z-0.26, false, false, true)
	SetEntityHeading(_base, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(_base)
	_lights1 = CreateObject(m1a, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+0.35, false, false, true)
	SetEntityHeading(_lights1, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(_lights1)
	_lights2 = CreateObject(m1b, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+0.35, false, false, true)
	SetEntityVisible(_lights2, false, 0)
	SetEntityHeading(_lights2, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(_lights2)
	_arrow1 = CreateObject(m2a, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+2.5, false, false, true)
	SetEntityHeading(_arrow1, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(_arrow1)
	_arrow2 = CreateObject(m2b, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+2.5, false, false, true)
	SetEntityVisible(_arrow2, false, 0)
	SetEntityHeading(_arrow2, Config.WheelPos.h)
	SetModelAsNoLongerNeeded(_arrow2)
	h = GetEntityRotation(_wheel)
end)

RegisterNetEvent("luckywheel:syncanim", function()
	doRoll(0)
end)

RegisterNetEvent("luckywheel:startroll", function(s, index, p)
	Wait(1000)
	SetEntityVisible(_lights1, false, 0)
	SetEntityVisible(_lights2, true, 0)
	win = (index - 1) * 18 + 0.0
	local j = 360
	if s == GetPlayerServerId(PlayerId()) then
		PlaySoundFromEntity(-1, "Spin_Start", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
	end
	for i=1,1100,1 do
		SetEntityRotation(_wheel, h.x, j+0.0, h.z, 0, false)
		if i < 50 then
			j = j - 1.5
		elseif i < 100 then
			j = j - 2.0
		elseif i < 150 then
			j = j - 2.5
		elseif i > 1060 then
			j = j - 0.3
		elseif i > 1030 then
			j = j - 0.6
		elseif i > 1000 then
			j = j - 0.9
		elseif i > 970 then
			j = j - 1.2
		elseif i > 940 then
			j = j - 1.5
		elseif i > 910 then
			j = j - 1.8
		elseif i > 880 then
			j = j - 2.1
		elseif i > 850 then
			j = j - 2.4
		elseif i > 820 then
			j = j - 2.7
		else
			j = j - 3.0
		end
		if i == 850 then j = math.random(win-4, win+10) + 0.0 end
		if j > 360 then j = j + 0 end
		if j < 0 then j = j + 360 end
		if i == 900 then
		end
		Wait(0)
	end
	Wait(300)
	SetEntityVisible(_arrow1, false, 0)
	SetEntityVisible(_arrow2, true, 0)
	local t = true
	if s == GetPlayerServerId(PlayerId()) then
		if p.sound == 'car' then
			PlaySoundFromEntity(-1, "Win_Car", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'cash' then
			PlaySoundFromEntity(-1, "Win_Cash", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'chips' then
			PlaySoundFromEntity(-1, "Win_Chips", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'clothes' then
			PlaySoundFromEntity(-1, "Win_Clothes", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'mystery' then
			PlaySoundFromEntity(-1, "Win_Mystery", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		else
			PlaySoundFromEntity(-1, "Win", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		end
	end
	for i=1,15,1 do
		Wait(200)
		SetEntityVisible(_lights1, t, 0)
		SetEntityVisible(_arrow2, t, 0)
		t = not t
		SetEntityVisible(_lights2, t, 0)
		SetEntityVisible(_arrow1, t, 0)
		if i == 5 then
			if s == GetPlayerServerId(PlayerId()) then
				TriggerServerEvent('luckywheel:give', s, p)
			end
		end
	end
	Wait(1000)
	SetEntityVisible(_lights1, true, 0)
	SetEntityVisible(_lights2, false, 0)
	SetEntityVisible(_arrow1, true, 0)
	SetEntityVisible(_arrow2, false, 0)
	TriggerServerEvent('luckywheel:stoproll')
end)

RegisterNetEvent("luckywheel:rollFinished", function() 
    _isRolling = false
end)


function CbRequestAnimDict(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function doRoll(index)
    if not _isRolling then
		lib.hideTextUI()
        _isRolling = true
        local playerPed = cache.ped
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'

        CbRequestAnimDict(lib, function()
			local _movePos = GetObjectOffsetFromCoords(GetEntityCoords(_base), GetEntityHeading(_base),-0.9, -0.8, -1.0)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  3000,  GetEntityHeading(_base),  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(playerPed)
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Wait(0)
            end
			SetEntityHeading(playerPed, GetEntityHeading(_base))
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Wait(0)
				DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
                Wait(0)
                DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
            Wait(4800)
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STRIP_WATCH_STAND", 0, true)
			Wait(4800)
			ClearPedTasks(playerPed)
        end)
    end
end

RegisterNetEvent("doj:casinoLuckyWheel", function() 
	lib.hideTextUI()
    local HasItem = exports.ox_inventory:GetItemCount("casino_vip")
	if HasItem >= 1 then
		    exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino LuckyWheel',
            speech = 'Hello, Are you feeling Lucky today?', 
            duration = 1000,
            menuID = 'luckywheel-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Spin Wheel for $'..Config.startingPrice,
                    selected = function()
						TriggerServerEvent("luckywheel:getwheel")
					end
                },
            }
        })
	else
		exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino LuckyWheel (unavailable)',
            speech = 'You are not a V.I.P of the casino, Please go visit the front desk.',
            duration = 2000,
            menuID = 'luckywheel-menu-denied',
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
 
RegisterNetEvent('doj:client:winCar', function(vehicle, plate, vehicleId)
    for i = 1, #Config.Vehicle do
        local v = Config.Vehicle[i]
    	local netId = lib.callback.await('doj:server:spawnVehicle', false, vehicle, v.spawn, plate, vehicleId)
    	local veh = NetToVeh(netId)
    	local props = lib.getVehicleProperties(veh)
        SetVehicleModKit(veh, 0)
        SetVehicleColours(veh, v.colors[1], v.colors[2])
        SetVehicleExtraColours(veh, v.extraColors[1], v.extraColors[2])
        SetVehicleWindowTint(veh, 3)
        SetVehicleLights(veh, 2)
        ToggleVehicleMod(veh, 22, true)
        SetVehicleXenonLightsColor(veh, v.XenonColor)
        SetVehicleInteriorColor(veh, v.intColor)
        SetVehicleExtra(veh, v.extra, false)
        SetVehicleExtra(veh, v.extra2, false)
        if v.neons then
            SetVehicleNeonLightsColour(veh, v.neons[1], v.neons[2], v.neons[3])
            for i = 0, 3 do
                SetVehicleNeonLightEnabled(veh, i, true)
            end
        end
        if v.livery then
            SetVehicleMod(veh, 48, v.livery, false)
            SetVehicleLivery(veh, v.livery)
        end
        for mod, id in pairs(v.modKits) do
            SetVehicleMod(veh, mod, id - 1, false)
        end
        SetVehicleFuelLevel(veh, 100.0)
    	props.plate = plate
    	TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', props)
	end
end)



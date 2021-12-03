local QBCore = exports['qb-core']:GetCoreObject()

local seatSideAngle = 30
local bet = 0
local hand = {}
local splitHand = {}
local timeLeft = 0
local satDownCallback = nil
local standUpCallback = nil
local leaveCheckCallback = nil
local _lambo = nil
local canSitDownCallback = nil

-- isEscorted = false
-- isHandcuffed = false
-- isDead = false

CreateThread(function()
    while true do
		sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        local closestChairDist = #(playerCoords - vector3(948.54760742188, 32.051155090332, 76.101249084473))
        if closestChairDist < 55.0 then
			sleep = 10
            DisableControlAction(0, 140, true)        
            DisableControlAction(0, 135, true)        
            DisableControlAction(0, 122, true)        
            DisableControlAction(0, 92, true)        
            DisableControlAction(0, 24, true)        
            DisableControlAction(0, 69, true)        
            DisableControlAction(0, 142, true)        
            DisableControlAction(0, 135, true)        
            DisableControlAction(0, 19, true) 
			FreezeEntityPosition(_lambo, true)			
        end
        Wait(sleep)
    end
end)

function SetSatDownCallback(cb)
	satDownCallback = cb
end

function SetStandUpCallback(cb)
	standUpCallback = cb
end

function SetLeaveCheckCallback(cb)
	leaveCheckCallback = cb
end

function SetCanSitDownCallback(cb)
	canSitDownCallback = cb
end

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < -180 and t + 180 or t
end

function cardValue(card)
	local rank = 10
	for i=2,11 do
		if string.find(card, tostring(i)) then
			rank = i
		end
	end
	if string.find(card, 'ACE') then
		rank = 11
	end
	
	return rank
end

function handValue(hand)
	local tmpValue = 0
	local numAces = 0
	
	for i,v in pairs(hand) do
		tmpValue = tmpValue + cardValue(v)
	end
	
	for i,v in pairs(hand) do
		if string.find(v, 'ACE') then numAces = numAces + 1 end
	end
	
	repeat
		if tmpValue > 21 and numAces > 0 then
			tmpValue = tmpValue - 10
			numAces = numAces - 1
		else
			break
		end
	until numAces == 0
	
	return tmpValue
end

function CanSplitHand(hand)
	if hand[1] and hand[2] then
		if hand[1]:sub(-3) == hand[2]:sub(-3) and #hand == 2 then
			if cardValue(hand[1]) == cardValue(hand[2]) then
				return true
			end
		end
	end
	return _DEBUG
end

--[[
	vw_prop_vw_chips_pile_01a.ydr -- $511,000
	vw_prop_vw_chips_pile_02a.ydr -- $3,250,000
	vw_prop_vw_chips_pile_03a.ydr -- $1,990,000
--]]

function getChips(amount)
	if amount < 500000 then
		local props = {}
		local propTypes = {}

		local d = #chipValues

		for i = 1, #chipValues do
			local iter = #props + 1
			while amount >= chipValues[d] do
				local model = chipModels[chipValues[d]]

				if not props[iter] then
					local propType = string.sub(model, 0, string.len(model) - 3)

					if propTypes[propType] then
						iter = propTypes[propType]
					else
						props[iter] = {}
						propTypes[propType] = iter
					end
				end

				props[iter][#props[iter] + 1] = model
				amount = amount - chipValues[d]
			end

			d = d - 1
		end

		return false, props
	elseif amount <= 500000 then
		return true, "vw_prop_vw_chips_pile_01a"
	elseif amount <= 5000000 then
		return true, "vw_prop_vw_chips_pile_03a"
	else
		return true, "vw_prop_vw_chips_pile_02a"
	end
end

function leaveBlackjack()
	leavingBlackjack = true
	selectedBet = 1
	hand = {}
	splitHand = {}
end

RegisterNetEvent("BLACKJACK:client:stop", function()
	leaveBlackjack()
end)



-- RegisterCommand("bet", function(source, args, rawCommand)
-- 	if args[1] and _DEBUG == true then
-- 		TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, args[1])
-- 	end
-- end, false)


spawnedPeds = {}
spawnedObjects = {}
AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		
		for i,v in ipairs(spawnedPeds) do
			DeleteEntity(v)
		end
		for i,v in ipairs(spawnedObjects) do
			DeleteEntity(v)
		end
	end
end)





function CheckGender(dealerPed)
	local models = {
		[`s_f_y_casino_01`] = "",
		[`s_m_y_casino_01`] = "female_"
	}
	return models[GetEntityModel(dealerPed)]
end

function IsSeatOccupied(coords, radius)
	local players = GetActivePlayers()
	local playerId = PlayerId()
	for i = 1, #players do
		if players[i] ~= playerId then
			local ped = GetPlayerPed(players[i])
			if IsEntityAtCoord(ped, coords, radius, radius, radius, 0, 0, 0) then
				return true
			end
		end
	end

	return false
end

dealerHand = {}
dealerValue = {}
dealerHandObjs = {}
handObjs = {}

function CreatePeds()
	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@dealer")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@") then
		RequestAnimDict("anim_casino_b@amb@casino@games@shared@dealer@")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@player")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player")
	end
	
	for i,v in pairs(customTables) do
		-- local  model = {     
		-- 	`vw_prop_casino_3cardpoker_01`,
		-- 	`vw_prop_casino_3cardpoker_01b`,
		-- 	`vw_prop_casino_blckjack_01`,
		-- 	`vw_prop_casino_blckjack_01b`
		-- }
		local model = `vw_prop_casino_3cardpoker_01b`
		if v.highStakes == true then
			model = `vw_prop_casino_blckjack_01b`
		end
		if not HasModelLoaded(model) then
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
		end
		local tableObj = CreateObjectNoOffset(model, v.coords.x, v.coords.y, v.coords.z, false, false, false)
		SetEntityRotation(tableObj, 0.0, 0.0, v.coords.w, 2, 1)
		SetObjectTextureVariant(tableObj, v.color or 3)
		table.insert(spawnedObjects, tableObj)
	end
	chips = {}					
	hand = {}
	splitHand = {}
	handObjs = {}
	for i,v in pairs(tables) do
		dealerHand[i] = {}
		dealerValue[i] = {}
		dealerHandObjs[i] = {}
		local models = {
			`s_f_y_casino_01`,
			`s_m_y_casino_01`
		}
		local model = models[1]
		if ((i+6) % 13) < 7 then
			model = models[2]
		end

		chips[i] = {}
		
		for x=1,4 do
			chips[i][x] = {}
		end
		handObjs[i] = {}
		
		for x=1,4 do
			handObjs[i][x] = {}
		end
		
		if not HasModelLoaded(model) then
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
		end
		
		local dealer = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
		SetEntityCanBeDamaged(dealer, false)
		SetBlockingOfNonTemporaryEvents(dealer, true)
		SetPedCanRagdollFromPlayerImpact(dealer, false)
		SetPedResetFlag(dealer, 249, true)
		SetPedConfigFlag(dealer, 185, true)
		SetPedConfigFlag(dealer, 108, true)
		SetPedConfigFlag(dealer, 208, true)
		SetDealerOutfit(dealer, i+6)

		local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)
		TaskSynchronizedScene(dealer, scene, "anim_casino_b@amb@casino@games@shared@dealer@", "idle", 1000.0, -8.0, 4, 1, 1148846080, 0)

		spawnedPeds[i] = dealer
	end
end

RegisterNetEvent("BLACKJACK:SyncTimer", function(_timeLeft)
	timeLeft = _timeLeft
end)

RegisterNetEvent("BLACKJACK:PlayDealerAnim", function(i, animDict, anim)
	CreateThread(function()
		local Gender = CheckGender(spawnedPeds[i])
		if Gender ~= "" then anim = string.gsub(anim, Gender,"") end
		
		local v = tables[i]
		
		if not HasAnimDictLoaded(animDict) then
			RequestAnimDict(animDict)
			repeat Wait(0) until HasAnimDictLoaded(animDict)
		end
		DebugPrint("PLAYING "..anim:upper().." ON DEALER "..i)
		local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)
		TaskSynchronizedScene(spawnedPeds[i], scene, animDict, anim, 8.0, 8.0, 4, 1, 1148846080, 0)	
	end)
end)

RegisterNetEvent("BLACKJACK:PlayDealerSpeech", function(i, speech)
	CreateThread(function()
		DebugPrint("PLAYING SPEECH "..speech:upper().." ON DEALER "..i)
		StopCurrentPlayingAmbientSpeech(spawnedPeds[i])
		PlayPedAmbientSpeechNative(spawnedPeds[i], speech, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
	end)
end)

RegisterNetEvent("BLACKJACK:DealerTurnOverCard", function(i)
	hideUiOnStart()
	local cardX,cardY,cardZ = GetEntityCoords(dealerHandObjs[i][1])
	AttachEntityToEntity(dealerHandObjs[i][1], spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i],28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
    while not HasAnimEventFired(spawnedPeds[i],585557868) do
        Wait(0)
    end
    DetachEntity(dealerHandObjs[i][1],false,true)
    SetEntityCoordsNoOffset(dealerHandObjs[i][1], cardX,cardY,cardZ)
    SetEntityRotation(dealerHandObjs[i][1], 0.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[1].z)
end)

RegisterNetEvent("BLACKJACK:DealerCheckCard", function(i)
    local cardX,cardY,cardZ = GetEntityCoords(dealerHandObjs[i][1])
    AttachEntityToEntity(dealerHandObjs[i][1], spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i],28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
	while not HasAnimEventFired(spawnedPeds[i],585557868) do
        Wait(0)
    end
    Wait(100)
    DetachEntity(dealerHandObjs[i][1],false,true)
    SetEntityCoordsNoOffset(dealerHandObjs[i][1], cardX,cardY,cardZ)
end)

RegisterNetEvent("BLACKJACK:SplitHand", function(index, seat, splitHandSize, _hand, _splitHand)
	hand = _hand
	splitHand = _splitHand

	DebugPrint("splitHandSize = "..splitHandSize)
	DebugPrint("split card coord = "..tostring(GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, cardSplitOffsets[seat][1])))
	
	SetEntityCoordsNoOffset(handObjs[index][seat][#handObjs[index][seat]], GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, cardSplitOffsets[5-seat][1]))
	SetEntityRotation(handObjs[index][seat][#handObjs[index][seat]], 0.0, 0.0, cardSplitRotationOffsets[seat][splitHandSize])
end)

selectedBet = 1


RegisterNetEvent("BLACKJACK:PlaceBetChip", function(index, seat, bet, double, split)
	CreateThread(function()
		local chipPile, props = getChips(bet)		
		if chipPile then
			local model = GetHashKey(props)			
			DebugPrint(bet)
			DebugPrint(seat)
			DebugPrint(tostring(props))
			DebugPrint(tostring(pileOffsets[seat]))		
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
			local location = 1
			if double == true then location = 2 end			
			local chip = CreateObjectNoOffset(model, tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, false, false, false)
			table.insert(spawnedObjects, chip)
			table.insert(chips[index][seat], chip)
			if split == false then
				SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, pileOffsets[seat][location].x, pileOffsets[seat][location].y, chipHeights[1]))
				SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + pileRotationOffsets[seat][3 - location].z)
			else
				SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, pileOffsets[seat][2].x, pileOffsets[seat][2].y, chipHeights[1]))
				SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + pileRotationOffsets[seat][3 - location].z)
			end
		else
			local chipXOffset = 0.0
			local chipYOffset = 0.0			
			if split or double then
				if seat == 1 then
					chipXOffset = chipXOffset + 0.03
					chipYOffset = chipYOffset + 0.05
				elseif seat == 2 then
					chipXOffset = chipXOffset + 0.05
					chipYOffset = chipYOffset + 0.02
				elseif seat == 3 then
					chipXOffset = chipXOffset + 0.05
					chipYOffset = chipYOffset - 0.02
				elseif seat == 4 then
					chipXOffset = chipXOffset + 0.02
					chipYOffset = chipYOffset - 0.05
				end
			end			
			for i = 1, #props do
				local chipGap = 0.0
				for j = 1, #props[i] do
					local model = GetHashKey(props[i][j])			
					DebugPrint(bet)
					DebugPrint(seat)
					DebugPrint(tostring(props[i][j]))
					DebugPrint(tostring(chipOffsets[seat]))		
					RequestModel(model)
					repeat Wait(0) until HasModelLoaded(model)		
					local location = i
					local chip = CreateObjectNoOffset(model, tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, false, false, false)		
					table.insert(spawnedObjects, chip)
					table.insert(chips[index][seat], chip)
						SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, chipOffsets[seat][location].x + chipXOffset, chipOffsets[seat][location].y + chipYOffset, chipHeights[1] + chipGap))
						SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + chipRotationOffsets[seat][location].z)
					chipGap = chipGap + ((chipThickness[model] ~= nil) and chipThickness[model] or 0.0)
				end
			end
		end
	end)
end)

function hideUi()
	exports['textUi']:HideTextUi('hide')
	exports['casinoUi']:HideCasinoUi('hide') 
end
 
function hideUiOnStart()
	exports['textUi']:HideTextUi('hide')
	exports['casinoUi']:HideCasinoUi('hide') 
	exports['qb-menu']:closeMenu() 
end

RegisterNetEvent("BLACKJACK:BetReceived")

local upPressed = false
local downPressed = false


RegisterNetEvent("BLACKJACK:RequestBets", function(index)
	-- timeLeft = _timeLeft
	if leavingBlackjack == true then leaveBlackjack() return end
	QBCore.Functions.TriggerCallback('BLACKJACK:server:blackChipsAmount', function(result)
		retval = result
		CreateThread(function()
			scrollerIndex = index
			exports['textUi']:DrawTextUi('show', "<strong>Max Bet:</strong> Q</p><strong>Adjust Bet: </strong>←/→</p><strong>Place Bet: </strong>ENTER</p><strong>ESC:</strong> Exit") 
			while true do
				Wait(0)
				exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Time Left: 0:"..timeLeft.."</p>Current Bet: "..bet.." </p>Availble chips: "..retval)   
				local tableLimit = (tables[scrollerIndex].highStakes == true) and #bettingNums or lowTableLimit
				if IsControlJustPressed(1, 205) then -- Q / Y
					selectedBet = tableLimit
				elseif IsControlJustPressed(1, 202) then -- ESC / B
					leaveBlackjack()
					return
				end
				if not upPressed then
					if IsControlJustPressed(1, 175) then -- RIGHT ARROW / DPAD RIGHT
						upPressed = true
						CreateThread(function()
							selectedBet = selectedBet + 1
							if selectedBet > tableLimit then selectedBet = 1 end
							Wait(175)
							while IsControlPressed(1, 175) do
								selectedBet = selectedBet + 1
								if selectedBet > tableLimit then selectedBet = 1 end
								Wait(125)
							end
	
							upPressed = false
						end)
					end
				end
				if not downPressed then
					if IsControlJustPressed(1, 174) then -- LEFT ARROW / DPAD LEFT
						downPressed = true
						CreateThread(function()
							selectedBet = selectedBet - 1
							if selectedBet < 1 then selectedBet = tableLimit end
							Wait(175)
							while IsControlPressed(1, 174) do
								selectedBet = selectedBet - 1
								if selectedBet < 1 then selectedBet = tableLimit end
								Wait(125)
							end
	
							downPressed = false
						end)
					end
				end
				bet = bettingNums[selectedBet] or 10000
				if #bettingNums < lowTableLimit and tables[scrollerIndex].highStakes == true then
					bet = bet * 10
				end
				if IsControlJustPressed(1, 201) then -- ENTER / A
					TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet)
					local betCheckRecieved = false
					local canBet = false
					local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
						betCheckRecieved = true
						canBet = _canBet
					end)
					repeat Wait(0) until betCheckRecieved == true
					RemoveEventHandler(eventHandler)
					if canBet then
						hideUi()
						if selectedBet < 27 then
							if leavingBlackjack == true then leaveBlackjack() return end
							local ped = PlayerPedId()
							local anim = "place_bet_small"						
							playerBusy = true
							local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
							NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
							NetworkStartSynchronisedScene(scene)						
							Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))					
							if leavingBlackjack == true then leaveBlackjack() return end
							TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false)
							Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))			
							if leavingBlackjack == true then leaveBlackjack() return end
							playerBusy = false						
							local idleVar = "idle_var_0"..math.random(1,5)						
							DebugPrint("IDLING POsh-BUSY: "..idleVar)						
							local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
							NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
							NetworkStartSynchronisedScene(scene)
						else
							if leavingBlackjack == true then leaveBlackjack() return end
							local ped = PlayerPedId()
							local anim = "place_bet_large"						
							playerBusy = true
							local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
							NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
							NetworkStartSynchronisedScene(scene)						
							Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))						
							if leavingBlackjack == true then leaveBlackjack() return end
							TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false)
							Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))
							if leavingBlackjack == true then leaveBlackjack() return end						
							playerBusy = false						
							local idleVar = "idle_var_0"..math.random(1,5)						
							DebugPrint("IDLING POsh-BUSY: "..idleVar)
							local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
							NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
							NetworkStartSynchronisedScene(scene)
						end
						return
					else
						QBCore.Functions.Notify('You dont have any chips...', 'error', 3500)
					end
				end
			end
		end)
	end)
end)

RegisterNetEvent("doj:client:blackjackMenu", function(args)
	local ped = PlayerPedId()
	local args = tonumber(args)
	hideUi()
	if args == 1 then 
		-- print('casino hit')
		if leavingBlackjack == true then DebugPrint("returning") return end				
		TriggerServerEvent("BLACKJACK:ReceivedMove", "hit")
		local anim = requestCardAnims[math.random(1,#requestCardAnims)]
		playerBusy = true
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))
		if leavingBlackjack == true then leaveBlackjack() return end
		playerBusy = false
		local idleVar = "idle_var_0"..math.random(1,5)
		DebugPrint("IDLING POsh-BUSY: "..idleVar)
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		return
	elseif args == 2 then
		-- print('casino stand')
		if leavingBlackjack == true then leaveBlackjack() return end
		TriggerServerEvent("BLACKJACK:ReceivedMove", "stand")	
		local anim = declineCardAnims[math.random(1,#declineCardAnims)]	
		playerBusy = true
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))
		if leavingBlackjack == true then leaveBlackjack() return end
		playerBusy = false	
		local idleVar = "idle_var_0"..math.random(1,5)	
		DebugPrint("IDLING POsh-BUSY: "..idleVar)
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		return
	elseif args == 3 then
		-- print('casino double')
		if leavingBlackjack == true then leaveBlackjack() return end
		TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet)
		local betCheckRecieved = false
		local canBet = false
		local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
			betCheckRecieved = true
			canBet = _canBet
		end)	
		repeat Wait(0) until betCheckRecieved == true
		RemoveEventHandler(eventHandler)
		if canBet then
			if leavingBlackjack == true then leaveBlackjack() return end
			TriggerServerEvent("BLACKJACK:ReceivedMove", "double")	
			local anim = "place_bet_double_down"	
			playerBusy = true
			local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
			NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
			NetworkStartSynchronisedScene(scene)
			Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))	
			if leavingBlackjack == true then leaveBlackjack() return end
			TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, true)	
			Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))
			if leavingBlackjack == true then leaveBlackjack() return end
			playerBusy = false	
			local idleVar = "idle_var_0"..math.random(1,5)	
			DebugPrint("IDLING POsh-BUSY: "..idleVar)
			local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
			NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
			NetworkStartSynchronisedScene(scene)
			return
		else
			QBCore.Functions.Notify("You don't have enough black casino chips to double down.", "error")
			exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Dealer: "..dealerValue[g_seat].."</p>Hand: "..handValue(hand))  
			TriggerEvent("casino:context:hit&stand")
		end
	else
		-- print('casino split')
		if leavingBlackjack == true then leaveBlackjack() return end
		TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet) 
		local betCheckRecieved = false
		local canBet = false
		local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
			betCheckRecieved = true
			canBet = _canBet
		end)	
		repeat Wait(0) until betCheckRecieved == true
		RemoveEventHandler(eventHandler)
		if canBet then
			if leavingBlackjack == true then leaveBlackjack() return end
			TriggerServerEvent("BLACKJACK:ReceivedMove", "split")	
			local anim = "place_bet_small_split"	
			if selectedBet > 27 then
				anim = "place_bet_large_split"
			end		
			playerBusy = true
			local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
			NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
			NetworkStartSynchronisedScene(scene)
			Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))		
			if leavingBlackjack == true then leaveBlackjack() return end
			TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false, true)		
			Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))
			if leavingBlackjack == true then leaveBlackjack() return end
			playerBusy = false		
			local idleVar = "idle_var_0"..math.random(1,5)	
			DebugPrint("IDLING POsh-BUSY: "..idleVar)
			local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
			NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
			NetworkStartSynchronisedScene(scene)
			return
		else
			QBCore.Functions.Notify("You don't have enough black casino chips to split.", "error")
			exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Dealer: "..dealerValue[g_seat].."</p>Hand: "..handValue(hand))  
			TriggerEvent("casino:context:hit&stand")
		end
	end 
end)

RegisterNetEvent("BLACKJACK:RequestMove", function()
	exports['textUi']:DrawTextUi('show', "Bets closing in 30 seconds")
	if leavingBlackjack == true then 
		leaveBlackjack() 
		return 
	elseif  #hand < 3 and #splitHand == 0 then
		TriggerEvent("casino:context:hit&doubledown")
		exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Dealer: "..dealerValue[g_seat].."</p>Hand: "..handValue(hand))  
	elseif CanSplitHand(hand) == true then
		TriggerEvent("casino:context:hit&split")
		exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Dealer: "..dealerValue[g_seat].."</p>Hand: "..handValue(hand).."</p>[Split Hand: "..handValue(splitHand).."]") 
	elseif leavingBlackjack == false then
		TriggerEvent("casino:context:hit&stand")
		exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Dealer: "..dealerValue[g_seat].."</p>Hand: "..handValue(hand)) 
	end
end)

RegisterNetEvent("BLACKJACK:GameEndReaction", function(result)
	CreateThread(function()
		if #hand == 2 and handValue(hand) == 21 and result == "good" then 
			QBCore.Functions.Notify("You have BLACKJACK!", "success")
			PlaySoundFrontend(-1, "TENNIS_MATCH_POINT", "HUD_AWARDS", 1)
		elseif handValue(hand) > 21 and result ~= "good" then
			QBCore.Functions.Notify("You went BUST", "error", 3500)
			PlaySoundFrontend(-1, "ERROR", "HUD_AMMO_SHOP_SOUNDSET", 1)
		else
			PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1) 
			QBCore.Functions.Notify("You "..resultNames[result].." with "..handValue(hand)) 
		end

		hand = {}
		splitHand = {}	
		if leavingBlackjack == true then leaveBlackjack() return end
		local anim = "reaction_"..result.."_var_0"..math.random(1,4)
		DebugPrint("Reacting: "..anim)	
		playerBusy = true
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, false, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", anim)*990))
		if leavingBlackjack == true then leaveBlackjack() return end
		playerBusy = false	
		idleVar = "idle_var_0"..math.random(1,5)
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
	end)
end)

RegisterNetEvent("BLACKJACK:RetrieveCards", function(i, seat)
	DebugPrint("TABLE "..i..": DELETE SEAT ".. seat .." CARDS")
	if seat == 0 then
		for x,v in pairs(dealerHandObjs[i]) do
			DeleteEntity(v)
			dealerHandObjs[i][x] = nil
		end
	else
		for x,v in pairs(handObjs[i][seat]) do
			DeleteEntity(v)
		end
		for x,v in pairs(chips[i][5-seat]) do
			DeleteEntity(v)
		end
	end
end)

RegisterNetEvent("BLACKJACK:UpdateDealerHand", function(i, v)
	dealerValue[i] = v
end)

RegisterNetEvent("BLACKJACK:RetrieveCardsWithAnim", function(i, seat)
	DebugPrint("TABLE "..i..": DELETE SEAT ".. seat .." CARDS")
	if seat == 0 then
		for x,v in pairs(dealerHandObjs[i]) do
			AttachEntityToEntity(v, spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i],28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
		end
		while not HasAnimEventFired(spawnedPeds[i],585557868) do
			Wait(0)
		end
		for x,v in pairs(dealerHandObjs[i]) do
			DeleteEntity(v)
			dealerHandObjs[i][x] = nil
		end
	else
		for x,v in pairs(handObjs[i][seat]) do
			AttachEntityToEntity(v, spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i],28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
		end
		while not HasAnimEventFired(spawnedPeds[i],585557868) do
			Wait(0)
		end
		for x,v in pairs(handObjs[i][seat]) do
			DeleteEntity(v)
		end
		for x,v in pairs(chips[i][5-seat]) do
			DeleteEntity(v)
		end
	end
end)

RegisterNetEvent("BLACKJACK:GiveCard", function(i, seat, handSize, card, flipped, split)
	flipped = flipped or false
	split = split or false	
	if i == g_seat and seat == closestChair then
		if split == true then
			table.insert(splitHand, card)
		else
			table.insert(hand, card)
		end		
		DebugPrint("GOT CARD "..card.." ("..cardValue(card)..")")
		DebugPrint("HAND VALUE "..handValue(hand))
	elseif seat == 0 then
		table.insert(dealerHand[i], card)
	end	
	local model = GetHashKey("vw_prop_cas_card_"..card)	
	RequestModel(model)
	repeat Wait(0) until HasModelLoaded(model)
	local card = CreateObjectNoOffset(model, tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, false, false, false)
	table.insert(spawnedObjects, card)
	if seat > 0 then
		table.insert(handObjs[i][seat], card)
	end
	AttachEntityToEntity(card, spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i], 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)	
	Wait(1300)
	DetachEntity(card, 0, true)
	if seat == 0 then
		table.insert(dealerHandObjs[i], card)
		SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsetsDealer[handSize]))
		if flipped == true then
			SetEntityRotation(card, 180.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[handSize].z)
		else
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[handSize].z)
		end
	else
		if split == true then
			SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardSplitOffsets[5-seat][handSize]))
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardSplitRotationOffsets[5-seat][handSize])
		else
			SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsets[5-seat][handSize]))
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardRotationOffsets[5-seat][handSize])
			textCoords = GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsets[5-seat][handSize])
		end
	end
end)

function ProcessTables()	
	RequestAnimDict("anim_casino_b@amb@casino@games@shared@player@")
	local alreadyEnteredZone = false
	while true do
		local sleep = 5
		local inZone = false
		if not IsEntityDead(PlayerPedId()) then
			for i,v in pairs(tables) do
				local cord = v.coords
				local highStakes = v.highStakes
				if #(GetEntityCoords(PlayerPedId()) - vector3(cord.x, cord.y, cord.z)) < 3.0 then
					local pCoords = GetEntityCoords(PlayerPedId())

					-- local tableObj = GetClosestObjectOfType(pCoords, 1.0, `vw_prop_casino_3cardpoker_01`, false, false, false)
					-- if GetEntityCoords(tableObj) == vector3(0.0, 0.0, 0.0) then
					-- 	tableObj = GetClosestObjectOfType(pCoords, 1.0, `vw_prop_casino_3cardpoker_01`, false, false, false)
					-- end

					local tableObj = 0
					local  TableModels = {     
						`vw_prop_casino_3cardpoker_01`,
						`vw_prop_casino_3cardpoker_01b`,
						`vw_prop_casino_blckjack_01`,
						`vw_prop_casino_blckjack_01b`
					}
					for i = 1 , #TableModels do
						local model = TableModels[i]
						tableObj = GetClosestObjectOfType(pCoords, 1.0, model, false, false, false)
						if GetEntityCoords(tableObj) ~= vector3(0.0, 0.0, 0.0) then
							break
						end
					end

					if GetEntityCoords(tableObj) ~= vector3(0.0, 0.0, 0.0) then
						closestChair = 1
						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						dist = #(pCoords - coords)
						for i=1,4 do
							local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..i))
							if #(pCoords - coords) < dist then
								dist = dist
								closestChair = i
							end
						end
						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						g_coords = coords
						g_rot = rot
						local angle = rot.z-findRotation(coords.x, coords.y, pCoords.x, pCoords.y)+90.0
						local seatAnim = "sit_enter_"
						if angle > 0 then seatAnim = "sit_enter_left" end
						if angle < 0 then seatAnim = "sit_enter_right" end
						if angle > seatSideAngle or angle < -seatSideAngle then seatAnim = seatAnim .. "_side" end
						local canSit = true
						if canSitDownCallback ~= nil then
							canSit = canSitDownCallback()
						end


						if #(pCoords - coords) < 1.5 and not IsSeatOccupied(coords, 0.5) and canSit then
							wait = 5
							inZone  = true

							if highStakes then
								text = "<b>Diamond Casino Blackjack (High-Limit)</b></p>Press [E] to sit down"
							else
								text = "<b>Diamond Casino Blackjack</b></p>Press [E] to sit down"
							end
						
						
							if IsControlJustPressed(1, 51) then
								-- QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
								-- 	if HasItem then
										if satDownCallback ~= nil then
											satDownCallback()
										end			
										local ped = PlayerPedId()
										local initPos = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)
										local initRot = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)										
										TaskGoStraightToCoord(ped, initPos, 1.0, 5000, initRot.z, 0.01)
										repeat Wait(0) until GetScriptTaskStatus(ped, 2106541073) == 7
										Wait(50)									
										SetPedCurrentWeaponVisible(ped, 0, true, 0, 0)									
										local scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
										NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", seatAnim, 2.0, -2.0, 13, 16, 1148846080, 0)
										NetworkStartSynchronisedScene(scene)		
										local scene = NetworkConvertSynchronisedSceneToSynchronizedScene(scene)
										repeat Wait(0) until GetSynchronizedScenePhase(scene) >= 0.99 or HasAnimEventFired(ped, 2038294702) or HasAnimEventFired(ped, -1424880317)	
										Wait(1000)
										idleVar = "idle_cardgames"
										scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
										NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 2.0, -2.0, 13, 16, 1148846080, 0)
										NetworkStartSynchronisedScene(scene)
										repeat Wait(0) until IsEntityPlayingAnim(ped, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 3) == 1
										g_seat = i
										leavingBlackjack = false	
										TriggerServerEvent("BLACKJACK:PlayerSatDown", i, closestChair)		
										local endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)
		
										CreateThread(function()
											local startCount = false
											local count = 0
											while true do
												Wait(0)
												SetPauseMenuActive(false)
												if leavingBlackjack == true then
													startCount = true
												end
												if startCount == true then
													count = count + 1
												end
												if count > 100 then
													break
												end
											end
										end)
		
										while true do
											Wait(0)
											if GetGameTimer() >= endTime then
												if playerBusy == true then
													while playerBusy == true do
														Wait(0)
														local playerPed = PlayerPedId()
														if IsEntityDead(playerPed) then
															TriggerServerEvent("BLACKJACK:PlayerRemove", i)
															ClearPedTasks(playerPed)
															leaveBlackjack()
															break
														elseif leaveCheckCallback ~= nil then
															if leaveCheckCallback() then
																TriggerServerEvent("BLACKJACK:PlayerRemove", i)
																ClearPedTasks(playerPed)
																leaveBlackjack()
																break									
															end
														end
													end
												end
												if leavingBlackjack == false then
													idleVar = "idle_var_0"..math.random(1,5)
													local scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
													NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
													NetworkStartSynchronisedScene(scene)
													endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)
												end
											end
											if leavingBlackjack == true then
												if standUpCallback ~= nil then
													standUpCallback()
												end
												local scene = NetworkCreateSynchronisedScene(coords, rot, 2, false, false, 1065353216, 0, 1065353216)
												NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", "sit_exit_left", 2.0, -2.0, 13, 16, 1148846080, 0)
												NetworkStartSynchronisedScene(scene)
												TriggerServerEvent("BLACKJACK:PlayerSatUp", i)
												Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", "sit_exit_left")*800))
												ClearPedTasks(PlayerPedId())
												break
											else
												local playerPed = PlayerPedId()
												if IsEntityDead(playerPed) then
													TriggerServerEvent("BLACKJACK:PlayerRemove", i)
													ClearPedTasks(playerPed)
													leaveBlackjack()
													if standUpCallback ~= nil then
														standUpCallback()
													end
													break
												elseif leaveCheckCallback ~= nil then
													if leaveCheckCallback() then
														TriggerServerEvent("BLACKJACK:PlayerRemove", i)
														ClearPedTasks(playerPed)
														leaveBlackjack()
														if standUpCallback ~= nil then
															standUpCallback()
														end
														break									
													end
												end
											end
										end
								-- 	else
								-- 		QBCore.Functions.Notify('You are not a member of the casino', 'error', 3500)
								-- 	end
								-- end, 'casino_member')
							end
						end
					end
					if inZone and not alreadyEnteredZone then
						alreadyEnteredZone = true
						exports['textUi']:DrawTextUi('show', text) 
					end
					if not inZone and alreadyEnteredZone then
						alreadyEnteredZone = false
						hideUi()
					end
				end
			end
		end
		Wait(sleep)	
	end
end

CreateThread(function()
	if IsModelInCdimage(`vw_prop_casino_3cardpoker_01`) and IsModelInCdimage(`s_f_y_casino_01`) then
		CreateThread(ProcessTables)
		CreateThread(CreatePeds)
	else
		ThefeedSetAnimpostfxColor(255, 0, 0, 255)
		print("ERROR: This server is missing objects required for qb-blackjack!")
	end
end)

exports("SetSatDownCallback", SetSatDownCallback)
exports("SetStandUpCallback", SetStandUpCallback)
exports("SetLeaveCheckCallback", SetLeaveCheckCallback)
exports("SetCanSitDownCallback", SetCanSitDownCallback)


exports["qb-blackjack"]:SetSatDownCallback(function()
	exports['textUi']:HideTextUi('hide')
end)

exports["qb-blackjack"]:SetStandUpCallback(function()
	hideUi()
end)

-- exports["qb-blackjack"]:SetLeaveCheckCallback(function()
-- 	if isDead or isHandcuffed or isEscorted then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end)

-- exports["qb-blackjack"]:SetCanSitDownCallback(function()
-- 	if not isDead and not isHandcuffed and not isEscorted then
-- 		return true	
-- 	else
-- 		return false 
-- 	end
-- end)

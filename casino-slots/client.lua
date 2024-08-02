local Slot, SlotCoords, ClosestSlot, ClosestSlotRotation, NearbySlot, EnteredSlot, IsSpinning, ReelLocation1, ReelLocation2, ReelLocation3, ClosestSlotForwardX, ClosestSlotForwardY, ClosestSlotModel
local ClosestSlotCoord = vector3(0, 0, 0)
local ShouldDrawScaleForm = false
local Scaleform
local AnimDict = 'anim_casino_a@amb@casino@games@slots@male'
local Slots = { 2362925439, 2775323096, 3863977906, 654385216, 161343630, 1096374064, 207578973, 3807744938 }
local RandomEnter = { 'enter_left', 'enter_right', 'enter_left_short', 'enter_right_short' }
local RandomLeave = { 'exit_left', 'exit_right' }
local RandomIdle = { 'base_idle_a', 'base_idle_b', 'base_idle_c', 'base_idle_d', 'base_idle_e', 'base_idle_f' }
local RandomSpin = { 'press_spin_a', 'press_spin_b', 'pull_spin_a', 'pull_spin_b' }
local RandomSpinningIdle = { 'spinning_a', 'spinning_b', 'spinning_c' }
local RandomWin = { 'win_a', 'win_b', 'win_c', 'win_d', 'win_e', 'win_f', 'win_g', 'win_spinning_wheel' }
local RandomLose = { 'lose_a', 'lose_b', 'lose_c', 'lose_d', 'lose_e', 'lose_f', 'lose_cruel_a', 'lose_cruel_b' }
local RandomBigWin = { 'win_big_a', 'win_big_b', 'win_big_c' }
local RandomEnterMessage = {
    'Daring today?',
    'Spin to win',
    'You will lose money!',
    'Feelin lucky punk?!',
    'Test your might',
    'You have coins?'
}
local ChosenBetAmount = 1

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function StartIdleScene(CurrentAnimation)
    Wait(GetAnimDuration(AnimDict, CurrentAnimation) * 800)
    local IdleScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, false, true, 1.0, 0, 1.0)
    lib.requestAnimDict(AnimDict)
    local RandomAnimName = RandomIdle[math.random(1, #RandomIdle)]
    NetworkAddPedToSynchronisedScene(cache.ped, IdleScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
    NetworkStartSynchronisedScene(IdleScene)
end

local function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

local function CallScaleformMethod(method, ...)
	local t
	local args = { ... }
	BeginScaleformMovieMethod(Scaleform, method)
	for _, v in ipairs(args) do
		t = type(v)
		if t == 'string' then
			PushScaleformMovieMethodParameterString(v)
		elseif t == 'number' then
			if string.match(tostring(v), "%.") then
				PushScaleformMovieFunctionParameterFloat(v)
			else
				PushScaleformMovieFunctionParameterInt(v)
			end
		elseif t == 'boolean' then
			PushScaleformMovieMethodParameterBool(v)
		end
	end
	EndScaleformMovieMethod()
end

local function SetupScaleform()
    CreateThread(function()
        Scaleform = RequestScaleformMovie('SLOT_MACHINE')
        while not HasScaleformMovieLoaded(Scaleform) do Wait(0) end
        if SlotReferences[ClosestSlotModel].theme then CallScaleformMethod('SET_THEME', SlotReferences[ClosestSlotModel].theme) else CallScaleformMethod('SET_THEME') end
        local model = ClosestSlotModel
        local handle = CreateNamedRenderTargetForModel("machine_"..SlotReferences[ClosestSlotModel].scriptrt, model)
        while ShouldDrawScaleForm do
            N_0x32f34ff7f617643b(Scaleform, 1)
            SetTextRenderId(handle)
            SetScriptGfxDrawOrder(4)
            SetScriptGfxDrawBehindPausemenu(true)
            DrawScaleformMovie(Scaleform, 0.401, 0.09, 0.805, 0.195, 255, 255, 255, 255, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            Wait(0)
        end
    end)
end

local function Sounds(audioName)
    local SoundId = GetSoundId()
    PlaySoundFromCoord(SoundId, audioName, ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, SlotReferences[ClosestSlotModel].sound, false, 20, false)
    ReleaseSoundId(SoundId)
end

local function SlotMachineHandler()
    local LeverScene = 0
    local IdleScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, false, true, 1.0, 0, 1.0)
    lib.requestAnimDict(AnimDict)
    local RandomAnimName = RandomIdle[math.random(1, #RandomIdle)]
    NetworkAddPedToSynchronisedScene(cache.ped, IdleScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
    NetworkStartSynchronisedScene(IdleScene)
    lib.showTextUI('E - Bet One  \n R - Bet Max  \n ↵ - Spin  \n ← - Leave')
    CreateThread(function()
        while true do
            exports['casino-ui']:DrawCasinoUi('show', SlotReferences[ClosestSlotModel].name.."</p>Availble Chips: "..exports.ox_inventory:GetItemCount("casinochips"))
            if not IsSpinning then
                if IsControlJustPressed(0, 202) then
                    local LeaveScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, false, false, 1.0, 0, 1.0)
                    lib.requestAnimDict(AnimDict)
                    RandomAnimName = RandomLeave[math.random(1, #RandomLeave)]
                    NetworkAddPedToSynchronisedScene(cache.ped, LeaveScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(LeaveScene)
                    Wait(GetAnimDuration(AnimDict, RandomAnimName) * 700)
                    NetworkStopSynchronisedScene(LeaveScene)
                    EnteredSlot = false
                    ShouldDrawScaleForm = false
                    lib.hideTextUI()
                    exports['casino-ui']:HideCasinoUi('hide')
                    CallScaleformMethod('SET_BET')
                    CallScaleformMethod('SET_LAST_WIN')
                    CallScaleformMethod('SET_MESSAGE', '')
                    TriggerServerEvent('dc-casino:slots:server:leave')
                    break
                elseif IsControlJustPressed(0, 201) then
                    local SpinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                    lib.requestAnimDict(AnimDict)
                    RandomAnimName = RandomSpin[math.random(1, #RandomSpin)]
                    NetworkAddPedToSynchronisedScene(cache.ped, SpinScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 1000.0, 0)
                    NetworkStartSynchronisedScene(SpinScene)
                    local AnimationDuration = GetAnimDuration(AnimDict, RandomAnimName)
                    if RandomAnimName == 'pull_spin_a' then
                        LeverScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                        N_0x45f35c0edc33b03b(LeverScene, GetEntityModel(ClosestSlot), ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, AnimDict, 'pull_spin_a_SLOTMACHINE', 2.0, -1.5, 13.0)
                        NetworkStartSynchronisedScene(LeverScene)
                        Wait(AnimationDuration * 320)
                    elseif RandomAnimName == 'pull_spin_b' then
                        LeverScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                        N_0x45f35c0edc33b03b(LeverScene, GetEntityModel(ClosestSlot), ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, AnimDict, 'pull_spin_b_SLOTMACHINE', 2.0, -1.5, 13.0)
                        NetworkStartSynchronisedScene(LeverScene)
                        Wait(AnimationDuration * 320)
                    end
                    Wait(AnimationDuration * 180)
                    Sounds('start_spin')
                    TriggerServerEvent('dc-casino:slots:server:spin', ChosenBetAmount)
                    Wait(AnimationDuration * 500)
                    local SpinningScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                    lib.requestAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(cache.ped, SpinningScene, AnimDict, RandomSpinningIdle[math.random(1, #RandomSpinningIdle)], 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(SpinningScene)
                    NetworkStopSynchronisedScene(LeverScene) --- Has to be stopped otherwise it will only work 50% of the time
                    FreezeEntityPosition(ClosestSlot, true)  --- N_0x45f35c0edc33b03b will prevent the machine being stuck to their position for some reason?
                elseif IsControlJustPressed(0, 38) then
                    Sounds('place_bet')
                    if not SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount + 1] then ChosenBetAmount = 1 else ChosenBetAmount = ChosenBetAmount + 1 end
                    local BetOneScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                    lib.requestAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(cache.ped, BetOneScene, AnimDict, 'press_betone_a', 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(BetOneScene)
                    Wait(GetAnimDuration(AnimDict, 'press_betone_a') * 200)
                    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
                    StartIdleScene('press_betone_a')
                elseif IsControlJustPressed(0, 45) then
                    Sounds('place_max_bet')
                    ChosenBetAmount = #SlotReferences[ClosestSlotModel].betamounts
                    local BetMaxScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
                    lib.requestAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(cache.ped, BetMaxScene, AnimDict, 'press_betmax_a', 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(BetMaxScene)
                    Wait(GetAnimDuration(AnimDict, 'press_betmax_a') * 200)
                    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
                    StartIdleScene('press_betmax_a')
                elseif IsEntityDead(cache.ped) then
                    EnteredSlot = false
                    ShouldDrawScaleForm = false
                    lib.hideTextUI()
                    CallScaleformMethod('SET_BET')
                    CallScaleformMethod('SET_MESSAGE', '')
                    TriggerServerEvent('dc-casino:slots:server:leave')
                    break
                end
            end
            Wait(0)
        end
    end)
end

CreateThread(function()
	while true do
        local PlayerCoords = GetEntityCoords(cache.ped)
        for i = 1, #Slots do
            Slot = GetClosestObjectOfType(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 1.2, Slots[i], false, false, false)
            if Slot ~= 0 then
                SlotCoords = GetEntityCoords(Slot)
                local CurrentDistance = #(PlayerCoords - SlotCoords)
                if CurrentDistance < 1.8 and CurrentDistance < #(PlayerCoords - ClosestSlotCoord) then
                    NearbySlot = true
                    ClosestSlot = Slot
                    ClosestSlotCoord = SlotCoords
                    ClosestSlotForwardX = GetEntityForwardX(ClosestSlot)
                    ClosestSlotForwardY = GetEntityForwardY(ClosestSlot)
                    ClosestSlotModel = GetEntityModel(ClosestSlot)
                    ClosestSlotRotation = GetEntityRotation(ClosestSlot)
                    ReelLocation1 = GetObjectOffsetFromCoords(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, GetEntityHeading(ClosestSlot), -0.115, 0.047, 0.906)
                    ReelLocation2 = GetObjectOffsetFromCoords(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, GetEntityHeading(ClosestSlot), 0.005, 0.047, 0.906)
                    ReelLocation3 = GetObjectOffsetFromCoords(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, GetEntityHeading(ClosestSlot), 0.125, 0.047, 0.906)
                end
            elseif #(PlayerCoords - ClosestSlotCoord) > 1.8 then
                NearbySlot = false
            end
        end
        Wait(600)
	end
end)

-- CreateThread(function()
-- 	while true do
--         local WaitTime = 500
--         if NearbySlot and not EnteredSlot then
--             WaitTime = 0
--             DrawText3D(vector3(ClosestSlotCoord.x - ClosestSlotForwardX, ClosestSlotCoord.y - ClosestSlotForwardY, ClosestSlotCoord.z + 1), "~o~E~w~ - Play "..SlotReferences[ClosestSlotModel].name)
--             if IsControlJustReleased(0, 38) then
--                 local netID = NetworkGetEntityIsNetworked(ClosestSlot) and NetworkGetNetworkIdFromEntity(ClosestSlot)
--                 if not netID then
--                     NetworkRegisterEntityAsNetworked(ClosestSlot)
--                     netID = NetworkGetNetworkIdFromEntity(ClosestSlot)
--                     NetworkUseHighPrecisionBlending(netID, false)
--                     SetNetworkIdExistsOnAllMachines(netID, true)
--                     SetNetworkIdCanMigrate(netID, true)
--                 end
--                 NetworkRequestControlOfEntity(ClosestSlot)
--                 TriggerServerEvent('dc-casino:slots:server:enter', netID, ReelLocation1, ReelLocation2, ReelLocation3, ClosestSlotModel)
--             end
--         end
--         Wait(WaitTime)
--     end
-- end)

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        local sleep = 1000
        if NearbySlot and not EnteredSlot then
            local pedCo = GetEntityCoords(cache.ped)
            local dist = #(pedCo - ClosestSlotCoord)
            local inZone = false
            if dist <= 1.8 then
                sleep = 5
                inZone  = true
                if IsControlJustPressed(0, 38) then
                    local HasItem = exports.ox_inventory:GetItemCount("casino_member")
                    if HasItem >= 1 then
                        local netID = NetworkGetEntityIsNetworked(ClosestSlot) and NetworkGetNetworkIdFromEntity(ClosestSlot)
                        if not netID then
                            NetworkRegisterEntityAsNetworked(ClosestSlot)
                            netID = NetworkGetNetworkIdFromEntity(ClosestSlot)
                            NetworkUseHighPrecisionBlending(netID, false)
                            SetNetworkIdExistsOnAllMachines(netID, true) 
                            SetNetworkIdCanMigrate(netID, true)
                        end
                        NetworkRequestControlOfEntity(ClosestSlot)
                        TriggerServerEvent('dc-casino:slots:server:enter', netID, ReelLocation1, ReelLocation2, ReelLocation3, ClosestSlotModel)
                    else
                        lib.notify({title = 'You are not a member of the casino!', type = 'warning'})
                    end
                end
            end
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                lib.showTextUI('E - Play Slot  \n[\n '..SlotReferences[ClosestSlotModel].name..' ]')
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                lib.hideTextUI()
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('dc-casino:slots:client:enter', function()
    while not RequestScriptAudioBank('dlc_vinewood/casino_slot_machines_01', false) do Wait(0) end
    while not RequestScriptAudioBank('dlc_vinewood/casino_slot_machines_02', false) do Wait(0) end
    while not RequestScriptAudioBank('dlc_vinewood/casino_slot_machines_03', false) do Wait(0) end
    local Ped = cache.ped
    if GetEntityModel(Ped) == `mp_f_freemode_01` then AnimDict = 'anim_casino_a@amb@casino@games@slots@female' end
    local EnterScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
    lib.requestAnimDict(AnimDict)
    local RandomAnimName = RandomEnter[math.random(1, #RandomEnter)]
    NetworkAddPedToSynchronisedScene(Ped, EnterScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
    NetworkStartSynchronisedScene(EnterScene)
    EnteredSlot = true
    ShouldDrawScaleForm = true
    SetupScaleform()
    Wait(GetAnimDuration(AnimDict, RandomAnimName) * 1000)
    CallScaleformMethod('SET_MESSAGE', RandomEnterMessage[math.random(1, #RandomEnterMessage)])
    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
    Sounds('welcome_stinger')
    SlotMachineHandler()
end)

RegisterNetEvent('dc-casino:slots:client:spinreels', function(SpinTime, ReelRewards, BlurryReelID1, BlurryReelID2, BlurryReelID3, ReelID1, ReelID2, ReelID3, RewardMultiplier)
    local EndTime = GetGameTimer() + SpinTime
    local FirstReelStop = SpinTime * math.random(2, 4) / 10
    local SecondReelStop = SpinTime * math.random(5, 7) / 10
    local ReelReward1 = ReelRewards[1] * 22.5
    local ReelReward2 = ReelRewards[2] * 22.5
    local ReelReward3 = ReelRewards[3] * 22.5
    local SlotHeading = GetEntityHeading(ClosestSlot)
    local BlurryReel1 = NetworkGetEntityFromNetworkId(BlurryReelID1)
    local BlurryReel2 = NetworkGetEntityFromNetworkId(BlurryReelID2)
    local BlurryReel3 = NetworkGetEntityFromNetworkId(BlurryReelID3)
    local Reel1 = NetworkGetEntityFromNetworkId(ReelID1)
    local Reel2 = NetworkGetEntityFromNetworkId(ReelID2)
    local Reel3 = NetworkGetEntityFromNetworkId(ReelID3)
    while not NetworkRequestControlOfEntity(BlurryReel1) do Wait(0) end
    while not NetworkRequestControlOfEntity(BlurryReel2) do Wait(0) end
    while not NetworkRequestControlOfEntity(BlurryReel3) do Wait(0) end
    while not NetworkRequestControlOfEntity(Reel1) do Wait(0) end
    while not NetworkRequestControlOfEntity(Reel2) do Wait(0) end
    while not NetworkRequestControlOfEntity(Reel3) do Wait(0) end

    IsSpinning = true
    SetEntityVisible(Reel1, false, false)
    SetEntityVisible(Reel2, false, false)
    SetEntityVisible(Reel3, false, false)
    Sounds('spinning')
    while GetGameTimer() < EndTime do
        SetEntityRotation(BlurryReel1, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
        if EndTime - GetGameTimer() > FirstReelStop then
            SetEntityRotation(BlurryReel2, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
            if EndTime - GetGameTimer() < FirstReelStop + 15 then
                if ReelRewards[2] == math.floor(ReelRewards[2]) then Sounds('wheel_stop_clunk') else Sounds('wheel_stop_on_prize') end
                DeleteObject(BlurryReel2)
                SetEntityRotation(Reel2, ReelReward2, 0.0, SlotHeading, 2, true)
                SetEntityVisible(Reel2, true, false)
            end
            if EndTime - GetGameTimer() > SecondReelStop then
                SetEntityRotation(BlurryReel3, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
                if EndTime - GetGameTimer() < SecondReelStop + 15 then
                    if ReelRewards[3] == math.floor(ReelRewards[3]) then Sounds('wheel_stop_clunk') else Sounds('wheel_stop_on_prize') end
                    DeleteObject(BlurryReel3)
                    SetEntityRotation(Reel3, ReelReward3, 0.0, SlotHeading, 2, true)
                    SetEntityVisible(Reel3, true, false)
                end
            end
        end
        Wait(0)
    end
    DeleteObject(BlurryReel1)
    SetEntityRotation(Reel1, ReelReward1, 0.0, SlotHeading, 2, true)
    SetEntityVisible(Reel1, true, false)
    CallScaleformMethod('SET_LAST_WIN', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount] * RewardMultiplier)
    if ReelRewards[1] == math.floor(ReelRewards[1]) then Sounds('wheel_stop_clunk') else Sounds('wheel_stop_on_prize') end
    if RewardMultiplier == 0 then
        lib.notify({title = 'You Lost!', type = 'warning'})
        Sounds('no_win')
        local LoseScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
        lib.requestAnimDict(AnimDict)
        local RandomAnim = RandomLose[math.random(1, #RandomLose)]
        NetworkAddPedToSynchronisedScene(cache.ped, LoseScene, AnimDict, RandomLose[math.random(1, #RandomLose)], 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(LoseScene)
        StartIdleScene(RandomAnim)
    elseif RewardMultiplier > 7 then
        if ReelReward1 == 5 and ReelReward2 == 5 and ReelReward3 == 5 then Sounds('jackpot') else Sounds('big_win') end
        local BigWinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
        lib.requestAnimDict(AnimDict)
        local RandomAnim = RandomBigWin[math.random(1, #RandomBigWin)]
        NetworkAddPedToSynchronisedScene(cache.ped, BigWinScene, AnimDict, RandomBigWin[math.random(1, #RandomBigWin)], 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(BigWinScene)
        StartIdleScene(RandomAnim)
    else
        Sounds('small_win')
        local WinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord.x, ClosestSlotCoord.y, ClosestSlotCoord.z, ClosestSlotRotation.x, ClosestSlotRotation.y, ClosestSlotRotation.z, 2, true, false, 1.0, 0, 1.0)
        lib.requestAnimDict(AnimDict)
        local RandomAnim = RandomWin[math.random(1, #RandomWin)]
        NetworkAddPedToSynchronisedScene(cache.ped, WinScene, AnimDict, RandomAnim, 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(WinScene)
        StartIdleScene(RandomAnim)
    end
    IsSpinning = false
end)

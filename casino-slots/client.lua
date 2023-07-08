local QBCore = exports['qb-core']:GetCoreObject()
local Slot
local SlotCoords
local ClosestSlot
local ClosestSlotCoord = vector3(0, 0, 0)
local ClosestSlotRotation
local NearbySlot
local EnteredSlot
local IsSpinning
local ReelLocation1
local ReelLocation2
local ReelLocation3
local ClosestSlotForwardX
local ClosestSlotForwardY
local ShouldDrawScaleForm = false
local Scaleform
local ClosestSlotModel
local AnimDict = 'anim_casino_a@amb@casino@games@slots@male'
local Sounds = {
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'no_win', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'small_win', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'big_win', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'jackpot', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'place_bet', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'place_max_bet', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'spinning', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'start_spin', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'wheel_stop_clunk', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'wheel_stop_on_prize', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'welcome_stinger', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'spin_wheel', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end,
    function() local SoundId = GetSoundId() PlaySoundFromCoord(SoundId, 'spin_wheel_win', ClosestSlotCoord, SlotReferences[ClosestSlotModel].sound, false, 20, false) ReleaseSoundId(SoundId) end
}
local Slots = {
    2362925439,
    2775323096,
    3863977906,
    654385216,
    161343630,
    1096374064,
    207578973,
    3807744938
}
local RandomEnter = {
    'enter_left',
    'enter_right',
    'enter_left_short',
    'enter_right_short'
}
local RandomLeave = {
    'exit_left',
    'exit_right'
}
local RandomIdle = {
    'base_idle_a',
    'base_idle_b',
    'base_idle_c',
    'base_idle_d',
    'base_idle_e',
    'base_idle_f'
}
local RandomSpin = {
    'press_spin_a',
    'press_spin_b',
    'pull_spin_a',
    'pull_spin_b'
}
local RandomSpinningIdle = {
    'spinning_a',
    'spinning_b',
    'spinning_c'
}
local RandomWin = {
    'win_a',
    'win_b',
    'win_c',
    'win_d',
    'win_e',
    'win_f',
    'win_g',
    'win_spinning_wheel'
}
local RandomLose = {
    'lose_a',
    'lose_b',
    'lose_c',
    'lose_d',
    'lose_e',
    'lose_f',
    'lose_cruel_a',
    'lose_cruel_b'
}
local RandomBigWin = {
    'win_big_a',
    'win_big_b',
    'win_big_c'
}
local RandomEnterMessage = {
    'Daring today?',
    'Spin to win',
    'You will lose money!',
    'Feelin lucky punk?!',
    'Test your might',
    'You have coins?'
}
local ChosenBetAmount = 1

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LoadAnimDict(dict) while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(0) end end

local function StartIdleScene(CurrentAnimation)
    Wait(GetAnimDuration(AnimDict, CurrentAnimation) * 800)
    local IdleScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
    LoadAnimDict(AnimDict)
    local RandomAnimName = RandomIdle[math.random(1, #RandomIdle)]
    NetworkAddPedToSynchronisedScene(PlayerPedId(), IdleScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
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
            SetTextRenderId(handle) -- Sets the render target to the handle we grab above
            SetScriptGfxDrawOrder(4)
            SetScriptGfxDrawBehindPausemenu(true)
            DrawScaleformMovie(Scaleform, 0.401, 0.09, 0.805, 0.195, 255, 255, 255, 255, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- Resets the render target
            Wait(0)
        end
    end)
end

local function SlotMachineHandler()
    local LeverScene = 0
    local IdleScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
    LoadAnimDict(AnimDict)
    local RandomAnimName = RandomIdle[math.random(1, #RandomIdle)]
    NetworkAddPedToSynchronisedScene(PlayerPedId(), IdleScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
    NetworkStartSynchronisedScene(IdleScene)
    exports['qb-core']:DrawText('<strong>Spin:</strong> ↵<br><strong>Leave: </strong>←<br><strong>Adjust Bet:</strong> ↑')
    CreateThread(function()
        while true do
            QBCore.Functions.TriggerCallback('doj:server:CasinoChipsAmount', function(result)
                exports['casinoUi']:DrawCasinoUi('show', "The Diamond Casino & Resort Slots</p>"..SlotReferences[ClosestSlotModel].name.."</p>Availble chips: "..math.floor(result))   
            end)
            if not IsSpinning then
                if IsControlJustPressed(0, 202) then -- BACKSPACE 
                    local LeaveScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                    LoadAnimDict(AnimDict)
                    RandomAnimName = RandomLeave[math.random(1, #RandomLeave)]
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), LeaveScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(LeaveScene)
                    Wait(GetAnimDuration(AnimDict, RandomAnimName) * 700)
                    NetworkStopSynchronisedScene(LeaveScene)
                    EnteredSlot = false
                    ShouldDrawScaleForm = false
                    exports['qb-core']:HideText()
                    exports['casinoUi']:HideCasinoUi('hide') 
                    CallScaleformMethod('SET_BET')
                    CallScaleformMethod('SET_LAST_WIN')
                    CallScaleformMethod('SET_MESSAGE', '')
                    TriggerServerEvent('dc-casino:slots:server:leave')
                    break
                elseif IsControlJustPressed(0, 201) then -- ENTER
                    local SpinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                    LoadAnimDict(AnimDict)
                    RandomAnimName = RandomSpin[math.random(1, #RandomSpin)]
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), SpinScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 1000.0, 0)
                    NetworkStartSynchronisedScene(SpinScene)
                    local AnimationDuration = GetAnimDuration(AnimDict, RandomAnimName)
                    if RandomAnimName == 'pull_spin_a' then
                        LeverScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                        N_0x45f35c0edc33b03b(LeverScene, GetEntityModel(ClosestSlot), ClosestSlotCoord, AnimDict, 'pull_spin_a_SLOTMACHINE', 2.0, -1.5, 13.0)
                        NetworkStartSynchronisedScene(LeverScene)
                        Wait(AnimationDuration * 320)
                    elseif RandomAnimName == 'pull_spin_b' then
                        LeverScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                        N_0x45f35c0edc33b03b(LeverScene, GetEntityModel(ClosestSlot), ClosestSlotCoord, AnimDict, 'pull_spin_b_SLOTMACHINE', 2.0, -1.5, 13.0)
                        NetworkStartSynchronisedScene(LeverScene)
                        Wait(AnimationDuration * 320)
                    end
                    Wait(AnimationDuration * 180)
                    Sounds[8]()
                    TriggerServerEvent('dc-casino:slots:server:spin', ChosenBetAmount)
                    Wait(AnimationDuration * 500)
                    local SpinningScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                    LoadAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), SpinningScene, AnimDict, RandomSpinningIdle[math.random(1, #RandomSpinningIdle)], 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(SpinningScene)
                    NetworkStopSynchronisedScene(LeverScene) --- Has to be stopped otherwise it will only work 50% of the time
                    FreezeEntityPosition(ClosestSlot, true)  --- N_0x45f35c0edc33b03b will prevent the machine being stuck to their position for some reason?
                elseif IsControlJustPressed(0, 172) then -- UP ARROW
                    Sounds[5]()
                    if not SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount + 1] then ChosenBetAmount = 1 else ChosenBetAmount = ChosenBetAmount + 1 end
                    local BetOneScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                    LoadAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), BetOneScene, AnimDict, 'press_betone_a', 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(BetOneScene)
                    Wait(GetAnimDuration(AnimDict, 'press_betone_a') * 200)
                    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
                    StartIdleScene('press_betone_a') 
                elseif IsControlJustPressed(0, 45) then -- R
                    Sounds[6]()
                    ChosenBetAmount = #SlotReferences[ClosestSlotModel].betamounts
                    local BetMaxScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
                    LoadAnimDict(AnimDict)
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), BetMaxScene, AnimDict, 'press_betmax_a', 2.0, -1.5, 13, 16, 2.0, 0)
                    NetworkStartSynchronisedScene(BetMaxScene)
                    Wait(GetAnimDuration(AnimDict, 'press_betmax_a') * 200)
                    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
                    StartIdleScene('press_betmax_a')
                elseif IsEntityDead(PlayerPedId()) then
                    EnteredSlot = false
                    ShouldDrawScaleForm = false
                    exports['qb-core']:HideText()
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
    while not RequestScriptAudioBank("dlc_vinewood/casino_slot_machines_01", 0) do Wait(0) end
    while not RequestScriptAudioBank("dlc_vinewood/casino_slot_machines_02", 0) do Wait(0) end
    while not RequestScriptAudioBank("dlc_vinewood/casino_slot_machines_03", 0) do Wait(0) end
	while true do
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Slots do
            Slot = GetClosestObjectOfType(PlayerCoords, 1.2, Slots[i], true)
            if Slot ~= 0 then
                SlotCoords = GetEntityCoords(Slot)
                local CurrentDistance = #(PlayerCoords - SlotCoords)
                if CurrentDistance < 1.9 and CurrentDistance < #(PlayerCoords - ClosestSlotCoord) then
                    NearbySlot = true
                    ClosestSlot = Slot
                    ClosestSlotCoord = SlotCoords
                    ClosestSlotForwardX = GetEntityForwardX(ClosestSlot)
                    ClosestSlotForwardY = GetEntityForwardY(ClosestSlot)
                    ClosestSlotModel = GetEntityModel(ClosestSlot)
                    ClosestSlotRotation = GetEntityRotation(ClosestSlot)
                    ReelLocation1 = GetObjectOffsetFromCoords(ClosestSlotCoord, GetEntityHeading(ClosestSlot), -0.115, 0.047, 0.906)
                    ReelLocation2 = GetObjectOffsetFromCoords(ClosestSlotCoord, GetEntityHeading(ClosestSlot), 0.005, 0.047, 0.906)
                    ReelLocation3 = GetObjectOffsetFromCoords(ClosestSlotCoord, GetEntityHeading(ClosestSlot), 0.125, 0.047, 0.906)
                end
            elseif #(PlayerCoords - ClosestSlotCoord) > 1.9 then
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
--             -- exports['qb-core']:DrawText('<b>Diamond Casino Slots</p></b>'..SlotReferences[ClosestSlotModel].name..'</p>Press [E] to sit</p>')
--             DrawText3D(ClosestSlotCoord.x - ClosestSlotForwardX, ClosestSlotCoord.y - ClosestSlotForwardY, ClosestSlotCoord.z + 1, "[E] - Play ~b~"..SlotReferences[ClosestSlotModel].name)
--             if IsControlJustReleased(0, 38) then

--                 QBCore.Functions.TriggerCallback('doj:server:HasCasinoMembership', function(HasItem)
--                     if HasItem then 
--                         local netID = NetworkGetEntityIsNetworked(ClosestSlot) and NetworkGetNetworkIdFromEntity(ClosestSlot)
--                         if not netID then
--                             NetworkRegisterEntityAsNetworked(ClosestSlot)
--                             netID = NetworkGetNetworkIdFromEntity(ClosestSlot)
--                             NetworkUseHighPrecisionBlending(netID, false)
--                             SetNetworkIdExistsOnAllMachines(netID, true) 
--                             SetNetworkIdCanMigrate(netID, true)
--                         end
--                         NetworkRequestControlOfEntity(ClosestSlot)
--                         TriggerServerEvent('dc-casino:slots:server:enter', netID, ReelLocation1, ReelLocation2, ReelLocation3)
--                     else
--                         QBCore.Functions.Notify('You are not a member of the casino!', 'error', 3500)
--                     end
--                 end)
--             end
--         -- elseif not NearbySlot then
--         --     exports["qb-core"]:HideText()
--         end
--         Wait(WaitTime)
--     end
-- end)
 


Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        if NearbySlot and not EnteredSlot then
            wait = 5
            local pedCo = GetEntityCoords(PlayerPedId())
            local dist = #(pedCo - ClosestSlotCoord)
            local inZone = false
            if dist <= 2.0 then
                wait = 5
                inZone  = true 
                text = '<b>The Diamond Casino & Resort</p>Slot: '..SlotReferences[ClosestSlotModel].name..'</b></p>Press <b>E</b> to sit'
                if IsControlJustPressed(0, 38) then
                    local netID = NetworkGetEntityIsNetworked(ClosestSlot) and NetworkGetNetworkIdFromEntity(ClosestSlot)
                    if not netID then
                        NetworkRegisterEntityAsNetworked(ClosestSlot)
                        netID = NetworkGetNetworkIdFromEntity(ClosestSlot)
                        NetworkUseHighPrecisionBlending(netID, false)
                        SetNetworkIdExistsOnAllMachines(netID, true)
                        SetNetworkIdCanMigrate(netID, true)
                    end
                    NetworkRequestControlOfEntity(ClosestSlot)
                    TriggerServerEvent('dc-casino:slots:server:enter', netID, ReelLocation1, ReelLocation2, ReelLocation3)
                end
            else
	            wait = 2000
            end
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                exports["qb-core"]:DrawText(text)  
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                exports["qb-core"]:HideText()
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent('dc-casino:slots:client:enter', function()
    local Ped = PlayerPedId()
    exports["qb-core"]:HideText()
    if GetEntityModel(Ped) == `mp_f_freemode_01` then AnimDict = 'anim_casino_a@amb@casino@games@slots@female' end
    local EnterScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
    LoadAnimDict(AnimDict)
    local RandomAnimName = RandomEnter[math.random(1, #RandomEnter)]
    NetworkAddPedToSynchronisedScene(Ped, EnterScene, AnimDict, RandomAnimName, 2.0, -1.5, 13, 16, 2.0, 0)
    NetworkStartSynchronisedScene(EnterScene)
    EnteredSlot = true
    ShouldDrawScaleForm = true
    SetupScaleform()
    Wait(GetAnimDuration(AnimDict, RandomAnimName) * 1000)
    CallScaleformMethod('SET_MESSAGE', RandomEnterMessage[math.random(1, #RandomEnterMessage)])
    CallScaleformMethod('SET_BET', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount])
    Sounds[11]()
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
    SetEntityVisible(Reel1, false)
    SetEntityVisible(Reel2, false)
    SetEntityVisible(Reel3, false)
    Sounds[7]()
    while GetGameTimer() < EndTime do
        SetEntityRotation(BlurryReel1, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
        if EndTime - GetGameTimer() > FirstReelStop then
            SetEntityRotation(BlurryReel2, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
            if EndTime - GetGameTimer() < FirstReelStop + 15 then
                if ReelRewards[2] == math.floor(ReelRewards[2]) then Sounds[9]() else Sounds[10]() end
                DeleteObject(BlurryReel2)
                SetEntityRotation(Reel2, ReelReward2, 0.0, SlotHeading, 2, true)
                SetEntityVisible(Reel2, true)
            end
            if EndTime - GetGameTimer() > SecondReelStop then
                SetEntityRotation(BlurryReel3, math.random(0, 15) * 22.5 + math.random(1, 60), 0.0, SlotHeading, 2, true)
                if EndTime - GetGameTimer() < SecondReelStop + 15 then
                    if ReelRewards[3] == math.floor(ReelRewards[3]) then Sounds[9]() else Sounds[10]() end
                    DeleteObject(BlurryReel3)
                    SetEntityRotation(Reel3, ReelReward3, 0.0, SlotHeading, 2, true)
                    SetEntityVisible(Reel3, true)
                end
            end
        end
        Wait(0)
    end
    DeleteObject(BlurryReel1)
    SetEntityRotation(Reel1, ReelReward1, 0.0, SlotHeading, 2, true)
    SetEntityVisible(Reel1, true)
    CallScaleformMethod('SET_LAST_WIN', SlotReferences[ClosestSlotModel].betamounts[ChosenBetAmount] * RewardMultiplier)
    if ReelRewards[1] == math.floor(ReelRewards[1]) then Sounds[9]() else Sounds[10]() end
    if RewardMultiplier == 0 then
        Sounds[1]()
        QBCore.Functions.Notify('You Lose', 'error', 3500)
        -- exports['qb-core']:DrawText('<b>You Lose</b>)
        local LoseScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
        LoadAnimDict(AnimDict)
        local RandomAnim = RandomLose[math.random(1, #RandomLose)]
        NetworkAddPedToSynchronisedScene(PlayerPedId(), LoseScene, AnimDict, RandomLose[math.random(1, #RandomLose)], 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(LoseScene)
        StartIdleScene(RandomAnim)
    elseif RewardMultiplier > 7 then
        if ReelReward1 == 5 and ReelReward2 == 5 and ReelReward3 == 5 then Sounds[4]() else Sounds[3]() end
        local BigWinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
        LoadAnimDict(AnimDict)
        local RandomAnim = RandomBigWin[math.random(1, #RandomBigWin)]
        NetworkAddPedToSynchronisedScene(PlayerPedId(), BigWinScene, AnimDict, RandomBigWin[math.random(1, #RandomBigWin)], 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(BigWinScene)
        StartIdleScene(RandomAnim)
    else
        Sounds[2]()
        local WinScene = NetworkCreateSynchronisedScene(ClosestSlotCoord, ClosestSlotRotation, 2, 2, 0, 1.0, 0, 1.0)
        LoadAnimDict(AnimDict)
        local RandomAnim = RandomWin[math.random(1, #RandomWin)]
        NetworkAddPedToSynchronisedScene(PlayerPedId(), WinScene, AnimDict, RandomAnim, 2.0, -1.5, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(WinScene)
        StartIdleScene(RandomAnim)
    end
    IsSpinning = false
end)

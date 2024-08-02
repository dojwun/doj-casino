
local Crates = {}
local minutes = 0
local seconds = 0
local NPCProp = nil
local PedSpawned = nil
local GumballZone = nil
local inZone = false

local function InteractWithGumball()
    lib.hideTextUI()
    if Config.SecretGumball.Machine.Payment == 'items' then
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Gumball Machine',
            speech = '1 Gumball for Both Memberships & '..Config.SecretGumball.Machine.Price..' Casino Chips', 
            duration = 1500,
            menuID = 'gumball-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Request Gumball',
                    selected = function()
                        TriggerServerEvent('doj:server:checkItemsForGumball', source)
                    end
                },
                {
                    key = 'X',
                    label = 'Nevermind',
                    selected = function(data)
                        exports['envi-interact']:UpdateSpeech('gumball-menu', 'Later...', 500)
                        exports['envi-interact']:CloseEverything()
                    end
                }
            }
        })
    elseif Config.SecretGumball.Machine.Payment == 'cash' then
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Gumball Machine',
            speech = '1 Gumball for $'..Config.SecretGumball.Machine.Price,
            duration = 1000,
            menuID = 'gumball-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Request Gumball',
                    selected = function()
                        TriggerServerEvent('doj:server:checkItemsForGumball', source)
                    end
                },
                {
                    key = 'X',
                    label = 'Nevermind',
                    selected = function(data)
                        exports['envi-interact']:UpdateSpeech('gumball-menu', 'Later...', 500)
                        exports['envi-interact']:CloseEverything()
                    end
                }
            }
        })
    end
end

local function RGBRainbow(frequency)
	local result = {}
	local curtime = GetGameTimer() / 1000
	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	return result
end

local function countTime()
    seconds = seconds - 1
    if seconds == 0 then
        seconds = 59
        minutes = minutes - 1
    end

    if minutes == -1 then
        minutes = 0
        seconds = 0
    end
    lib.showTextUI('Time To Loot: '..minutes..':'..seconds)
end

local function hasPlayerRunOutOfTime()
    return (minutes == 0 and seconds <= 1)
end

local function spawnGumballLoot()
    CreateThread(function()
        for k, v in pairs(Config.SecretGumball.Loot.Spawn) do
            local prop = 'xs_prop_arena_crate_01a'
            local rainbow = RGBRainbow(1)
            lib.RequestModel(prop)
            local crates = CreateObject(prop, v.Location.x, v.Location.y, v.Location.z - 1, false, true, false)
            SetEntityHeading(crates, v.Heading)
            PlaceObjectOnGroundProperly(crates)
            FreezeEntityPosition(crates, true)
            SetModelAsNoLongerNeeded(prop)
            if Config.SecretGumball.Loot.Highlight then 
                SetEntityDrawOutline(crates, true)
                SetEntityDrawOutlineColor(rainbow.r, rainbow.g, rainbow.b, 0)
            end
			Crates[#Crates+1] = crates
			exports['qb-target']:AddTargetModel(prop, {
				options = {
					{
						event = 'doj:client:OpenGumballCrate',
						icon = 'fa-solid fa-magnifying-glass',
						label = 'Search Crate',
					},
				},
				distance = 1.8
			})
		end
    end)
end

local function despawnGumballLoot()
    for _, v in pairs(Crates) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end
    exports.ox_target:removeLocalEntity(Crates, 'crates')
end

RegisterNetEvent('doj:client:GumballLocations', function()
    GumballSpawn = math.random(1, #Config.SecretGumball.MachineSpawns) 
    local rainbow = RGBRainbow(1)
    local prop = GetHashKey('prop_gumball_03')
    local prop2 = GetHashKey('bkr_prop_bkr_cash_scatter_03')
    GumballZone = lib.zones.box({
        coords = vec3(Config.SecretGumball.MachineSpawns[GumballSpawn].x, Config.SecretGumball.MachineSpawns[GumballSpawn].y, Config.SecretGumball.MachineSpawns[GumballSpawn].z),
        size = vec3(2, 2, 4),
        onEnter = function()
            lib.showTextUI('E - Interact')
        end,
        onExit = function()
            lib.hideTextUI()
        end,
        inside = function()
            if IsControlJustReleased(0, 38) then
                InteractWithGumball()
            end
        end,
        debug = false,
    })
	lib.RequestModel(prop)
    lib.RequestModel(prop2)
    NPCProp = CreateObject(prop, Config.SecretGumball.MachineSpawns[GumballSpawn].x, Config.SecretGumball.MachineSpawns[GumballSpawn].y, Config.SecretGumball.MachineSpawns[GumballSpawn].z - 1, true, false, true)
    NPCProp2 = CreateObject(prop2, Config.SecretGumball.MachineSpawns[GumballSpawn].x, Config.SecretGumball.MachineSpawns[GumballSpawn].y, Config.SecretGumball.MachineSpawns[GumballSpawn].z - 0.99, true, false, true)
    if Config.SecretGumball.Machine.Highlight then
        SetEntityDrawOutline(NPCProp, true)
        SetEntityDrawOutlineColor(rainbow.r, rainbow.g, rainbow.b, 0)
    end
    FreezeEntityPosition(NPCProp, true)
    SetEntityInvincible(NPCProp, true)
    PlaceObjectOnGroundProperly(NPCProp)
    PlaceObjectOnGroundProperly(NPCProp2)
    SetModelAsNoLongerNeeded(prop)
    SetModelAsNoLongerNeeded(prop2)
    return NPCProp, NPCProp2, GumballZone
end)

RegisterNetEvent('doj:client:acceptTradeForGumball', function()
    exports['envi-interact']:CloseEverything()
    local playerPed = cache.ped
    local animDict = 'mp_common'
    local animName = 'givetake1_a'
    lib.requestAnimDict(animDict)
    local Item = CreateObject(GetHashKey('sf_prop_sf_cash_pile_01'), 0, 0, 0, true, true, true) 
    TaskPlayAnim(playerPed, animDict, animName, 1.0, -1.0, 1000, 49, 0, false, false, false)
    AttachEntityToEntity(Item, playerPed, GetPedBoneIndex(playerPed, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    Wait(1000)
    DeleteObject(Item)
    TriggerServerEvent('doj:server:giveGumball')
    Wait(900)
    TriggerEvent('doj:client:RefreshZones')
end)

RegisterNetEvent('doj:client:OpenGumballCrate', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	for i=1, #Crates, 1 do
		if #(coords - GetEntityCoords(Crates[i])) < 2.0 then
			nearbyObject, nearbyID = Crates[i], i
		end
	end
	if nearbyObject and IsPedOnFoot(playerPed) then
        local success = lib.skillCheck(Config.SecretGumball.Loot.Skill.Difficulty, Config.SecretGumball.Loot.Skill.Inputs)
        if success then
            local OpenCrateTimer = math.random(2500, 5000)
            if lib.progressCircle({ duration = OpenCrateTimer, label = 'Searching Crate', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = false, move = true, }, anim = { dict = 'mini@repair', clip = 'fixing_a_ped' } }) then
                ClearPedTasks(PlayerPedId())
                SetEntityAsMissionEntity(nearbyObject, false, true)
                DeleteObject(nearbyObject)
                Crates[nearbyID] = nil
                TriggerServerEvent('doj:server:AddRandomGumballLoot')
            else
                ClearPedTasks(PlayerPedId())
                lib.notify({title = 'Action cancelled', type = 'error'})
            end
        else
            lib.notify({title = '!+*@_=? - Gumball', type = 'warning'})
        end
	end
end)


RegisterNetEvent('doj:client:RefreshZones', function()
    if GumballZone then
        GumballZone:remove()
    end
    if NPCProp then
        SetEntityDrawOutline(NPCProp, false)
        DeleteEntity(NPCProp)
        DeleteEntity(NPCProp2)
        NPCProp = nil
    end
    SetTimeout(Config.SecretGumball.Machine.RespawnAfterUse * 1000, function()
        TriggerEvent('doj:client:GumballLocations')
    end)
end)
-----------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if inZone then
            if hasPlayerRunOutOfTime() then
                SpawnBackToCasino()
            end
            countTime()
            if inZone == false then
                lib.hideTextUI()
            end
        end
    end
end)

local function StartFadingOut()
    local playerPed = cache.ped
    lib.requestAnimDict('timetable@gardener@smoking_joint')
    lib.playAnim(playerPed, 'timetable@gardener@smoking_joint', 'idle_cough', 1.0, -1.0, 2000, 49, 0, false, 0.0, false)
    Wait(2000)
    DoScreenFadeOut(500)
    Wait(500)
    DoScreenFadeIn(500)
    if not IsPedRagdoll(playerPed) and IsPedOnFoot(playerPed) then
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        SetPedToRagdollWithFall(playerPed, 1000, 2000, 1, GetEntityForwardVector(playerPed), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        Wait(1000)
        DoScreenFadeOut(500)
        Wait(1000)
        SecretLootLocation()
        Wait(1000)
        DoScreenFadeIn(500)
        if not PedSpawned then
            PedSpawned = true
            StartClonePed()
        end
    end
end

function SecretLootLocation()
    local playerPed = cache.ped
    minutes = Config.SecretGumball.Loot.Timer.Minutes
    seconds = Config.SecretGumball.Loot.Timer.Seconds
    inZone = true
    spawnGumballLoot()
    SetEntityCoords(playerPed, 1204.192, -2268.225, -47.177, false, false, false, false)
    lib.requestAnimDict('missheist_agency3astumble_getup')
    lib.playAnim(playerPed, 'missheist_agency3astumble_getup', 'stumble_getup', 1.0, -1.0, 2000, 0, 0, false, 0.0, false)
    lib.requestAnimSet('MOVE_M@DRUNK@VERYDRUNK')
    SetPedMovementClipset(playerPed, 'MOVE_M@DRUNK@VERYDRUNK', 1)
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
    ShakeGameplayCam('DRUNK_SHAKE', 2.0)
    AnimpostfxPlay('DrugsMichaelAliensFight', 0, true)
end

function SpawnBackToCasino()
    inZone = false
    PedSpawned = false
    local playerPed = cache.ped
    lib.showTextUI('Time expired')
    despawnGumballLoot()
    SetPedMoveRateOverride(playerPed, 1.0)
    SetRunSprintMultiplierForPlayer(playerPed, 1.0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(playerPed, 0.0)
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    if not IsPedRagdoll(playerPed) and IsPedOnFoot(playerPed) then
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
        SetPedToRagdollWithFall(playerPed, 1000, 2000, 1, GetEntityForwardVector(playerPed), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        Wait(1000)
        DoScreenFadeOut(500)
        Wait(1000)
        if EvilPed then
            DeletePed(EvilPed)
        end
        SetEntityCoords(playerPed, 924.268, 59.659, 111.335, false, false, false, false)
        lib.requestAnimDict('missheist_agency3astumble_getup')
        lib.playAnim(playerPed, 'missheist_agency3astumble_getup', 'stumble_getup', 1.0, -1.0, 2000, 0, 0, false, 0.0, false)
        Wait(750)
        DoScreenFadeIn(500)
        AnimpostfxStop('DrugsMichaelAliensFight')
    end
end

local function TrackPlayer()
    while true do
        local dist = #(GetEntityCoords(cache.ped) - GetEntityCoords(EvilPed))
        if dist > 5.0 then
            TaskGoToEntity(EvilPed, cache.ped, -1, 4.0, 100.0, 1073741824, 0)
            Wait(1000)
        else
            if not IsTaskMoveNetworkActive(EvilPed) then
                lib.requestAnimDict("anim@mp_point")
                TaskMoveNetworkByName(EvilPed, "task_mp_pointing", 0.5, true, "anim@mp_point", 24)
                SetPedCurrentWeaponVisible(EvilPed, true, false, false, false)
                SetPedConfigFlag(EvilPed, 36, false)
            end
            if not LastPedTurn or (GetGameTimer() - LastPedTurn) > 1000 then
                LastPedTurn = GetGameTimer()
                TaskTurnPedToFaceEntity(EvilPed, cache.ped, -1)
            end
            SetTaskMoveNetworkSignalFloat (EvilPed, "Pitch",          0.4)
            SetTaskMoveNetworkSignalFloat (EvilPed, "Heading",        0.5)
            SetTaskMoveNetworkSignalBool  (EvilPed, "isBlocked",      false)
            SetTaskMoveNetworkSignalBool  (EvilPed, "isFirstPerson",  false)
            if IsPedRagdoll(EvilPed) then
                while IsPedRagdoll(EvilPed) do Wait(0); end
                ClearPedTasksImmediately(EvilPed)
                Wait(10)
            end
            Wait(0)
        end
    end
end

function StartClonePed()
    EvilPed = ClonePed(cache.ped, true, false, false)
    SetEntityAlpha(EvilPed, 100, false)
    SetEntityCoordsNoOffset(EvilPed, 1211.474, -2275.694, -49.0, false, false, true)
    SetPedComponentVariation(EvilPed, 1, 155, 0, 0)
    SetEntityInvincible(EvilPed,true)
    SetBlockingOfNonTemporaryEvents(EvilPed,true)
    TrackPlayer()
    return EvilPed
end

RegisterNetEvent('doj:client:consumeGumball', function()
    local gumballItem = CreateObject(GetHashKey('prop_paper_ball'), 0, 0, 0, true, true, true)
    local playerPed = cache.ped
    lib.requestAnimDict('mp_suicide')
    lib.playAnim(playerPed, 'mp_suicide', 'pill', 1.0, -1.0, 2000, 49, 0, false, 0.0, false)
    Wait(1300)
    AttachEntityToEntity(gumballItem, playerPed, GetPedBoneIndex(playerPed, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    Wait(700)
    DeleteObject(gumballItem)
    StartFadingOut()
end)

RegisterNetEvent('doj:client:KillGumballZones', function()
    if GumballZone then
        GumballZone:remove()
    end
    if NPCProp then
        SetEntityDrawOutline(NPCProp, false)
        DeleteEntity(NPCProp)
        DeleteEntity(NPCProp2)
        NPCProp = nil
    end
    if EvilPed then
        DeletePed(EvilPed)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if cache.resource ~= resource then return end
    TriggerEvent('doj:client:KillGumballZones')
end)

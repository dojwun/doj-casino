local QBCore = exports['qb-core']:GetCoreObject()
local UsedSlots = {}
local Slots = {}

local function table_matches(t1, t2)
	local type1, type2 = type(t1), type(t2)
	if type1 ~= type2 then return false end
	if type1 ~= 'table' and type2 ~= 'table' then return t1 == t2 end

	for k1,v1 in pairs(t1) do
	   local v2 = t2[k1]
	   if v2 == nil or not table_matches(v1,v2) then return false end
	end

	for k2,v2 in pairs(t2) do
	   local v1 = t1[k2]
	   if v1 == nil or not table_matches(v1,v2) then return false end
	end
	return true
end

local function LeaveSlot(source)
    if not Slots[source] then return end
    if DoesEntityExist(Slots[source].Reel1) then DeleteEntity(Slots[source].Reel1) end
    if DoesEntityExist(Slots[source].Reel2) then DeleteEntity(Slots[source].Reel2) end
    if DoesEntityExist(Slots[source].Reel3) then DeleteEntity(Slots[source].Reel3) end
    UsedSlots[Slots[source].SlotNetID] = false
    Slots[source] = {}
end

RegisterNetEvent('dc-casino:slots:server:enter', function(netID, ReelLocation1, ReelLocation2, ReelLocation3)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerCoords = GetEntityCoords(GetPlayerPed(src))
    local SlotEntity = NetworkGetEntityFromNetworkId(netID)
    local SlotModel = GetEntityModel(SlotEntity)
    local SlotCoords = GetEntityCoords(SlotEntity)

    if not SlotReferences[SlotModel] then return end
    if #(PlayerCoords - SlotCoords) > 4 then return end
    if #(SlotCoords - ReelLocation1) > 2 or #(SlotCoords - ReelLocation2) > 2 or #(SlotCoords - ReelLocation2) > 2 then return end
    if UsedSlots[netID] then return end

    UsedSlots[netID] = true
    TriggerClientEvent('dc-casino:slots:client:enter', src)
    SetTimeout(1000, function()
        local ReelEntity1 = CreateObject(SlotReferences[SlotModel].reela, ReelLocation1, true, false, false)
        local ReelEntity2 = CreateObject(SlotReferences[SlotModel].reela, ReelLocation2, true, false, false)
        local ReelEntity3 = CreateObject(SlotReferences[SlotModel].reela, ReelLocation3, true, false, false)
        while not DoesEntityExist(ReelEntity1) do Wait(0) end
        while not DoesEntityExist(ReelEntity2) do Wait(0) end
        while not DoesEntityExist(ReelEntity3) do Wait(0) end
        Slots[src] = {
            Slot = NetworkGetEntityFromNetworkId(netID),
            SlotNetID = netID,
            Reel1 = ReelEntity1,
            Reel2 = ReelEntity2,
            Reel3 = ReelEntity3,
            ReelLoc1 = ReelLocation1,
            ReelLoc2 = ReelLocation2,
            ReelLoc3 = ReelLocation3,
        }
        FreezeEntityPosition(Slots[src].Reel1, true)
        FreezeEntityPosition(Slots[src].Reel2, true)
        FreezeEntityPosition(Slots[src].Reel3, true)
        local SlotHeading = GetEntityHeading(SlotEntity)
        SetEntityRotation(Slots[src].Reel1, 0.0, 0.0, SlotHeading, 2, 1)
        SetEntityRotation(Slots[src].Reel2, 0.0, 0.0, SlotHeading, 2, 1)
        SetEntityRotation(Slots[src].Reel3, 0.0, 0.0, SlotHeading, 2, 1)
        -- TriggerEvent('qb-log:server:CreateLog', 'casino', 'Casino Slots', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Entered a slot | Slot NetID %s | Slot Locations %s | Reel Locations %s %s %s | Player Location %s | Slot Model %s",
        -- GetPlayerName(src), Player.PlayerData.citizenid, src, netID, SlotCoords, ReelLocation1, ReelLocation2, ReelLocation3, PlayerCoords, SlotModel))
    end)
end)

RegisterNetEvent('dc-casino:slots:server:spin', function(ChosenBetAmount)
    local src = source
    local SpinTime = math.random(4000, 6000)
    local ReelRewards = {math.random(0, 15), math.random(0, 15), math.random(0, 15)}
    local SlotHeading = GetEntityHeading(Slots[src].Slot)
    local SlotModel = GetEntityModel(Slots[src].Slot)
    local Player = QBCore.Functions.GetPlayer(src)

    if not Slots[src] then return end
    if not SlotReferences[SlotModel].betamounts[ChosenBetAmount] then return end
    if UseCash and Player.Functions.RemoveMoney('cash', SlotReferences[SlotModel].betamounts[ChosenBetAmount], 'Casino Slot Spin')
    or UseBank and Player.Functions.RemoveMoney('bank', SlotReferences[SlotModel].betamounts[ChosenBetAmount], 'Casino Slot Spin')
    -- luacheck: ignore
    or UseItem and Player.Functions.RemoveItem(ItemName, SlotReferences[SlotModel].betamounts[ChosenBetAmount]) then TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_goldchip'], "remove", ChosenBetAmount)

    else TriggerClientEvent('QBCore:Notify', src, 'Nothing left to bet with', 'error') return end

    for i = 1, #ReelRewards do
        if SlotReferences[SlotModel].misschance > math.random(1, 100) then ReelRewards[i] = ReelRewards[i] + math.random(4, 6) / 10 end
    end
    local BlurryReel1 = CreateObject(SlotReferences[SlotModel].reelb, Slots[src].ReelLoc1, true, false, false)
    local BlurryReel2 = CreateObject(SlotReferences[SlotModel].reelb, Slots[src].ReelLoc2, true, false, false)
    local BlurryReel3 = CreateObject(SlotReferences[SlotModel].reelb, Slots[src].ReelLoc3, true, false, false)
    while not DoesEntityExist(BlurryReel1) do Wait(0) end
    while not DoesEntityExist(BlurryReel2) do Wait(0) end
    while not DoesEntityExist(BlurryReel3) do Wait(0) end
    FreezeEntityPosition(BlurryReel1, true)
    FreezeEntityPosition(BlurryReel2, true)
    FreezeEntityPosition(BlurryReel3, true)
    SetEntityRotation(BlurryReel1, 0.0, 0.0, SlotHeading, 2, 1)
    SetEntityRotation(BlurryReel2, 0.0, 0.0, SlotHeading, 2, 1)
    SetEntityRotation(BlurryReel3, 0.0, 0.0, SlotHeading, 2, 1)
    local RewardMultiplier = 0
    for k, v in pairs(Rewards) do
        if table_matches(k, ReelRewards) then
            RewardMultiplier = v
            break
        end
    end
    if RewardMultiplier == 0 then
        for i = 1, #ReelRewards do
            if ReelRewards[i] == 4 or ReelRewards[i] == 11 or ReelRewards[i] == 15 then
                RewardMultiplier = RewardMultiplier + 1
            end
        end
        RewardMultiplier = SpecialReward[RewardMultiplier] or 0
    end
    TriggerClientEvent('dc-casino:slots:client:spinreels', src, SpinTime, ReelRewards, NetworkGetNetworkIdFromEntity(BlurryReel1), NetworkGetNetworkIdFromEntity(BlurryReel2), NetworkGetNetworkIdFromEntity(BlurryReel3), NetworkGetNetworkIdFromEntity(Slots[src].Reel1), NetworkGetNetworkIdFromEntity(Slots[src].Reel2), NetworkGetNetworkIdFromEntity(Slots[src].Reel3), RewardMultiplier)
    SetTimeout(SpinTime, function()
        local RewardAmount = SlotReferences[SlotModel].betamounts[ChosenBetAmount] * RewardMultiplier
        -- TriggerEvent('qb-log:server:CreateLog', 'casino', 'Casino Slots', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Spinned a casino slot for %s and won %s",
        -- GetPlayerName(src), Player.PlayerData.citizenid, src, SlotReferences[SlotModel].betamounts[ChosenBetAmount], RewardAmount))
        if RewardMultiplier == 0 then return end
        if UseCash and Player.Functions.AddMoney('cash', RewardAmount, 'Casino Slot Spin')
        or UseBank and Player.Functions.AddMoney('bank', RewardAmount, 'Casino Slot Spin')
        -- luacheck: ignore
        or UseItem and Player.Functions.AddItem(ItemName, RewardAmount) then 
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_goldchip'], "add", RewardAmount) 
            -- TriggerClientEvent('QBCore:Notify', src, 'You won '..tonumber(RewardAmount)..' chips!', 'success')
        end
    end)
end)

RegisterNetEvent('dc-casino:slots:server:leave', function()
    LeaveSlot(source)
end)

AddEventHandler("playerDropped", function()
    LeaveSlot(source)
end)

-- PerformHttpRequest('https://api.github.com/repos/Disabled-Coding/dc-casino/releases/latest', function(_, resultData, _)
--     if not resultData then print('Failed to check for updates') return end
--     local result = json.decode(resultData)
--     if GetResourceMetadata(GetCurrentResourceName(), 'version') ~= result.tag_name then
--         print('New version of '..GetCurrentResourceName()..' is available!')
--     end
-- end)

local ItemList = {
    ["casino_goldchip"] = 1
}
QBCore.Functions.CreateCallback('doj:server:CasinoChipsAmount', function(source, cb)
    local retval = 0
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    retval = retval + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                end
            end
        end
    end
    cb(retval) 
end)

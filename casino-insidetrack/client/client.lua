
local QBCore = exports['qb-core']:GetCoreObject()

local cooldown = 60
local tick = 0
local checkRaceStatus = false
local insideTrackActive = false
local gameOpen = false

local function OpenInsideTrack()

    exports['envi-interact']:UpdateSpeech("insideTrack-menu", 'Good Luck!', 500)

    QBCore.Functions.TriggerCallback("insidetrack:server:getbalance", function(balance)
        Utils.PlayerBalance = balance
    end)
    if insideTrackActive then
        return
    end
    insideTrackActive = true
    -- Scaleform
    Utils.Scaleform = lib.requestScaleformMovie('HORSE_RACING_CONSOLE')
    DisplayHud(false)
    SetPlayerControl(cache.ped, false, 0)
    lib.requestAudioBank('DLC_VINEWOOD\\CASINO_GENERAL')
    Utils:ShowMainScreen()
    Utils:SetMainScreenCooldown(cooldown)
    -- Add horses
    Utils:AddHorses()
    Utils:DrawInsideTrack()
    Utils:HandleControls()
end

RegisterNetEvent("doj:casinoInsideTrack", function()
    lib.hideTextUI()
    local HasItem = exports.ox_inventory:GetItemCount("casino_member")
	if HasItem >= 1 then
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino InsideTrack',
            speech = 'Hi, Are you ready to place some bets?', 
            duration = 1000,
            menuID = 'insideTrack-menu',
            position = 'right',
            options = {
                { 
                    key = 'E',
                    label = 'Place Bets',
                    selected = function()
                        OpenInsideTrack()
                    end
                },
                {
                    key = 'X',
                    label = 'Leave',
                    selected = function(data)
                        exports['envi-interact']:CloseEverything()
                    end
                }
            } 
        })
    else
        exports['envi-interact']:OpenChoiceMenu({
            title = 'Diamond Casino InsideTrack (unavailable)',
            speech = 'You are not a member of the casino, Please go visit the front desk.',
            duration = 2000,
            menuID = 'insideTrack-menu-denied',
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

function CloseHorseBets()
    insideTrackActive = false
    SetPlayerControl(cache.ped, true, 0)
    SetScaleformMovieAsNoLongerNeeded(Utils.Scaleform)
    Utils.Scaleform = -1
    StopSound(0)
end

local function LeaveInsideTrack()
    insideTrackActive = false
    SetPlayerControl(cache.ped, true, 0)
    SetScaleformMovieAsNoLongerNeeded(Utils.Scaleform)
    Utils.Scaleform = -1
    StopSound(0)
end



RegisterNetEvent('QBCore:client:closeBetsNotEnough')
AddEventHandler('QBCore:client:closeBetsNotEnough', function()
    CloseHorseBets()
    exports['envi-interact']:UpdateSpeech("insideTrack-menu", 'Bets Closed! You dont have enough Casino Chips...', 1500)
    exports['envi-interact']:CloseEverything()
end)

RegisterNetEvent('QBCore:client:closeBetsZeroChips')
AddEventHandler('QBCore:client:closeBetsZeroChips', function()
    CloseHorseBets()
    exports['envi-interact']:UpdateSpeech("insideTrack-menu", 'Bets Closed! You dont have any Casino Chips...', 1500)
    exports['envi-interact']:CloseEverything()
end)





function Utils:DrawInsideTrack()
    CreateThread(function()
        while insideTrackActive do
            Wait(0)
            local xMouse, yMouse = GetDisabledControlNormal(2, 239), GetDisabledControlNormal(2, 240)
            -- Fake cooldown
            tick = (tick + 10)
            if (tick == 1000) then
                if (cooldown == 1) then
                    cooldown = 60
                end
                cooldown = (cooldown - 1)
                tick = 0
                Utils:SetMainScreenCooldown(cooldown)
            end
            -- Mouse control
            BeginScaleformMovieMethod(Utils.Scaleform, 'SET_MOUSE_INPUT')
            ScaleformMovieMethodAddParamFloat(xMouse)
            ScaleformMovieMethodAddParamFloat(yMouse)
            EndScaleformMovieMethod()
            -- Draw
            DrawScaleformMovieFullscreen(Utils.Scaleform, 255, 255, 255, 255)
        end
    end)
end

function Utils:HandleControls()
    CreateThread(function()
        while insideTrackActive do
            Wait(0)


            if IsControlJustPressed(2, 194) then
                LeaveInsideTrack()
            end

            if IsControlJustPressed(2, 202) then
                LeaveInsideTrack()
            end

            -- Left click
            if IsControlJustPressed(2, 237) then
                local clickedButton = Utils:GetMouseClickedButton()
 
                if Utils.ChooseHorseVisible then
                    if (clickedButton ~= 12) and (clickedButton ~= -1) then
                        if Utils.PlayerBalance < Utils.CurrentBet then
                            Utils.CurrentBet = math.floor(Utils.PlayerBalance / 100) * 100
                        end
                        Utils.CurrentHorse = (clickedButton - 1)
                        Utils:ShowBetScreen(Utils.CurrentHorse)
                        Utils.ChooseHorseVisible = false
                    end
                end

                -- Rules button
                if (clickedButton == 15) then
                    Utils:ShowRules()
                end

                -- Close buttons
                if (clickedButton == 12) then
                    if Utils.ChooseHorseVisible then
                        Utils.ChooseHorseVisible = false
                    end
                    
                    if Utils.BetVisible then
                        Utils:ShowHorseSelection()
                        Utils.BetVisible = false
                        Utils.CurrentHorse = -1
                    else
                        Utils:ShowMainScreen()
                    end
                end

                -- Start bet
                if (clickedButton == 1) then
                    Utils:ShowHorseSelection()
                end

                -- Start race
                if (clickedButton == 10) then
                    PlaySoundFrontend(-1, 'race_loop', 'dlc_vw_casino_inside_track_betting_single_event_sounds')
                    TriggerServerEvent("insidetrack:server:placebet", Utils.CurrentBet)
                    Utils:StartRace()
                    checkRaceStatus = true
                end

                -- Change bet
                if (clickedButton == 8) then
                    if (Utils.CurrentBet < Utils.PlayerBalance - 100) then
                        Utils.CurrentBet = (Utils.CurrentBet + 100)
                        Utils.CurrentGain = (Utils.CurrentBet * 2)
                        Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)
                    end
                end

                if (clickedButton == 9) then
                    if (Utils.CurrentBet > 100) then
                        Utils.CurrentBet = (Utils.CurrentBet - 100)
                        Utils.CurrentGain = (Utils.CurrentBet * 2)
                        Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)
                    end
                end

                if (clickedButton == 13) then
                    Utils:ShowMainScreen()
                end

                -- Check race
                while checkRaceStatus do
                    Wait(0)
                    local raceFinished = Utils:IsRaceFinished()
                    if (raceFinished) then
                        StopSound(0)
                        if (Utils.CurrentHorse == Utils.CurrentWinner) then
                            TriggerServerEvent("insidetrack:server:winnings", Utils.CurrentGain)
                        end
                        QBCore.Functions.TriggerCallback("insidetrack:server:getbalance", function(balance)
                            Utils.PlayerBalance = balance
                        end)
                        Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)
                        Utils:ShowResults()
                        Utils.CurrentHorse = -1
                        Utils.CurrentWinner = -1
                        Utils.HorsesPositions = {}
                        checkRaceStatus = false
                    end
                end
            end
        end
    end)
end


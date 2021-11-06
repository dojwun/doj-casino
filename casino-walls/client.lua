local inCasino              = false
local videoWallRenderTarget = nil
local showBigWin            = false
local spinningObject = nil
local spinningCar = nil
--
-- Threads
--



function startCasinoThreads()
    RequestStreamedTextureDict('Prop_Screen_Vinewood')
    while not HasStreamedTextureDictLoaded('Prop_Screen_Vinewood') do
        Citizen.Wait(100)
    end
    RegisterNamedRendertarget('casinoscreen_01')
    LinkNamedRendertarget(`vw_vwint01_video_overlay`)
    videoWallRenderTarget = GetNamedRendertargetRenderId('casinoscreen_01')
    Citizen.CreateThread(function()
        local lastUpdatedTvChannel = 0
        while true do
            Citizen.Wait(0)

            if not inCasino then
                ReleaseNamedRendertarget('casinoscreen_01')

                videoWallRenderTarget = nil
                showBigWin            = false

                break
            end
            if videoWallRenderTarget then
                local currentTime = GetGameTimer()
                if showBigWin then
                    setVideoWallTvChannelWin()
                    lastUpdatedTvChannel = GetGameTimer() - 33666
                    showBigWin           = false
                else
                    if (currentTime - lastUpdatedTvChannel) >= 42666 then
                        setVideoWallTvChannel()
                        lastUpdatedTvChannel = currentTime
                    end
                end
                SetTextRenderId(videoWallRenderTarget)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawInteractiveSprite('Prop_Screen_Vinewood', 'BG_Wall_Colour_4x4', 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            end
        end
    end)
end


function setVideoWallTvChannel()
    SetTvChannelPlaylist(0, Config.AnimatedWallNormal, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(0)
end

function setVideoWallTvChannelWin()
    SetTvChannelPlaylist(0, Config.AnimatedWallWin, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(-1)
    SetTvChannel(0)
end

--
-- Events
--

AddEventHandler("chCasinoWall:enteredCasino", function()
  inCasino = true
  if Config.SetAnimatedWalls then
    startCasinoThreads()
  end
  if Config.SetShowCarOnDisplay then
    spinMeRightRoundBaby()
  end
  if Config.PlayCasinoAmbientNoise then
    playSomeBackgroundAudioBaby()      
  end
end)

AddEventHandler("chCasinoWall:exitedCasino", function()
    inCasino = false
end)

RegisterNetEvent('chCasinoWall:bigWin')
AddEventHandler('chCasinoWall:bigWin', function()
    if not inCasino then
        return
    end

    showBigWin = true
end)


function enterCasino()
  InCasino = true
  TriggerEvent("chCasinoWall:enteredCasino") 
  print("Entered Casino area")
  
  if Config.SendWelcomeMail then
    TriggerServerEvent('qb-phone:server:sendNewMail', {
      sender = Config.WelcomeMailsender,
      subject = Config.WelcomeMailsubject,
      message = Config.WelcomeMailmessage,
      button = {}
    })
  end
end

function exitCasino()
  TriggerEvent("chCasinoWall:exitedCasino")
  print("Exited Casino area")
  InCasino = false
  StopAudioScene("DLC_VW_Casino_General")
  Wait(5000)
  startCasinoThreads()
end

CreateThread(function()
  local casinoCoords = vector3(945.85, 41.58, -170.50)
  while true do
    local pCoords = GetEntityCoords(PlayerPedId())
        if #(pCoords - casinoCoords) < 250.0 then
            if not inCasino then
                enterCasino()
            end
        else
      if inCasino then
        exitCasino()
      end
    end
    Wait(1000)
  end
end)

function spinMeRightRoundBaby()
	Citizen.CreateThread(function()
	    while inCasino do
		if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
		  spinningObject = GetClosestObjectOfType(935.432, 42.5611, 72.14, 10.0, -1561087446, 0, 0, 0)
		  drawCarForWins()
		end
		if spinningObject ~= nil and spinningObject ~= 0 then
		  local curHeading = GetEntityHeading(spinningObject)
		  local curHeadingCar = GetEntityHeading(spinningCar)
		  if curHeading >= 360 then
			curHeading = 0.0
			curHeadingCar = 0.0
		  elseif curHeading ~= curHeadingCar then
			curHeadingCar = curHeading
		  end
		  SetEntityHeading(spinningObject, curHeading + 0.075)
		  SetEntityHeading(spinningCar, curHeadingCar + 0.075)
		end
		Wait(0)
	  end
	  spinningObject = nil
	end)
end

function drawCarForWins()
	if DoesEntityExist(spinningCar) then
	  DeleteEntity(spinningCar)
	end
	RequestModel(Config.VehicleOnDisplay)
	while not HasModelLoaded(Config.VehicleOnDisplay) do
		Citizen.Wait(0)
	end
	SetModelAsNoLongerNeeded(Config.VehicleOnDisplay)
	spinningCar = CreateVehicle(Config.VehicleOnDisplay, 935.432, 42.5611, 72.14, 0.0, 0, 0)
	Wait(0)
	SetVehicleDirtLevel(spinningCar, 0.0)
	SetVehicleOnGroundProperly(spinningCar) 
	Wait(0)
	FreezeEntityPosition(spinningCar, 1)
end

function playSomeBackgroundAudioBaby()
	Citizen.CreateThread(function()
	  local function audioBanks()
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
		  Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
		  Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
		  Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
		  Citizen.Wait(0)
		end
	  end
	  audioBanks()
	  while inCasino do
		if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
		  PlayStreamFromPosition(945.85, 41.58, 75.82)
		end
		if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
		  StartAudioScene("DLC_VW_Casino_General")
		end
		Citizen.Wait(1000)
	  end
	  if IsStreamPlaying() then
		StopStream()
	  end
	  if IsAudioSceneActive("DLC_VW_Casino_General") then
		StopAudioScene("DLC_VW_Casino_General")
	  end
	end)
end

-- Casino
local Casino= { 
  {950.214, 33.151, 70.839 ,"enter",57.052,0xBB0D72F5,"U_F_M_CasinoCash_01"}, --Casino Cashier
  {955.619, 70.179, 69.433 ,"insidetrack",190.937,579932932,"S_M_Y_Doorman_01"}, --Horse Bets 
}

Citizen.CreateThread(function()
  for _,v in pairs(Casino) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end

    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)

--=============================================== added
-- Lucky wheel
exports['qb-target']:AddCircleZone("LuckyWheel", vector3(949.391, 44.72, 71.638), 2.0, {
    name="LuckyWheel",
    heading=160,
    debugPoly=false,
    useZ=true,
    }, {
        options = {
            {
                event = "luckywheel:client:startWheel",
                icon = "fas fa-sync-alt",
                label = "Try Your Luck",
            },
        },
    distance = 2.0 
})

-- Horse Bets
exports['qb-target']:AddCircleZone("Betting", vector3(956.121,70.185,70.433), 1.0, {
    name="Betting",
    heading=160,
    debugPoly=false,
    useZ=true,
}, {
    options = {
        {
            event = "QBCore:client:openInsideTrack",
            icon = "fas fa-coins",
            label = "Start Betting",
        },
    },
    distance = 3.0 
})

-- Casino Shop
exports['qb-target']:AddTargetModel(`U_F_M_CasinoCash_01`, {
	options = {
        { 
            event = "doj:casinoChipMenu",
            icon = "fas fa-exchange-alt",
            label = "Exchange Casino Chips", 
        },
        {
            event = "qb-casino:client:openCasinoChips",
            icon = "fas fa-coins",
            label = "Purchase Casino Chips", 
        },
        {
            event = "qb-casino:client:openCasinoMembersips", 
            icon = "fas fa-id-card",
            label = "Purchase Casino Memberships", 
        },
	},
	distance = 3.0 
})

RegisterNetEvent('qb-casino:client:openCasinoMembersips')
AddEventHandler('qb-casino:client:openCasinoMembersips', function()
    local ShopItems = {}
    ShopItems.label = "Diamond Casino Memberships"
    ShopItems.items = Config.CasinoMemberships
    ShopItems.slots = #Config.CasinoMemberships
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_", ShopItems)
end)

RegisterNetEvent('qb-casino:client:openCasinoChips')
AddEventHandler('qb-casino:client:openCasinoChips', function()
    local ShopItems = {} 
    ShopItems.label = "Diamond Casino Chips"
    ShopItems.items = Config.CasinoChips
    ShopItems.slots = #Config.CasinoChips
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_", ShopItems)
end)

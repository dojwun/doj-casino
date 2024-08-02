
local inCasino              = false
local videoWallRenderTarget = nil
local showBigWin            = false
local spinningObject = nil
local spinningCar

local function CasinoPeds(model, coords, heading, scenario)
	lib.RequestModel(GetHashKey(model))
	CasinoNpcs = CreatePed(0, GetHashKey(v.model), coords, heading, false, true)
	FreezeEntityPosition(CasinoNpcs, true)
	SetEntityInvincible(CasinoNpcs, true)
	SetBlockingOfNonTemporaryEvents(CasinoNpcs, true)
	TaskStartScenarioInPlace(CasinoNpcs, scenario, 0, true)
  SetModelAsNoLongerNeeded(CasinoNpcs)
end

function StartCasinoThreads()
  RequestStreamedTextureDict('Prop_Screen_Vinewood', false)
  while not HasStreamedTextureDictLoaded('Prop_Screen_Vinewood') do
      Wait(100)
  end
  RegisterNamedRendertarget('casinoscreen_01', false)
  LinkNamedRendertarget(`vw_vwint01_video_overlay`)
  videoWallRenderTarget = GetNamedRendertargetRenderId('casinoscreen_01')
  CreateThread(function()
      local lastUpdatedTvChannel = 0
      while true do
          Wait(0)
          if not inCasino then
              ReleaseNamedRendertarget('casinoscreen_01')
              videoWallRenderTarget = nil
              showBigWin = false
              break
          end
          if videoWallRenderTarget then
              local currentTime = GetGameTimer()
              if showBigWin then
                  SetVideoWallTvChannelWin()
                  lastUpdatedTvChannel = GetGameTimer() - 33666
                  showBigWin = false
              else
                  if (currentTime - lastUpdatedTvChannel) >= 42666 then
                      SetVideoWallTvChannel()
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

function SetVideoWallTvChannel()
  SetTvChannelPlaylist(0, Config.Casino.Animated.Normal, true)
  SetTvAudioFrontend(true)
  SetTvVolume(-100.0)
  SetTvChannel(0)
end

function SetVideoWallTvChannelWin()
  SetTvChannelPlaylist(0, Config.Casino.Animated.Win, true)
  SetTvAudioFrontend(true)
  SetTvVolume(-100.0)
  SetTvChannel(-1)
  SetTvChannel(0)
end

AddEventHandler("chCasinoWall:enteredCasino", function()
  inCasino = true
  if Config.Casino.Animated.Walls then
    StartCasinoThreads()
  end
  if Config.ShowCar.Display then
    SpinMeRightRoundBaby()
  end
  if Config.Casino.AmbientNoise then
    PlaySomeBackgroundAudioBaby()
  end
  if Config.SecretGumball.Enable then
    TriggerEvent('doj:client:GumballLocations')
  end
end)

AddEventHandler("chCasinoWall:exitedCasino", function()
  inCasino = false
end)

RegisterNetEvent('chCasinoWall:bigWin', function()
  if not inCasino then
    return
  end
  showBigWin = true
end)

function EnterCasino()
  InCasino = true
  TriggerEvent("chCasinoWall:enteredCasino")
end

function ExitCasino()
  InCasino = false
  TriggerEvent("chCasinoWall:exitedCasino")
  TriggerEvent("doj:client:KillGumballZones")
  StopAudioScene("DLC_VW_Casino_General")
end

function SpinMeRightRoundBaby()
	CreateThread(function()
	    while inCasino do
		if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
		  spinningObject = GetClosestObjectOfType(935.432, 42.5611, 72.14, 10.0, -1561087446, true, true, true)
		  DrawCarForWins()
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

function DrawCarForWins()
	if DoesEntityExist(spinningCar) then
	  DeleteEntity(spinningCar)
	end
  for i = 1, #Config.ShowCar do
    local v = Config.ShowCar[i]
    lib.RequestModel(v.model)
    SetModelAsNoLongerNeeded(v.model)
    spinningCar = CreateVehicle(v.model, 935.432, 42.5611, 72.34, 0.0, true, true)
    SetVehicleDirtLevel(spinningCar, 0.0)
    SetVehicleOnGroundProperly(spinningCar)
    FreezeEntityPosition(spinningCar, true)
    SetVehicleModKit(spinningCar, 0)
    SetVehicleColours(spinningCar, v.colors[1], v.colors[2])
    SetVehicleExtraColours(spinningCar, v.extraColors[1], v.extraColors[2])
    SetVehicleWindowTint(spinningCar, v.Tint)
    SetVehicleLights(spinningCar, v.ToggleLights)
    ToggleVehicleMod(spinningCar, 22, true)
    SetVehicleXenonLightsColor(spinningCar, v.XenonColor)
    SetVehicleInteriorColor(spinningCar, v.intColor)
    SetVehicleExtra(spinningCar, v.extra)
    SetVehicleExtra(spinningCar, v.extra2)
    if v.neons then
        SetVehicleNeonLightsColour(spinningCar, v.neons[1], v.neons[2], v.neons[3])
        for i = 0, 3 do
            SetVehicleNeonLightEnabled(spinningCar, i, true)
        end
    end
    if v.livery then
        SetVehicleMod(spinningCar, 48, v.livery, false)
        SetVehicleLivery(spinningCar, v.livery)
    end
    for mod, id in pairs(v.modKits) do
        SetVehicleMod(spinningCar, mod, id - 1, false)
    end
    SetVehicleNumberPlateText(spinningCar, "DIAMOND")
  end
end


function PlaySomeBackgroundAudioBaby()
	CreateThread(function()
	  local function audioBanks()
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false) do
        Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false) do
        Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false) do
        Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false) do
        Wait(0)
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
      Wait(1000)
	  end
	  if IsStreamPlaying() then
		  StopStream()
	  end
	  if IsAudioSceneActive("DLC_VW_Casino_General") then
		  StopAudioScene("DLC_VW_Casino_General")
	  end
	end)
end



RegisterNetEvent("doj:client:CreateCasinoZones", function()
  if Peds.AmbientPeds then
    for k = 1, #Peds.PedList, 1 do
        v = Peds.PedList[k]
        CasinoPeds(v.model, v.coords, v.heading, v.scenario)
    end
  end
  CreateThread(function()
      lib.zones.box({
          coords = vec3(945.85, 41.58, 66.239),
          size = vec3(125, 100, 15),
          onEnter = function()
            EnterCasino()
          end,
          onExit = function()
            ExitCasino()
          end,
          inside = function()
          end,
      })
  end)
end)



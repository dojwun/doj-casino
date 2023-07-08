

Utils = {
    Scaleform = -1,
    ChooseHorseVisible = false,
    BetVisible = false,
    HorseStyles = {
    {15553363,5474797,9858144,4671302},
    {16724530,3684408,14807026,16777215},
    {13560920,15582764,16770746,7500402},
    {16558591,5090807,10446437,7493977},
    {5090807,16558591,3815994,9393493},
    {16269415,16767010,10329501,16777215},
    {2263807,16777215,9086907,3815994},
    {4879871,16715535,3815994,16777215},
    {16777215,2263807,16769737,15197642},
    {16338779,16777215,11166563,6974058},
    {16777215,16559849,5716493,3815994},
    {16760644,3387257,16701597,16777215},
    {6538729,2249420,16777215,3815994},
    {15913534,15913534,16304787,15985375},
    {15655629,16240452,16760474,13664854},
    {16320263,16777215,14920312,16773316},
    {7176404,15138618,6308658,13664854},
    {4879871,8453903,11382189,15724527},
    {16777215,16777215,16754809,16777215},
    {16732497,16732497,3815994,16777215},
    {5739220,5739220,11382189,15724527},
    {16712909,6935639,8742735,3877137},
    {2136867,16777215,16761488,3877137},
    {3118422,10019244,14932209,6121086},
    {2136867,10241979,8081664,3815994},
    {16769271,13724403,9852728,14138263},
    {13724403,16769271,6444881,14138263},
    {10017279,4291288,16304787,15985375},
    {1071491,4315247,14935011,6121086},
    {3861944,16627705,14932209,6121086},
    {15583546,4671303,11836798,3090459},
    {15567418,4671303,9985296,3815994},
    {5701417,16711680,16771760,6970713},
    {16760303,5986951,12353664,15395562},
    {8907670,2709022,9475214,4278081},
    {5429688,6400829,16777215,16773316},
    {15138618,5272210,14920312,16773316},
    {10241979,12396337,14920312,15395562},
    {16777215,13481261,13667152,3815994},
    {5077874,16777215,15444592,7820105},
    {10408040,2960685,7424036,10129549},
    {7754308,16777215,12944259,3815994},
    {16736955,16106560,16771760,6970713},
    {16106560,16770224,16767659,15843765},
    {9573241,14703194,9789279,3815994},
    {44799,14703194,10968156,16777215},
    {7143224,16753956,10975076,4210752},
    {7895160,4013373,5855577,11645361},
    {16075595,6869196,13530742,7105644},
    {16090955,6272992,16777215,16777215},
    {13313356,13313356,5849409,11623516},
    {13911070,5583427,14935011,6121086},
    {8604661,10408040,12944259,3815994},
    {9716612,2960685,16767659,6708313},
    {7806040,16777215,16765601,14144436},
    {15632075,11221989,16777215,16770037},
    {1936722,14654697,16763851,3815994},
    {10377543,3815994,14807026,16777215},
    {16775067,11067903,16770746,7500402},
    {16741712,8669718,16777215,16777215},
    {16515280,6318459,3815994,9393493},
    {65526,16515280,10329501,16777215},
    {16711680,4783925,3815994,3815994},
    {65532,4783925,16766671,15197642},
    {16760303,16760303,3815994,14207663},
    {16770048,16770048,3815994,3815994},
    {16737792,16737792,11166563,6974058},
    {12773119,12773119,5716493,3815994},
    {16777215,16763043,16701597,16777215},
    {6587161,6587161,16777215,3815994},
    {6329328,16749602,3815994,3815994},
    {15793920,16519679,14920312,15395562},
    {15466636,10724259,16760474,13664854},
    {11563263,327629,6308658,13664854},
    {58867,16777215,16754809,8082236},
    {4909311,16777215,5849409,11623516},
    {3700643,7602233,9852728,14138263},
    {16777215,1017599,8742735,3877137},
    {16772022,16772022,16761488,3877137},
    {7849983,5067443,8081664,3815994},
    {15913534,7602233,6444881,14138263},
    {12320733,16775618,11836798,3090459},
    {15240846,16777215,9985296,3815994},
    {14967137,3702939,3815994,14207663},
    {6343571,3702939,12353664,15395562},
    {16761374,15018024,9475214,4278081},
    {16743936,3756172,16777215,16773316},
    {2899345,5393472,16777215,4210752},
    {11645361,16777215,16771542,10123632},
    {3421236,5958825,16771542,3815994},
    {15851871,5395026,15444592,7820105},
    {16777215,9463517,7424036,10129549},
    {16760556,16733184,16767659,15843765},
    {4781311,15771930,16765601,14144436},
    {16760556,10287103,16767659,6708313},
    {13083490,16777215,9789279,3815994},
    {13810226,9115524,5855577,11645361},
    {14176336,9115524,13530742,7105644},
    {16770310,16751169,16772294,16777215}
    },
    PlayerBalance = 500,
    CurrentHorse = -1,
    CurrentBet = 100,
    CurrentGain = 1000,
    HorsesPositions = {},
    CurrentWiner = -1
}




function Utils:GetMouseClickedButton()
    local returnValue = -1

    CallScaleformMovieMethodWithNumber(self.Scaleform, 'SET_INPUT_EVENT', 237.0, -1082130432, -1082130432, -1082130432, -1082130432)
    BeginScaleformMovieMethod(self.Scaleform, 'GET_CURRENT_SELECTION')

    returnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(returnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueInt(returnValue)
end

function Utils.GetRandomHorseName()
    local random = math.random(0, 99)
    local randomName = (random < 10) and ('ITH_NAME_00'..random) or ('ITH_NAME_0'..random)
    
    return randomName
end

-- int param :
-- 0 = main
-- 1 = choose a horse
-- 2 = choose a horse (2)
-- 3 = select a bet
-- 4 = select a bet (2)
-- 5 = race screen (frozen)
-- 6 = photo finish (frozen)
-- 7 = results
-- 8 = same as main but a bit different
-- 9 = rules
function Utils:ShowMainScreen()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(Utils.Scaleform, 'SET_MAIN_EVENT_IN_PROGRESS')
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(Utils.Scaleform, 'CLEAR_ALL')
    EndScaleformMovieMethod()
end

---@param cooldown int
---(in seconds).
function Utils:SetMainScreenCooldown(cooldown)
    BeginScaleformMovieMethod(self.Scaleform, 'SET_COUNTDOWN')
    ScaleformMovieMethodAddParamInt(cooldown)
    EndScaleformMovieMethod()
end

function Utils:SetNotAvailable()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_ERROR')

    BeginTextCommandScaleformString('IT_ERROR_TITLE')
    EndTextCommandScaleformString()

    BeginTextCommandScaleformString('IT_ERROR_MSG')
    EndTextCommandScaleformString()

    EndScaleformMovieMethod()
end

local function IsPositionAvailable(position)
    for i = 1, #Utils.HorsesPositions do
        if (Utils.HorsesPositions[i] == position) then
            return false
        end
    end

    return true
end

local function GenerateHorsesOrder()
    while (#Utils.HorsesPositions < 6) do
        Wait(0)

        for i = 1, 6 do
            local randomPos = math.random(6)

            if IsPositionAvailable(randomPos) then
                table.insert(Utils.HorsesPositions, randomPos)
            end
        end
    end
end

function Utils:StartRace()
    GenerateHorsesOrder()

    self.CurrentWinner = self.HorsesPositions[1]

    BeginScaleformMovieMethod(self.Scaleform, 'START_RACE')
    ScaleformMovieMethodAddParamFloat(15000.0) -- Race duration (in MS)
    ScaleformMovieMethodAddParamInt(4)

    -- Add each horses by their index (win order)
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[1])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[2])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[3])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[4])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[5])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[6])

    ScaleformMovieMethodAddParamFloat(0.0) -- Unk
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function Utils:IsRaceFinished()
    BeginScaleformMovieMethod(Utils.Scaleform, 'GET_RACE_IS_COMPLETE')

    local raceReturnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(raceReturnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueBool(raceReturnValue)
end

function Utils:ShowResults()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(7)
    EndScaleformMovieMethod()
end

function Utils:ShowRules()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(9)
    EndScaleformMovieMethod()
end

function Utils:ShowHorseSelection()
    self.ChooseHorseVisible = true

    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()
end

function Utils:AddHorses()
    for i = 1, 6 do
        local name = self.GetRandomHorseName()

        BeginScaleformMovieMethod(self.Scaleform, 'SET_HORSE')
        ScaleformMovieMethodAddParamInt(i) -- Horse index

        -- Horse name
        BeginTextCommandScaleformString(name)
        EndTextCommandScaleformString()

        ScaleformMovieMethodAddParamPlayerNameString('Cool Horse')

        -- Horse style
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][1])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][2])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][3])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][4])
        EndScaleformMovieMethod()
    end
end

local function IsPositionAvailable(position)
    for i = 1, #Utils.HorsesPositions do
        if (Utils.HorsesPositions[i] == position) then
            return false
        end
    end

    return true
end

local function GenerateHorsesOrder()
    while (#Utils.HorsesPositions < 6) do
        Wait(0)

        for i = 1, 6 do
            local randomPos = math.random(6)

            if IsPositionAvailable(randomPos) then
                table.insert(Utils.HorsesPositions, randomPos)
            end
        end
    end
end

function Utils:StartRace()
    GenerateHorsesOrder()

    self.CurrentWinner = self.HorsesPositions[1]

    BeginScaleformMovieMethod(self.Scaleform, 'START_RACE')
    ScaleformMovieMethodAddParamFloat(15000.0) -- Race duration (in MS)
    ScaleformMovieMethodAddParamInt(4)

    -- Add each horses by their index (win order)
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[1])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[2])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[3])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[4])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[5])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[6])

    ScaleformMovieMethodAddParamFloat(0.0) -- Unk
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function Utils:IsRaceFinished()
    BeginScaleformMovieMethod(Utils.Scaleform, 'GET_RACE_IS_COMPLETE')

    local raceReturnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(raceReturnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueBool(raceReturnValue)
end

function Utils:ShowResults()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(7)
    EndScaleformMovieMethod()
end

function Utils:ShowRules()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(9)
    EndScaleformMovieMethod()
end

function Utils:ShowBetScreen(horse)
    self:UpdateBetValues(horse, self.CurrentBet, self.PlayerBalance, self.CurrentGain)

    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.Scaleform, 'SET_BETTING_ENABLED')
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()

    self.BetVisible = true
end

function Utils:UpdateBetValues(horse, bet, balance, gain)
    BeginScaleformMovieMethod(self.Scaleform, 'SET_BETTING_VALUES')
    ScaleformMovieMethodAddParamInt(horse) -- Horse index

    ScaleformMovieMethodAddParamInt(bet) -- Bet
    ScaleformMovieMethodAddParamInt(balance) -- Current balance
    ScaleformMovieMethodAddParamInt(gain) -- Gain
    EndScaleformMovieMethod()
end
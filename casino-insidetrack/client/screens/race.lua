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
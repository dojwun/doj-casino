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
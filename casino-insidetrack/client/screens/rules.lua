function Utils:ShowRules()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(9)
    EndScaleformMovieMethod()
end
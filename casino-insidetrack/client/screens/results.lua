function Utils:ShowResults()
    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(7)
    EndScaleformMovieMethod()
end
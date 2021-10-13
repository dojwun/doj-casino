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
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
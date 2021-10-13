RegisterNetEvent('casinoUi:ShowUI')
AddEventHandler('casinoUi:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('casinoUi:HideUI')
AddEventHandler('casinoUi:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

function DrawCasinoUi(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end

function HideCasinoUi()
	SendNUIMessage({
		action = 'hide'
	})
end

-- RegisterCommand('test', function()
-- 	exports['casinoUi']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Balance: $5000Test</br>Bet: 10000Test") 
--     Wait(3700)
-- 	exports['casinoUi']:HideCasinoUi('hide') 
-- end, false)



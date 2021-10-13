RegisterNetEvent('drawtextui:ShowUI')
AddEventHandler('drawtextui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('drawtextui:HideUI')
AddEventHandler('drawtextui:HideUI', function()

	SendNUIMessage({
		action = 'hide'
	})
end)

function DrawTextUi(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end

function HideTextUi()
	SendNUIMessage({
		action = 'hide'
	})
end



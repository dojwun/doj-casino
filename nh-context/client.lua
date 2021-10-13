local server = false

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    if server then
        TriggerServerEvent(data.event, data.args)
    else
        TriggerEvent(data.event, data.args)
    end
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)

RegisterNetEvent('nh-context:closeMenu', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE_MENU",
        data = data
    })
end)


RegisterNetEvent('nh-context:sendMenu', function(data, toServer)
    if not data then return end
    if toServer then server = true end    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)


-- RegisterCommand('test', function()
--     TriggerEvent('nh-context:sendMenu', {
--         {
--             id = 1,
--             header = "Diamond Casino Blackjack",
--             txt = ""
--         },
--     })
--     Wait(3700)
-- 	TriggerEvent("nh-context:closeMenu")
-- end, false)
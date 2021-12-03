
CreateThread(function()
    local TeleportUpZone = CircleZone:Create(vector3(930.251, 34.324, 81.089), 1.5, {
        name="TeleportUp",
        heading=328.0,
        debugPoly=false,
        useZ=true,
    })
    TeleportUpZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            TriggerEvent("doj:casinoTeleportUp")
        else
			exports['qb-menu']:closeMenu()
        end
    end)
end)

CreateThread(function()
    local TeleportDownZone = CircleZone:Create(vector3(964.737, 58.743, 112.553), 1.5, {
        name="TeleportDown",
        heading=328.0,
        debugPoly=false,
        useZ=true,
    })
    TeleportDownZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            TriggerEvent("doj:casinoTeleportDown")
        else
			exports['qb-menu']:closeMenu()
        end
    end)
end)

RegisterNetEvent('doj:casinoTeleports', function(args)
    local args = tonumber(args)
    local ped = PlayerPedId()
    if args == 1 then 
        SetEntityCoords(ped, 965.0619, 58.51287, 112.553, false, false, false, true)
    else
        SetEntityCoords(ped, 930.0716, 33.86854, 81.09772, false, false, false, true)
    end
end)

RegisterNetEvent('doj:casinoTeleportUp', function()
    exports['qb-menu']:showHeader({
        {
            header = "Diamond Casino Elevators",
            isMenuHeader = true,
        },
        {
            header = "Elevator Up", 
            txt = "Roof access",
            params = {
                event = "doj:casinoTeleports",
                args = 1,
            }
        },
        {
            header = "return",
			txt = "",
			params = {
                event = "doj:casinoTeleportUp"
            }
        },
    })
end)

RegisterNetEvent('doj:casinoTeleportDown', function()
    exports['qb-menu']:showHeader({
        {
            header = "Diamond Casino Elevators",
            isMenuHeader = true,
        },
        {
            header = "Elevator Down", 
            txt = "Main Lobby",
            params = {
                event = "doj:casinoTeleports",
                args = 2,
            }
        },
        {
            header = "return",
			txt = "",
			params = {
                event = "doj:casinoTeleportDown"
            }
        },
    })
end)

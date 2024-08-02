-- Credit for elevators https://github.com/GouveiaXS/angelicxs-elevators

CreateThread(function()
    for elevatorName, elevatorFloors in pairs(Config.Elevators) do
        for index, floor in pairs(elevatorFloors) do
            CreateThread(function()
                while true do
                    local sleep = 2000
                    local playerCoords = GetEntityCoords(cache.ped)
                    local distance = #(playerCoords - floor.position)
                    if distance <= 3.0 then
                        sleep = 0
                        qbx.drawText3d({text = "Press ~b~E~w~ to use Elevator From " .. floor.level, coords = vec3(floor.position.x,floor.position.y,floor.position.z)})
                        if distance <= 1.5 and IsControlJustReleased(0, 38) then
                            local data = {}
                            data.elevator = elevatorName
                            data.level = index
                            TriggerEvent('angelicxs_elevator:showFloors', data)
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    end
end)

RegisterNetEvent("angelicxs_elevator:showFloors", function(data)
	local elevator = {}
	local floor = {}
	for index, floor in pairs(Config.Elevators[data.elevator]) do
        table.insert(elevator, {
            title = floor.level,
            description = floor.label,
            onSelect = function()
                TriggerEvent("angelicxs_elevator:movement", floor)
            end
        })
	end
    lib.registerContext({
        id = 'angelicxs-elevator_ox',
        options = elevator,
        title = data.elevator,
        position = 'top-right',
    }, function(selected, scrollIndex, args)
    end)
    lib.showContext('angelicxs-elevator_ox')
end)

RegisterNetEvent("angelicxs_elevator:movement", function(arg)
	local floor = arg
	local ped = cache.ped
	DoScreenFadeOut(1500)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	RequestCollisionAtCoord(floor.position.x, floor.position.y, floor.position.z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Wait(0)
	end
	SetEntityCoords(ped, floor.position.x, floor.position.y, floor.position.z, false, false, false, false)
	SetEntityHeading(ped, floor.heading and floor.heading or 0.0)
	Wait(2*1000)
	DoScreenFadeIn(1500)
end)















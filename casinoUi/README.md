# INSTALLATION GUIDE
**1.** Clone the repository or Code > Download zip
 
**2.** Add the resource to your server start config: `ensure cd_drawtextui`. The name of the folder must be `cd_drawtextui` or the resource will not function correctly.

## How to use?
This can be triggered from the server or client. A more advanced example is posted below.
|Show the UI| Hide the UI |
|--|--|
| `Triggerevent('cd_drawtextui:ShowUI', 'show', TEXT_HERE)` | `Triggerevent('cd_drawtextui:HideUI')` |


> **This is an example how to implement the UI for a single location.**

    Citizen.CreateThread(function()
	    local alreadyEnteredZone = false
	    local text = nil
	    while true do
	        wait = 5
	        local ped = PlayerPedId()
	        local inZone = false
	        local dist = #(GetEntityCoords(ped)-vector3(0,0,0))
	        if dist <= 5.0 then
	            wait = 5
	            inZone  = true
	            text = '<b>Title</b></p>[E] Press E to be bald'

	            if IsControlJustReleased(0, 38) then
	                TriggerEvent('add your event here')
	            end
	        else
	            wait = 2000 
	        end
	        
	        if inZone and not alreadyEnteredZone then
	            alreadyEnteredZone = true
	            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
	        end

	        if not inZone and alreadyEnteredZone then
	            alreadyEnteredZone = false
	            TriggerEvent('cd_drawtextui:HideUI')
	        end
	        Citizen.Wait(wait)
	    end
	end)

> **This is an example how to implement the UI while doing a for loop for multiple locations in 1 thread.**

    Citizen.CreateThread(function()
        local alreadyEnteredZone = false
        local text = nil
        while true do
            wait = 5
            local ped = PlayerPedId()
            local inZone = false
            for cd = 1, #Config.YOURTABLE do
                local dist = #(GetEntityCoords(ped)-vector3(Config.YOURTABLE.x, Config.YOURTABLE.y, Config.YOURTABLE.z))
                if dist <= 5.0 then
                    wait = 5
                    inZone  = true
                    text = '<b>Title</b></p>[E] Press E to be bald'
    
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('add your event here')
                    end
                    break
                else
                    wait = 2000
                end
            end
            
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
            end
    
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                TriggerEvent('cd_drawtextui:HideUI')
            end
            Citizen.Wait(wait)
        end
    end)




## Is the resource not working as expected?
- Make sure the name of the folder is `cd_drawtextui`.
- Check the server console and the in game F8 console for errors.
- If all else fails, contact the Codesign Team in the [Codesign Discord](https://discord.gg/HmDFGp62Tr).

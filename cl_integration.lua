local Blip1 = nil;

RegisterCommand('dl', function(source, args)
    RemoveBlip(Blip1)
    Blip1= nil
end)

RegisterNetEvent("drawRoute")
AddEventHandler("drawRoute", function(x, y)
        print(x,y)
        if(Blip1) then
            RemoveBlip(Blip1)
            Blip1= nil
        end
        Blip1 = AddBlipForCoord(x,y,0)
        SetBlipSprite(Blip1, config.blip.sprite)
        SetBlipColour(Blip1, config.blip.color)
        SetBlipRouteColour(Blip1, config.blip.color)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(config.blip.blipText)
        EndTextCommandSetBlipName(Blip1)
        deleteBlip(x, y)
        --print("Here2")
end)

RegisterNetEvent("drawRoutePanic")
AddEventHandler("drawRoutePanic", function(x, y)
        --print(x,y)
        if(Blip1) then
            RemoveBlip(Blip1)
            Blip1= nil
        end
        Blip1 = AddBlipForCoord(x,y,0)
        SetBlipSprite(Blip1, config.blip_panic.sprite)
        SetBlipColour(Blip1, config.blip_panic.color)
        SetBlipRouteColour(Blip1, config.blip_panic.color)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(config.blip_panic.blipText)
        EndTextCommandSetBlipName(Blip1)
        deleteBlip(x, y)
        --print("Here2")
end)

function deleteBlip(callX, callY)
    Citizen.CreateThread(function()
        --print(callX, callY)
        --print("Here1")
            while Blip1 do
                local x, y = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                -- if blip exists
                if Blip1 then
                    local dm = GetDistanceBetweenCoords(x,y,0, callX,callY,0) -- distance
                    if dm < config.blip.distToDelete then
                        -- delete blip if close
                        RemoveBlip(Blip1)
                        Blip1= nil
                    end
                end
                Wait(100)
            end
            --print("Here3")
    end)
end

RegisterNetEvent("notify")
AddEventHandler("notify", function(call, number)
        tempNum = "~r~" .. number .. "~r~"
        tempCall = "~r~".. call .. "~r~"
        temp = "New Call Assignment " .. tempNum .. "~w~ For ~w~" .. tempCall
		drawNotification("CHAR_CALL911", 0, temp , "Ottawa Communications Center", "RocketCad")		
end)

RegisterNetEvent("notifyPanic")
AddEventHandler("notifyPanic", function(call, number)
        tempNum = "~w~ Cst. " .. number .. "~w~"
        tempCall = "~w~ ".. call .. "~w~"
        temp = "~r~Panic Button Pressed By~r~ " .. tempNum .. tempCall
		drawNotification("CHAR_CALL911", 0, temp , "Ottawa Communications Center", "RocketCad")		
end)

function drawNotification(picture, icon, message, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage(picture, picture, true, icon, title, subtitle)
end

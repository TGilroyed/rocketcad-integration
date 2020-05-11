local Blip1 = nil;
-- Time is in Miliseconds
local waitTime = 60000;

-- USED FOR AUTO LOCATION
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        x, y, z = table.unpack(GetEntityCoords(ped, true))
        lastStreet, lastCross = GetStreetNameAtCoord(x, y, z)
        lastStreetName = GetStreetNameFromHashKey(lastStreet)
        lastCrossStreet = GetStreetNameFromHashKey(lastCross)
        TriggerServerEvent("autolocationUpdate", lastStreetName, lastCrossStreet, ped)
        Citizen.Wait(waitTime)
    end
end)
--

-- USED FOR CAD --
RegisterCommand('dl', function(source, args)
    RemoveBlip(Blip1)
    Blip1= nil
end)

RegisterNetEvent("drawRoute")
AddEventHandler("drawRoute", function(x, y)
        if(Blip1) then
            RemoveBlip(Blip1)
            Blip1= nil
        end
        Blip1 = AddBlipForCoord(x,y,0)
        SetBlipSprite(Blip1, 148)
        SetBlipColour(Blip1,9)
        SetBlipRouteColour(Blip1, 9)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Current Call)
        EndTextCommandSetBlipName(Blip1)
        deleteBlip(x, y)
end)

RegisterNetEvent("drawRoutePanic")
AddEventHandler("drawRoutePanic", function(x, y)
        if(Blip1) then
            RemoveBlip(Blip1)
            Blip1= nil
        end
        Blip1 = AddBlipForCoord(x,y,0)
        SetBlipSprite(Blip1, 487)
        SetBlipColour(Blip1, 1)
        SetBlipRouteColour(Blip1, 1)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Panic Alert)
        EndTextCommandSetBlipName(Blip1)
        deleteBlip(x, y)
end)

function deleteBlip(callX, callY)
    Citizen.CreateThread(function()
            while Blip1 do
                local x, y = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                -- if blip exists
                if Blip1 then
                    local dm = GetDistanceBetweenCoords(x,y,0, callX,callY,0) -- distance
                    if dm < 40 then
                        -- delete blip if close
                        RemoveBlip(Blip1)
                        Blip1= nil
                    end
                end
                Wait(100)
            end
    end)
end

RegisterNetEvent("alert1")
AddEventHandler("alert1", function()
	drawNotification("CHAR_CALL911", 0, config.alert.alert1 , config.blip.name, "New Alert")
end)

RegisterNetEvent("alert2")
AddEventHandler("alert2", function()
    drawNotification("CHAR_CALL911", 0, config.alert.alert2 , config.blip.name, "New Alert")
end)

RegisterNetEvent("notify")
AddEventHandler("notify", function(call, number)
        tempNum = "~r~" .. number .. "~r~"
        tempCall = "~r~".. call .. "~r~"
        temp = "New Call Assignment " .. tempNum .. "~w~ For ~w~" .. tempCall
		drawNotification("CHAR_CALL911", 0, temp , config.blip.name, "RocketCAD")
end)

RegisterNetEvent("notifyPanic")
AddEventHandler("notifyPanic", function(call, number)
        tempNum = "~w~ Cst. " .. number .. "~w~"
        tempCall = "~w~ ".. call .. "~w~"
        temp = "~r~Panic Button Pressed By~r~ " .. tempNum .. tempCall
		drawNotification("CHAR_CALL911", 0, temp , config.blip.name, "RocketCAD")
end)

function drawNotification(picture, icon, message, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage(picture, picture, true, icon, title, subtitle)
end

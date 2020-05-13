local Blip1 = nil;

RegisterCommand('dl', function(source, args)
    RemoveBlip(Blip1)
    Blip1= nil
end)

RegisterCommand("plate", function(source, args)
    local plate = args[1]
    local id = NetworkGetNetworkIdFromEntity(GetPlayerPed(-1))
    TriggerServerEvent("plateRunner", id, plate)
end, false)

RegisterNetEvent("plateRunnerC")
AddEventHandler("plateRunnerC", function(plateIn, model, flagID)
    local plate = string.upper(plateIn)
    local flag = "~g~No Flags Found~g~"
    local insur = "~g~Insured~g~"
    local regis = "~g~Registered~g~"
    local isClear = 0;
    for key,value in pairs(flagID) do
        if value == 1 then
            isClear = 1
            flag = "~g~No Flags Found~g~"
        elseif value == 2 then
            insur = "~o~No Insurance~o~"
        elseif value == 3 then
            regis = "~o~No Registration~o~"
        elseif value == 4 then
            flag = "~r~Stolen~r~"
        end
    end

    tempModel = "~w~MODEL : ~w~" .. "~b~"..model.. "~b~"
    tempPlate = "~w~PLATE : ~w~" .. "~b~"..plate.. "~b~"
    tempFlag = "~w~FLAGS : ~w~" .. flag

    if isClear == 1 then
        temp = tempPlate .. "\n" .. tempModel .. "\n" .. tempFlag
        drawNotification("CHAR_CALL911", 0, temp , config.settings.name, "RocketCAD")
    else
        tempRegis = "~w~REGISTRATION : ~w~" .. regis
        tempInsur = "~w~INSURANCE : ~w~" .. insur
        temp = tempPlate .. "\n" .. tempModel
        temp1 = tempRegis .. "\n" .. tempInsur .. "\n" .. tempFlag
        drawNotification("CHAR_CALL911", 0, temp , config.settings.name, "RocketCAD")

        SetNotificationTextEntry('STRING')
        AddTextComponentString(temp1)
        DrawNotification(false, true)
    end
end)

RegisterNetEvent("drawRoute")
AddEventHandler("drawRoute", function(x, y)
        print(x,y)
        if(Blip1) then
            RemoveBlip(Blip1)
            Blip1= nil
        end
        Blip1 = AddBlipForCoord(x,y,0)
        SetBlipSprite(Blip1, 148)
        SetBlipColour(Blip1, 9)
        SetBlipRouteColour(Blip1, 9)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("Current Call")
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
        SetBlipSprite(Blip1, 487)
        SetBlipColour(Blip1, 1)
        SetBlipRouteColour(Blip1, 1)
        SetBlipScale(Blip1, 1.2)
        SetBlipRoute(Blip1, true)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("Panic Alert")
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
                    if dm < 40 then
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
		drawNotification("CHAR_CALL911", 0, temp , config.settings.name, "RocketCAD")
end)

RegisterNetEvent("notifyPanic")
AddEventHandler("notifyPanic", function(call, number)
        tempNum = "~w~ Cst. " .. number .. "~w~"
        tempCall = "~w~ ".. call .. "~w~"
        temp = "~r~Panic Button Pressed By~r~ " .. tempNum .. tempCall
		drawNotification("CHAR_CALL911", 0, temp , config.settings.name, "RocketCAD")
end)

function drawNotification(picture, icon, message, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage(picture, picture, true, icon, title, subtitle)
end

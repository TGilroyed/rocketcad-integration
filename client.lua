-- Time is in Miliseconds 
local waitTime = 5000;

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

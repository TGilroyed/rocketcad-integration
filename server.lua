--------------------------------------------------------
------   DO NOT CHANGE THIS VALUE -----
local cadURL = 'https://therocketcad.com/'
--------------------------------------------------------

RegisterServerEvent("autolocationUpdate")
AddEventHandler("autolocationUpdate", function(street, cross, pedin)
    local steamIdentifier
    local players = GetPlayers()

    for _, player in ipairs(players) do
        local ped = GetPlayerPed(player)
        local identifiers = GetPlayerIdentifiers(player)

        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        if ped == pedin then
            break
        end
    end
    PerformHttpRequest(cadURL.."/api/1.1/wf/fivem_locationping", function(err, text, headers)
end, 'POST', json.encode({Street = street, Cross = cross, Hex = steamIdentifier}), { ["Content-Type"] = 'application/json' })
        CancelEvent()
end)
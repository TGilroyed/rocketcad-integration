local cadURL = 'https://therocketcad.com/'

function findPed(hex)
    --print(hex)
    local players = GetPlayers()
    for _, player in ipairs(players) do
        local ped = GetPlayerPed(player)
        local identifiers = GetPlayerIdentifiers(player)

        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                if v == hex then;
                    return player;
                end
            end
        end
    end
end

SetHttpHandler(function(req,res)
    local v=req.path;
    
    if req.method=='POST'then 
        print("post");
    end;
    
    req.setDataHandler(function(body)
        local decomp=json.decode(body)
        if decomp == nil then 
            res.send(json.encode({test = 'ERROR NO JSON BODY'}))
        end
        local x = decomp.callX
        local y = decomp.callY
        local number = decomp.Number
        local call = decomp.Call;
        local hex = decomp.Hex;

        if GetNumPlayerIndices() == 0 then 
            res.send("ERROR: No online players")
        else 
            local foundPed = findPed(hex)
            if req.path == "/call" then
                -- if player not found

                res.send(json.encode({test = 'call'}))
                TriggerClientEvent("notify", foundPed, call, number);
                --print(x,y)
                TriggerClientEvent("drawRoute", foundPed, x, y);
            end
            if req.path == "/panic" then
                res.send(json.encode({test = 'panic'}))
                print(x,y)
                TriggerClientEvent("notifyPanic", foundPed, call, number);
                TriggerClientEvent("drawRoutePanic", foundPed, x, y);
            end
        end
    end)
end)
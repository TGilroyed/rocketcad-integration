local cadURL = 'https://api.therocketcad.com'
local cadURLtemp = 'https://therocketcad.com'

local config = {
   settings = {
    -- API Key from Owner Panel > API Access
      apikey = "CHANGE ME"
   },
}

-- USED FOR 911 Alert --
RegisterServerEvent("911Alert")
AddEventHandler("911Alert", function(street, cross, pedin, serverid, apikey)
local steamIdentifier
steamIdentifier = PlayerIdentifier('steam', pedin)
local name = GetPlayerName(pedin)
PerformHttpRequest(cadURL.."/api/1.1/wf/911?api_key="..config.settings.apikey, function(err, text, headers)
if text then
   RconPrint("Successful 911 alert! " .. name .. " at " .. street .. "\n")
elseif err then
   RconPrint("911 alert Error " .. err .. "\n")
end
end, 'POST', json.encode({Name = name, Street = street, Cross = cross, ServerID = serverid}), { ["Content-Type"] = 'application/json' })
CancelEvent()
end)

-- USED FOR PANIC BUTTON --
RegisterServerEvent("panicPress")
AddEventHandler("panicPress", function(street, cross, x, y, pedin, serverid, apikey)
local steamIdentifier
steamIdentifier = PlayerIdentifier('steam', pedin)
local name = GetPlayerName(pedin)
PerformHttpRequest(cadURL.."/api/1.1/wf/panic?api_key="..config.settings.apikey, function(err, text, headers)
if text then
   RconPrint("Successful Panic alert! " .. name .. " at " .. street .. "\n")
elseif err then
   RconPrint("Panic Error " .. err .. "\n")
end
end, 'POST', json.encode({Name = name, Hex = steamIdentifier, callX = x, callY = y, Street = street, Cross = cross, ServerID = serverid}), { ["Content-Type"] = 'application/json' })
CancelEvent()
end)

-- USED FOR AUTO LOCATION
RegisterServerEvent("autolocationUpdate")
AddEventHandler("autolocationUpdate", function(street, cross, pedin)
local steamIdentifier
steamIdentifier = PlayerIdentifier('steam', pedin)
PerformHttpRequest(cadURL.."/api/1.1/wf/locationping?api_key="..config.settings.apikey, function(err, text, headers)
if text then
   RconPrint("Successful Location Ping for " .. steamIdentifier .. " at " .. street .. "\n")
elseif err then
   RconPrint("Location Ping Error " .. err .. "\n")
end
end, 'POST', json.encode({Street = street, Cross = cross, Hex = steamIdentifier}), { ["Content-Type"] = 'application/json' })
CancelEvent()
end)

function PlayerIdentifier(type, id)
   local identifiers = {}
   local numIdentifiers = GetNumPlayerIdentifiers(id)

   for a = 0, numIdentifiers do
      table.insert(identifiers, GetPlayerIdentifier(id, a))
   end

   for b = 1, #identifiers do
      if string.find(identifiers[b], type, 1) then
         return identifiers[b]
      end
   end
   return false
end

RegisterServerEvent("plateRunner")
AddEventHandler("plateRunner", function(source, plate, code)
--PerformHttpRequest(cadURL.."/api/1.1/wf/fivem_searchplate", function(err, text, headers)
PerformHttpRequest(cadURLtemp.."/api/1.1/wf/fivem_searchplate", function(err, text, headers)
if text then
   RconPrint("Successfully ran plate:" ..plate.. "\n")
   local data = json.decode(text)
   TriggerClientEvent("plateRunnerC", source, plate, data.response.Model, data.response.Flag_ID)
   --TriggerClientEvent("plateRunnerC", source, plate, data.response.Model, data.response.Flag_ID, data.response.RegOwner)
end
end, 'POST', json.encode({Code = code, Plate = plate}), { ["Content-Type"] = 'application/json' })
CancelEvent()
end)

--------------

-- USED FOR CAD CONNECT --
function findPed(hex)
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
req.setDataHandler(function(body)
local decomp=json.decode(body)
if decomp == nil then
   res.send(json.encode("ERROR: NO JSON BODY"))
else
   local hex = decomp.Hex;

   if GetNumPlayerIndices() == 0 then
      res.send("ERROR: No Online Players")
   else
      local foundPed = nil
      foundPed = findPed(hex)

      if foundPed == nil then
         res.send("ERROR: Player Hex Not Found")
      else
         if req.path == "/alert1" then
            res.send(json.encode("Sent Alert 1 to player"))
            TriggerClientEvent("alert1", foundPed);
         end
         if req.path == "/alert2" then
            res.send(json.encode("Sent Alert 2 to player"))
            TriggerClientEvent("alert2", foundPed);
         end

         local x = decomp.callX
         local y = decomp.callY
         local number = decomp.Number
         local call = decomp.Call
         if req.path == "/call" then
            if foundPed then
               res.send(json.encode("Sent new call to player"))
               TriggerClientEvent("notify", foundPed, call, number);
               TriggerClientEvent("drawRoute", foundPed, x, y);
            end
         end
         if req.path == "/panic" then
            if foundPed then
               res.send(json.encode("Sent panic to player"))
               TriggerClientEvent("notifyPanic", foundPed, call, number);
               TriggerClientEvent("drawRoutePanic", foundPed, x, y);
            end
         end
      end
   end
end
end)
end
end)

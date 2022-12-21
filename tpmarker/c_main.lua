QBCore = nil
CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if (PlayerJob ~= nil) and PlayerJob.name == "police" then
        SpawnMarker()
    end
end)

local LetSleep = false
SpawnMarker = function()
    while true do 
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if #(coords - vector3(136.10556030273,-761.97564697266,45.75203704834)) <= 2.0 then
            DrawMarker(2, 136.10556030273,-761.97564697266,45.75203704834, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            if IsControlJustPressed(0, 38) then
                SetEntityCoords(ped, 136.07495117188,-761.91180419922,242.1519317627)
            end
            LetSleep = true
        elseif #(coords - vector3(136.07495117188,-761.91180419922,242.1519317627)) <= 2.0 then
            DrawMarker(2, 136.07495117188,-761.91180419922,242.1519317627, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            if IsControlJustPressed(0, 38) then
                SetEntityCoords(ped, 136.10556030273,-761.97564697266,45.75203704834)
            end
            LetSleep = true
        else
            LetSleep = false
        end

        if LetSleep then
            Wait(5)
        else
            Wait(1000)
        end
    end
end
local drawText = function(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z + 1.2)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextCentre(1)
    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local textWidth = EndTextCommandGetWidth(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, textWidth * 1.0, 0.025, 0, 0, 0, 45)
end

local startSpectate = function(targetId)
    local targetPlayer = GetPlayerFromServerId(targetId)
    if (targetPlayer == -1) then return end

    SendNUIMessage({ open = false })
    SetNuiFocus(false, false)

    local localPlayerId = PlayerId()
    local targetPed = GetPlayerPed(targetPlayer)
    local targetCoords

    local lastLocation
    local localPed = PlayerPedId()

    lastLocation = GetEntityCoords(localPed)

    SetEntityVisible(localPed, false)
    NetworkSetEntityInvisibleToNetwork(localPed, true)
    SetEntityCollision(localPed, false, false)

    local playerSpectating = true
    while (playerSpectating) do
        SetEntityHealth(localPed, 200)
        targetCoords = GetEntityCoords(targetPed)
        
        DrawMarker(0, targetCoords.x, targetCoords.y, targetCoords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 0, 125, false, true, 2, nil, nil, false)

        if (IsPedInAnyVehicle(targetPed)) then
            SetEntityCoords(localPed, targetCoords.x, targetCoords.y, targetCoords.z)
        else
            SetEntityCoords(localPed, targetCoords.x, targetCoords.y, targetCoords.z - 1.0)
        end

        local activePlayers = GetActivePlayers()
        for playerIndex = 0, #activePlayers do
            local playerPed = GetPlayerPed(activePlayers[playerIndex])
            local playerId = GetPlayerServerId(activePlayers[playerIndex])
            local playerName = GetPlayerName(activePlayers[playerIndex])
            local playerCoords = GetEntityCoords(playerPed)

            local distance = #(targetCoords - playerCoords)
            if (distance < 10.0 and activePlayers[playerIndex] ~= localPlayerId) then
                drawText(playerCoords, "[~r~" .. playerId .. "~w~] " .. playerName)
            end
        end

        if (IsControlJustPressed(0, 22)) then
            playerSpectating = false
        end

        if (IsControlJustPressed(0, 47)) then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetId)
        end
        Wait(0)
    end

    SetEntityVisible(localPed, true)
    NetworkSetEntityInvisibleToNetwork(localPed, false)
    SetEntityCollision(localPed, true, true)
    SetEntityCoords(localPed, lastLocation.x, lastLocation.y, lastLocation.z - 1.0)
end

RegisterCommand("spectate", function(source, args)
    TriggerServerEvent("dl-spectate:server:openMenu")
end)

RegisterNetEvent("dl-spectate:client:openMenu")
AddEventHandler("dl-spectate:client:openMenu", function()
    SendNUIMessage({ open = true })
    SetNuiFocus(true, true)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)


RegisterNUICallback("spectate", function(targetId)
    startSpectate(targetId)
end)
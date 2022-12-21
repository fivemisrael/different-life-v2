local canOpen = true

RegisterNetEvent("dl-scoreboard:client:requestPlayersList")
AddEventHandler("dl-scoreboard:client:requestPlayersList", function(playersList)
    canOpen = true
    SendNUIMessage({enableScoreboard = true, playersList = playersList})
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
end)

CreateThread(function()
    while (true) do
        if (IsControlJustPressed(0, 10)) then
            canOpen = false
            TriggerServerEvent("dl-scoreboard:server:requestPlayersList")
        elseif (IsControlJustReleased(0, 10)) then
            while (not canOpen) do Wait(50) end
            SendNUIMessage({enableScoreboard = false})
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
        end
        Wait(0)
    end
end)
local DisplayList = {}

CreateThread(function()
    local LastMsg = ("")
    local CurrentMsg = ("")

    RequestAnimDict("anim@mp_player_intcelebrationmale@wank")

    while (not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@wank")) do   
        Wait(100)
    end

    while true do
        for Index, Display in pairs(DisplayList) do
            local PlayerId = GetPlayerFromServerId(Index)

            if (NetworkIsPlayerActive(PlayerId) and DisplayList[Index] ~= nil) then
                local TargetPed = GetPlayerPed(PlayerId)

                local LocalCoords = GetEntityCoords(PlayerPedId())
                local TargetCoords = GetPedBoneCoords(TargetPed, 0x2e28, 0.0, 0.0, 0.0)

                if (#(LocalCoords - TargetCoords) < 25) then
                    local onScreen, xPos, yPos = GetScreenCoordFromWorldCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z + 1.2)
                    local Style = ("left: ".. (xPos * 100) .."%;top: " .. (yPos * 100) .. "%;display: all;")

                    CurrentMsg = "<img id = 'Message' src = './" .. Display.dice .. "' style = '" .. Style .. "'></img>"
                end
            end

            if (LastMsg ~= CurrentMsg) then
                SendNUIMessage({message = CurrentMsg})
                LastMsg = CurrentMsg
            end

            if (GetGameTimer() >= Display.time) then
                DisplayList[Index] = nil
                SendNUIMessage({message = "<img></img>"})
        	end
        end

        Wait(0)
    end
end)


RegisterNetEvent("dl-diceroll:Display")
AddEventHandler("dl-diceroll:Display", function(PlayerId, DiceNum)
    if (DisplayList[tonumber(PlayerId)] == nil) then
        if (GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId())) == PlayerId) then
            TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        end

        Wait(2500)
        ClearPedTasks(PlayerPedId())

        DisplayList[tonumber(PlayerId)] = {dice = DiceNum, time = GetGameTimer() + (Config.DisplayTime * 1000)}
    end
end)
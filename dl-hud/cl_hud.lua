local QBCore
TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    playerData = QBCore.Functions.GetPlayerData()
end)

local isLoggedIn = false

CreateThread(function()
    while QBCore.Functions.GetPlayerData == nil do
        Wait(50)
    end

    while QBCore.Functions.GetPlayerData().metadata == nil do
        Wait(50)
    end

    while QBCore.Functions.GetPlayerData().metadata["hunger"] == nil do
        Wait(50)
    end

    while QBCore.Functions.GetPlayerData().metadata["thirst"] == nil do
        Wait(50)
    end

    isLoggedIn = true
end)

local isVehicle
local isRunning

CreateThread(function()
    Wait(1000)
    while true do
        if (isLoggedIn) then
            local ped = PlayerPedId()
            local metadata = QBCore.Functions.GetPlayerData().metadata
            local data = {
                health = GetEntityHealth(ped) - 100,
                shiled = GetPedArmour(ped),
                lungs = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                hunger = metadata["hunger"] > 100 and 100 or metadata.hunger,
                thirst = metadata["thirst"] > 100 and 100 or metadata.thirst,
            }
            -- print(metadata["hunger"], metadata["thirst"])
            SendNUIMessage({
                action = "update",
                data = data
            })

            local inAnyVehicle = IsPedInAnyVehicle(ped)
            if (inAnyVehicle ~= isVehicle) then
                isVehicle = inAnyVehicle
                if (isVehicle) then
                    SendNUIMessage({
                        action = "inVehicle",
                        data = data
                    })
                else
                    SendNUIMessage({
                        action = "offVehicle",
                        data = data
                    })
                end
            end

            -- startRunning
            local isCurrentRunning = IsPedSprinting(ped)
            if (isCurrentRunning ~= isRunning) then
                isRunning = isCurrentRunning
                if (isRunning) then
                    print("startRunning")
                    SendNUIMessage({
                        action = "startRunning",
                        data = data
                    })
                else
                    print("stopRunning")
                    SendNUIMessage({
                        action = "stopRunning",
                        data = data
                    })
                end
            end

            Wait(500)
        else
            Wait(1000)
        end
    end
end)

-- RegisterCommand("hud",function() 
--     SetNuiFocus(true, true)
--     SendNUIMessage({action = "open-panel"})
-- end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus()
end)

RegisterNUICallback('save-settings', function(data, cb)
    if data.data then
        SetResourceKvp("hud-settings",json.encode(data.data))
    end
end)

RegisterNetEvent("client:GetVoiceLevel")
AddEventHandler("client:GetVoiceLevel", function(level)
    SendNUIMessage({
        action = "updateVoiceLevel",
        level = level
    })
end)

RegisterNetEvent("client:talkingOnVoice")
AddEventHandler("client:talkingOnVoice", function(bool)
    if bool then
        SendNUIMessage({
            action = "talkingOnVoiceon",
        })
    else
        SendNUIMessage({
            action = "talkingOnVoiceoff",
        })
    end
end)

RegisterNetEvent("client:talkingOnRadio")
AddEventHandler("client:talkingOnRadio", function(bool)
    if bool then
        SendNUIMessage({
            action = "talkingOnRadioOn",
        })
    else
        SendNUIMessage({
            action = "talkingOnRadioOff",
        })
    end
end)
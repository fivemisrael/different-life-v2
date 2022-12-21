QBCore = nil

local PlayerData = {}
local UpdateRate = 30

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()

    local CitizenId = PlayerData.citizenid
    local PlayerName = (firstToUpper(PlayerData.charinfo.firstname) .. " " .. firstToUpper(PlayerData.charinfo.lastname))
    local PlayerId = GetPlayerServerId(PlayerId())

    SetDiscordAppId(865910153474736158)

    SetDiscordRichPresenceAsset("dl-logo")

    SetRichPresence("[" .. PlayerId .. "] " .. PlayerName .. " [CitizenId: " .. CitizenId .. "]")
    
    SetDiscordRichPresenceAssetSmall("dl-logo")

    SetDiscordRichPresenceAssetSmallText("[DL:WL]")


    SetDiscordRichPresenceAction(0, "Connect", "https://discord.gg/xw8QTcV2bY")
    SetDiscordRichPresenceAction(1, "Website", "https://horizen.co.il/dlrp/#/forms")

end)

function firstToUpper(Name)
    return (Name:gsub("^%l", string.upper))
end

local Bot = false

AddEventHandler("playerSpawned",function()
    if (not Bot) then
        TriggerServerEvent("playerSpawned")
        Bot = true
    end
end)

CreateThread(function()
    TriggerEvent("QBCore:GetObject", function(Object) QBCore = Object end)
end)
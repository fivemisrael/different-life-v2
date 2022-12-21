QBCore = nil
local PlayerJob = {}
CreateThread(function() 
    while true do
        Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Wait(200)
        end

        while QBCore.Functions.GetPlayerData().job == nil do
            Wait(10)
        end
        PlayerJob = QBCore.Functions.GetPlayerData().job
        return
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    if (PlayerJob.name == "police") then
        local settings = GetResourceKvpString("settings")
        if settings then SendNUIMessage({action = "settings",data = json.decode(settings)}) end
        SendNUIMessage({action = "open10system"})
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('10system:OnResourceStart')
AddEventHandler('10system:OnResourceStart', function()
    if (PlayerJob.name == "police") then
        SendNUIMessage({action = "open10system"})
    end
end)

RegisterNetEvent('10system:update')
AddEventHandler('10system:update', function(data)
    local id = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
    for i,v in ipairs(data) do 
       if v.src == id then
            data[i].me = true
       end
    end
    SendNUIMessage({action = "update", data = data})
end)


RegisterNetEvent('10system:open')
AddEventHandler('10system:open', function()
    SendNUIMessage({action = "open"})
    SetNuiFocus(true, true)
end)

RegisterNetEvent('10system:sendError')
AddEventHandler('10system:sendError', function(text)
    SendNUIMessage({action = "error", errorText = text})
end)

RegisterNUICallback("close", function(data,cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback("action", function(data,cb)
    TriggerServerEvent('10system:action',data.data)
    cb('ok')
end)

RegisterNUICallback("rank", function(data,cb)
    TriggerServerEvent('10system:rank',data.rank)
end)

RegisterNUICallback("settings", function(data,cb)
    SetResourceKvp("settings", json.encode(data.data))
end)


RegisterNUICallback("ToggleOpen", function(data,cb)
    local duty = exports["police"]:GetDuty()
    if not data.toggle then
        TriggerServerEvent("10system:add",duty)
    else
        TriggerServerEvent("10system:remove")
    end
    cb('ok')
end)

function IsOnline(target)
    for v, i in ipairs(GetActivePlayers()) do
        if(v == target) then
            return true
        end
    end
    return false
end

RegisterCommand("+open10System",function()
    if (PlayerJob.name == "police") then
        TriggerEvent("10system:open")
    end
end)

RegisterKeyMapping('+open10System', 'Open 10system (Police only)', 'keyboard', 'Equals')


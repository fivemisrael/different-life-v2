local playerPed, playerCoords, playerJob

local draw3dText = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local QBCore = nil
TriggerEvent("QBCore:GetObject", function(object) QBCore = object end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    playerJob = QBCore.Functions.GetPlayerData().job.name
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(jobInfo)
    playerJob = jobInfo.name
end)

CreateThread(function()
    local viewDistance = 12.0
    local interactDistance = 1.2

    while (true) do
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        
        for companyId, company in pairs(companiesData) do
            if (playerJob == companyId) then
                local distance = #(company.coords - playerCoords)
                if (distance < viewDistance) then
                    if (distance < interactDistance) then
                        draw3dText(company.coords, "[~r~E~w~] Company Management")

                        if (IsControlJustPressed(0, 38)) then
                            TriggerServerEvent("dl-companies:server:requestOpen", companyId)
                        end
                    elseif (distance < viewDistance) then
                        DrawMarker(29, company.coords.x, company.coords.y, company.coords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 82, 211, 241, 100, false, true, 0, false)
                    end
                end
            end
        end

        Wait(0)
    end
end)

local _companyId;
local _companyEmployees;

RegisterNetEvent("dl-companies:client:responseOpen")
AddEventHandler("dl-companies:client:responseOpen", function(companyId, companyEmployees, companyData)
    _companyId = companyId;
    _companyEmployees = companyEmployees
    
    SendNUIMessage({ open = true, companyData = companyData, companyEmployees = companyEmployees })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("dl-companies:client:updateBalance")
AddEventHandler("dl-companies:client:updateBalance", function(companyBalance)
    SendNUIMessage({ companyBalance = companyBalance })
end)

RegisterNetEvent("dl-companies:client:hireCompany")
AddEventHandler("dl-companies:client:hireCompany", function(companyId)
    SendNUIMessage({ companyId = companyId })
end)

RegisterNUICallback("close", function()
    SendNUIMessage({ open = false })
    SetNuiFocus(false, false)
end)

RegisterNUICallback("set-grade", function(employeeData)
    TriggerServerEvent("dl-companies:server:setGrade", _companyId, employeeData[1], employeeData[2])
end)

RegisterNUICallback("fire-employee", function(employeeId)
    TriggerServerEvent("dl-companies:server:fireEmployee", employeeId)
end)

RegisterNUICallback("withdraw-balance", function(withdrawAmount)
    TriggerServerEvent("dl-companies:server:withdrawBalance", _companyId, withdrawAmount)
end)

RegisterNUICallback("deposit-balance", function(depositAmount)
    TriggerServerEvent("dl-companies:server:depositBalance", _companyId, depositAmount)
end)

RegisterNUICallback("give-bonus", function(employeeData)
    TriggerServerEvent("dl-companies:server:giveBonus", _companyId, employeeData[1], employeeData[2])
end)

RegisterNUICallback("transfer-company", function(targetId)
    TriggerServerEvent("dl-companies:server:transferCompany", _companyId, targetId)
end)

RegisterNUICallback("hire-company", function(targetId)
    TriggerServerEvent("dl-companies:server:hireCompany", _companyId, targetId)
end)
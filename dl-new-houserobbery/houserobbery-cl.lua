local alertData = {}
local cooldown = false

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterNetEvent("dl-illegal:client:houseRobbery")
AddEventHandler("dl-illegal:client:houseRobbery", function(house, playerData)
    QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
        if cops >= 0 then
            cooldown = true
            local playerPed = PlayerPedId()
            local itemSlot = nil
        
            RequestAnimDict("mp_common_heist")
            -- SetPedDesiredHeading(playerPed, HouseLocations[house][1].w)
            Wait(250)
            while not HasAnimDictLoaded("mp_common_heist") do Wait(250) end
            TaskPlayAnimAdvanced(playerPed, "mp_common_heist", "pick_door", HouseLocations[house][1].x, HouseLocations[house][1].y, HouseLocations[house][1].z, 0.0, 0.0, HouseLocations[house][1].w, 2.0, 2.0, -1, 50, 0.0, 0, 0)
            RemoveAnimDict("mp_common_heist")
            local isSucceed = exports["dl-skillbar"]:CreateSkillbar(10, {
                duration = 2000,
                width = 1
            })
            ClearPedTasks(playerPed)
            if isSucceed then
                EnterHouse(house)
                inPolyzone = false
                TriggerServerEvent("dl-apartments:server:hidePlayer")
            end
            cooldown = false        
        end
    end)
end)

RegisterNetEvent("dl-illegal:client:enterHouseRobberyPolice")
AddEventHandler("dl-illegal:client:enterHouseRobberyPolice", function(bucket, house, playerData)
    TriggerServerEvent("dl-apartments:server:hidePlayer", bucket)
    selectedHouse = HouseLocations[house]
    local playerPed = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(playerPed, selectedHouse[2])
    SetEntityHeading(playerPed, selectedHouse[2].w)
    SetGameplayCamRelativeHeading(0)
    Wait(1000)
    SetGameplayCamRelativePitch(0, 1065353216)
    SetRadarZoom(0)
    DoScreenFadeIn(1000)

    inPolyzone = false
end)


local stringMeta = getmetatable("")
stringMeta.__index["split"] = function(self, delimiter)
    local result = {}
    local resultTemp = ""
    for index = 1, #self do
        local currentChar = (self):sub(index, index)
        if (currentChar ~= delimiter) then
            resultTemp = resultTemp .. currentChar
        else
            result[#result + 1] = resultTemp
            resultTemp = ""
        end
    end

    result[#result + 1] = resultTemp

    return result[2]
end

--[[
RegisterNetEvent("dl-houserobbery:client:UpdateRobbedHouse")
AddEventHandler("dl-houserobbery:client:UpdateRobbedHouse", function(selectedHouse, robbed)
    HouseLocations[selectedHouse][4] = robbed
end)
]]

local spawnedPeds = {}
local selectedHouse = nil
local insideHouse = false
EnterHouse = function(houseName)
    selectedHouse = HouseLocations[houseName]
    alertData = {
        code = "10-68",
        title = "House burglary in progress.",
        location = GetStreetNameFromHashKey(GetStreetNameAtCoord(selectedHouse[1].x, selectedHouse[1].y, selectedHouse[1].z)),
        vector = {selectedHouse[1].x, selectedHouse[1].y, selectedHouse[1].z},
        sound = 'burglary',
        duration = 8000,
        blinking = true,
    }
    local playerPed = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(playerPed, selectedHouse[2])
    SetEntityHeading(playerPed, selectedHouse[2].w)
    SetGameplayCamRelativeHeading(0)
    Wait(1000)
    SetGameplayCamRelativePitch(0, 1065353216)
    SetRadarZoom(0)
    DoScreenFadeIn(1000)
    insideHouse = true
    for index = 1, #HouseLocations[houseName][5] do
        RequestModel(HouseLocations[houseName][5][index][2])
        while not HasModelLoaded(HouseLocations[houseName][5][index][2]) do Wait(50) end
        ped = CreatePed(8, HouseLocations[houseName][5][index][2], HouseLocations[houseName][5][index][1].x,HouseLocations[houseName][5][index][1].y,HouseLocations[houseName][5][index][1].z,HouseLocations[houseName][5][index][1].w, false, false)
        SetModelAsNoLongerNeeded(HouseLocations[houseName][5][index][2])
        SetPedRandomComponentVariation(ped)
        SetPedHasAiBlip(ped, true)
        SetPedAiBlipForcedOn(ped, true)
        SetPedAiBlipHasCone(ped, true)
        RegisterHatedTargetsAroundPed(ped, 50.0)
        SetPedVisualFieldCenterAngle(ped, 50.0)
        SetPedSeeingRange(ped, 5.0)
        spawnedPeds[index] = ped
        Wait(250)


        if not HouseLocations[houseName][5][index][5] then
            RequestAnimDict(HouseLocations[houseName][5][index][3])
            while not HasAnimDictLoaded(HouseLocations[houseName][5][index][3]) do Wait(250) end
            TaskPlayAnim(ped, HouseLocations[houseName][5][index][3], HouseLocations[houseName][5][index][4], 8.0, 8.0, -1, 1, 0, false, false, false)
            RemoveAnimDict(HouseLocations[houseName][5][index][3])
        else
            TaskStartScenarioInPlace(ped, HouseLocations[houseName][5][index][5], 0, false)
        end

        -- if not HouseLocations[houseName][5][index][6] then
        --     SetPedRelationshipGroupHash(ped, `CIVFEMALE`)
        -- else
            SetPedRelationshipGroupHash(ped, `HATES_PLAYER`)
        -- end
        Wait(250)
    end

    CreateThread(function()
        while not CanPedsSeePlayer(playerPed) and insideHouse do
            Wait(1000)
        end

        if CanPedsSeePlayer(playerPed) then
            for index = 1, #spawnedPeds do
                SetPedAiBlipHasCone(spawnedPeds[index], false)
            end

            count = 10
            while count >= 0 and not IsDead() do
                Wait(1000)
                NotificationText("Police will be notified in ~r~" .. count .. "~w~ (consider to kill the civ)", 1000)
                count = count - 1
            end

            if count <= 0 then
                local coords = vector3(selectedHouse[1].x,selectedHouse[1].y,selectedHouse[1].z)
                TriggerServerEvent('fae-dispatch:alert', "10-32", "House Burglary in progress", coords, exports['fae-dispatch']:CoordToString(coords))
            end
        end
    end)

    -- CreateThread(function()
    --     while not IsPlayerPedInHostileSight(spawnedPeds) and insideHouse do
    --         Wait(1000)
    --     end
    --     if insideHouse then
    --         for index = 1, #spawnedPeds do
    --             SetPedAiBlipHasCone(spawnedPeds[index].Ped, false)
    --             TriggerServerEvent("dl-alerts:server:customAlert", alertData)
    --         end
    --     end
    -- end)
    TriggerServerEvent("dl-houserobbery:server:UpdateRobbedHouse", houseName, true, QBCore.Functions.GetPlayerData().source)
    NotificationText("Search and ~r~steal~w~ any valuebles you find. (Press E)", 5000)
end

PoliceEnterHouse = function()
    insideHouse = true
end

IsDead = function()
    for index = 1, #spawnedPeds do
        if IsEntityDead(spawnedPeds[index]) then
            return true
        end
    end
    return false
end

CanPedsSeePlayer = function(playerPed)
    for index = 1, #spawnedPeds do
        if CanPedSeeHatedPed(spawnedPeds[index], playerPed) then
            return true
        end
    end
    return false
end

local canSelect = true
local vehicleReward = false


Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(1, 38) then
            print("pressed")
            if insideHouse then
            if canSelect then
                local playerPed = PlayerPedId()
                if #(GetEntityCoords(playerPed) - vector3(selectedHouse[2].x, selectedHouse[2].y, selectedHouse[2].z)) < 0.8 then
                    for index = 1, #selectedHouse[3] do
                        selectedHouse[3][index][2] = false
                    end
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(playerPed, selectedHouse[1])
                    SetEntityHeading(playerPed, selectedHouse[1].w - 180.0)
                    SetGameplayCamRelativeHeading(0)
                    Wait(1000)
                    SetGameplayCamRelativePitch(0, 1065353216)
                    DoScreenFadeIn(1000)
                    FinishRobbery()
                    vehicleReward = false
                    TriggerServerEvent("dl-apartments:server:showPlayer")
                    return
                end
        
                for index = 1, #selectedHouse[3] do
                    if not selectedHouse[3][index][2] and #(GetEntityCoords(playerPed) - vector3(selectedHouse[3][index][1].x, selectedHouse[3][index][1].y, selectedHouse[3][index][1].z)) < 0.8 then
                        canSelect = false
                        TaskPedSlideToCoord(playerPed, selectedHouse[3][index][1])
                        Wait(1500)
                        if selectedHouse[3][index][6] == nil then
                            RequestAnimDict(selectedHouse[3][index][4])
                            while not HasAnimDictLoaded(selectedHouse[3][index][4]) do Wait(250) end
                            TaskPlayAnim(playerPed, selectedHouse[3][index][4], selectedHouse[3][index][5], 2.0, 2.0, -1, 50, 0, true, true, true)
                            RemoveAnimDict(selectedHouse[3][index][4])
                        else
                            TaskStartScenarioInPlace(playerPed, selectedHouse[3][index][6], 0, false)
                        end
                        local isSucceed = exports["dl-skillbar"]:CreateSkillbar(5, {
                            duration = 2000,
                            width = 1
                        })
                        if isSucceed then
                            selectedHouse[3][index][2] = true
                            -- if math.random(1, 10) >= 5 and not vehicleReward then
                            --     vehicleReward = true
                            --     ShowNotification("You found a car keys, waypoint setted to you to the parking lot", 10000)
                            --     VehicleReward()
                            -- else
                                randomItem = math.random(1, #selectedHouse[3][index][3])
                                randomNumber = math.random(1,2)
                                TriggerServerEvent("dl-illegal:Server:Add&RemoveItem", selectedHouse[3][index][3][randomItem], randomNumber)
                                QBCore.Functions.Notify("You stole " .. randomNumber .. " " .. selectedHouse[3][index][3][randomItem], "success", 4000)
                            -- end
        
                        end
                        ClearPedTasks(playerPed)
                        canSelect = true
                    end
                end
            end
            end
        end
    end
end)

FinishRobbery = function()
    if spawnedPeds ~= {} then
        for index = 1, #spawnedPeds do
            DeleteEntity(spawnedPeds[index])
        end
        selectedHouse = nil
        insideHouse = false
        canSelect = true
        spawnedPeds = {}
        TriggerEvent("dl-hud:client:ActivateMinimap", false)
    end
end

VehicleReward = function()
    local optionalVehicle = {
        {`voodoo`, vector4(-45.094875335693, -1840.8779296875, 25.714015960693, 137.498)},
        {`panto`, vector4(-63.108032226563, -1840.8150634766, 26.274612426758, 141.371)},
        {`daemon`, vector4(-62.751628875732, -1836.3890380859, 26.760160446167, 51.067)},
    }
    local randomVehicle = math.random(1, #optionalVehicle)
    RequestModel(optionalVehicle[randomVehicle][1])
    while not HasModelLoaded(optionalVehicle[randomVehicle][1]) do Wait(500) end
    local vehicle = CreateVehicle(optionalVehicle[randomVehicle][1], optionalVehicle[randomVehicle][2], true, true)
    SetModelAsNoLongerNeeded(optionalVehicle[randomVehicle][1])
    exports["dl-hotwire"]:GiveKeys(GetVehicleNumberPlateText(vehicle))
    SetNewWaypoint(optionalVehicle[randomVehicle][2].x, optionalVehicle[randomVehicle][2].y)
end

NotificationText = function(Text, Time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(Text)
    EndTextCommandPrint(Time, false)
end

ShowNotification = function(msg, duration)
    ClearAllHelpMessages()
	AddTextEntry('HelpNotification', msg)
    BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false, true, duration or -1)
end

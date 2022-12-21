QBCore = nil

CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Wait(100)
    end

    while QBCore.Functions.GetPlayerData() == nil do
        Wait(100)
    end
    isLoggedIn = true
end)

local jobCoords = {
    ["startJob"] = vector3(78.71855163574219, 111.8567886352539, 81.16806030273438),
    ["vehicleSpawn"] = vector4(64.24434661865234, 121.873046875, 79.15840148925781, 158.9961700439453)
}


local blipId = AddBlipForCoord(jobCoords["startJob"].x, jobCoords["startJob"].y, jobCoords["startJob"].z)
SetBlipSprite(blipId, 67)
SetBlipColour(blipId, 3)
SetBlipScale(blipId, 0.5)
SetBlipAsShortRange(blipId, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentSubstringPlayerName("GoPostal")
EndTextCommandSetBlipName(blipId)

local cooldown = 0

local deliveryCoords = {
    {
        vector3(246.97398376464844, -77.84967803955078, 69.72377014160156),
        vector3(245.79937744140625, -98.7530517578125, 70.1036605834961)
    },
    {
        vector3(-304.7009887695313, 379.4407653808594, 110.34597778320312),
        vector3(-297.75579833984375, 379.7397155761719, 112.09542083740236)
    },
    {
        vector3(-1092.5435791015625, 596.0254516601562, 103.06458282470705),
        vector3(-1107.6016845703125, 594.4178466796875, 104.45465087890624)
    },
    {
        vector3(393.3616638183594, -1892.3857421875, 25.09825134277343),
        vector3(385.1029052734375, -1881.5584716796875, 26.03169059753418)
    },
    {
        vector3(-127.3045654296875, 999.4322509765624, 235.7330780029297),
        vector3(-112.88111114501952, 986.0064086914064, 235.7541656494141)
    },
    {
        vector3(-1956.6746826171875, 258.210205078125, 85.34938049316406),
        vector3(-1970.553466796875, 246.1842498779297, 87.81210327148438)
    },
    {
        vector3(-1410.1890869140625, 539.4616088867188, 122.84487915039064),
        vector3(-1405.75, 526.8348999023438, 123.83128356933594)
    },
    {
        vector3(-753.1290893554688, 628.1402587890625, 142.5363006591797),
        vector3(-753.1724853515625, 620.5367431640625, 142.73171997070312)
    },
    {
        vector3(-578.057373046875, 741.8707885742188, 183.7872009277344),
        vector3(-579.7769775390625, 732.8435668945312, 184.21165466308597)
    },
    {
        vector3(-747.2883911132812, 818.64501953125, 213.31369018554688),
        vector3(-747.3121337890625, 808.2945556640625, 215.03025817871097)
    }
}

local playerPed, playerCoords, playerDistance
local playerInMission, playerDeliveris = false, 0

local startJobCheckpoint = CreateCheckpoint(47, jobCoords["startJob"].x, jobCoords["startJob"].y, jobCoords["startJob"].z - 1.0, 0.0, 0.0, 0.0, 0.5, 255, 255, 0, 125)
SetCheckpointCylinderHeight(startJobCheckpoint, 0.2, 0.2, 0.5)

local startJobText = "[~r~E~w~] Start Postal (~y~150~w~$)"
CreateThread(function()
    while (true) do
        if (isLoggedIn) then
            playerPed = PlayerPedId()
            playerCoords = GetEntityCoords(playerPed)
            playerDistance = #(playerCoords - jobCoords["startJob"])

            if (playerDistance < 1.0) then
                if (playerInMission) then startJobText = "[~r~E~w~] Stop Job (Earnings: ~y~" .. playerDeliveris * 45 .. "~w~$)" end
                repeat
                    playerCoords = GetEntityCoords(playerPed)
                    playerDistance = #(playerCoords - jobCoords["startJob"])
                    QBCore.Functions.DrawText3D(jobCoords["startJob"].x, jobCoords["startJob"].y, jobCoords["startJob"].z, startJobText)
                    if (IsControlJustPressed(0, 38)) then
                        if (playerInMission) then
                            local lastVehicle = GetPlayersLastVehicle()
                            local lastVehicleModel = GetEntityModel(lastVehicle)
                            if (lastVehicleModel == `boxville2`) then
                                SetEntityAsMissionEntity(lastVehicle, true, true)
                                DeleteEntity(lastVehicle)
                                cooldown = 60
                            end
                            playerInMission = false
                            startJobText = "[~r~E~w~] Start Postal (~y~150~w~$)"
                            TriggerServerEvent("dl-jobs:server:postal:finishMission", playerDeliveris)
                            playerDeliveris = 0
                        else
                            if (cooldown == 0) then
                                TriggerServerEvent("dl-jobs:server:postal:startMission")
                            else
                                QBCore.Functions.Notify("You still have cooldown. Please wait: " .. cooldown .. " more minutes")
                            end
                        end
                    end
                    Wait(0)
                until (playerDistance > 1.0)
            end
        end
        Wait(500)
    end
end)

CreateThread(function()
    while true do
        if (cooldown > 0) then
            cooldown  = cooldown - 1
            Wait(1000 * 60)
        else
            Wait(10000)
        end
        Wait(0)
    end
end)

RegisterNetEvent("dl-jobs:client:postal:startMission")
AddEventHandler("dl-jobs:client:postal:startMission", function()
    playerInMission = true
    startJobText = "[~r~E~w~] Stop Job (Earnings: ~y~" .. playerDeliveris * 45 .. "~w~$)"
    local model = "boxville2"

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local currentVehicle = CreateVehicle(model,jobCoords["vehicleSpawn"].x, jobCoords["vehicleSpawn"].y, jobCoords["vehicleSpawn"].z, jobCoords["vehicleSpawn"][4], true, false)
    exports["LegacyFuel"]:SetFuel(currentVehicle, 100)
    SetVehicleCustomPrimaryColour(currentVehicle, 255, 255, 255)
    SetVehicleCustomSecondaryColour(currentVehicle, 25, 25, 225)
    SetPlayersLastVehicle(currentVehicle)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(currentVehicle))

    repeat
        if (not playerInMission) then return end
        Wait(250)
    until (GetVehiclePedIsUsing(playerPed) ~= 0)

    -- local tempDeliveryCoords = deliveryCoords
    local tempDeliveryCoords = {}
    for i=1, #deliveryCoords do
        table.insert(tempDeliveryCoords, {deliveryCoords[i][1], deliveryCoords[i][2]})
    end

    for deliveryIndex = 1, 10 do
        local randomDeliveryIndex = math.random(#tempDeliveryCoords)
        QBCore.Functions.Notify("New location has been pointed on your GPS, " .. 10 - deliveryIndex .. " left")
        local parkingCoords = tempDeliveryCoords[randomDeliveryIndex][1]
        local parkingDistance = #(playerCoords - parkingCoords)
        local parkingCheckpoint = CreateCheckpoint(47, parkingCoords.x, parkingCoords.y, parkingCoords.z - 1, 0.0, 0.0, 0.0, 0.5, 255, 255, 0, 125)
        SetCheckpointCylinderHeight(parkingCheckpoint, 0.2, 0.2, 0.5)
        SetNewWaypoint(parkingCoords.x, parkingCoords.y)

        repeat
            if (not playerInMission) then return end
            Wait(250)
            parkingDistance = #(playerCoords - parkingCoords)
        until (parkingDistance < 2.0)

        DeleteCheckpoint(parkingCheckpoint)

        SetVehicleEngineOn(currentVehicle, false, false, true)
        FreezeEntityPosition(currentVehicle, true)
        TaskLeaveAnyVehicle(playerPed, true, true)
        SetVehicleDoorsLocked(currentVehicle, 2)
        SetVehicleDoorOpen(currentVehicle, 2, false, false)
        SetVehicleDoorOpen(currentVehicle, 3, false, false)

        local backRightDoorCoords, backLeftDoorCoords = GetWorldPositionOfEntityBone(currentVehicle, GetEntityBoneIndexByName(currentVehicle, "door_dside_r")), GetWorldPositionOfEntityBone(currentVehicle, GetEntityBoneIndexByName(currentVehicle, "door_pside_r"))
        local doorCoords = (backRightDoorCoords + backLeftDoorCoords) / 2
        local doorDistance = #(playerCoords - doorCoords)

        repeat
            if (not playerInMission) then return end
            doorDistance = #(playerCoords - doorCoords)
            if (doorDistance < 2.0) then QBCore.Functions.DrawText3D(doorCoords.x, doorCoords.y, doorCoords.z, "[~r~E~w~] Take Package") else QBCore.Functions.DrawText3D(doorCoords.x, doorCoords.y, doorCoords.z, "Take Package") end
            Wait(0)
        until (IsControlJustPressed(0, 38) and doorDistance < 2.0)

        ExecuteCommand("e box")

        local targetCoords = tempDeliveryCoords[randomDeliveryIndex][2]
        local targetDistance = #(playerCoords - targetCoords)
        local targetCheckpoint = CreateCheckpoint(47, targetCoords.x, targetCoords.y, targetCoords.z - 1, 0.0, 0.0, 0.0, 0.5, 255, 255, 0, 125)
        SetCheckpointCylinderHeight(targetCheckpoint, 0.2, 0.2, 0.5)

        repeat
            if (not playerInMission) then return end
            Wait(250)
            targetDistance = #(playerCoords - targetCoords)
        until (targetDistance < 2.0)

        ExecuteCommand("e box")

        DeleteCheckpoint(targetCheckpoint)
        SetVehicleEngineOn(currentVehicle, false, false, false)
        FreezeEntityPosition(currentVehicle, false)
        SetVehicleDoorsLocked(currentVehicle, 1)
        SetVehicleDoorShut(currentVehicle, 2, false, false)
        SetVehicleDoorShut(currentVehicle, 3, false, false)

        table.remove(tempDeliveryCoords, randomDeliveryIndex)
        playerDeliveris = playerDeliveris + 1
    end

    QBCore.Functions.Notify("Head back to the GoPostal station to return the delivery van and earn your money")
    SetNewWaypoint(jobCoords["startJob"].x, jobCoords["startJob"].y)
end)

RegisterNetEvent('dl-core:client:postal:resetLocations')
AddEventHandler('dl-core:client:postal:resetLocations', function()

end)


RegisterCommand('+ragdoll', function()
    SetPedToRagdoll(GetPlayerPed(-1), 4000, 4000, 0, 0, 0, 0)

end, false)
RegisterKeyMapping('+ragdoll', 'Ragdoll', 'keyboard', 'u')

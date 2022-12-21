local QBCore
TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    

local Draw3DText = function(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z)
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

local inRentalStation = false
local currentRentalStation

CreateThread(function()
    for stationIndex = 1, #rentalStations do
        exports["dl-polyzone"]:CreateCircle("rental" .. stationIndex, rentalStations[stationIndex].coords, 2.0, {
            name = "rental" .. stationIndex,
            debugColor = {0, 255, 0},
            debugPoly = false,
            useZ = true
        })
        local blipId = AddBlipForCoord(rentalStations[stationIndex].coords)
        SetBlipSprite(blipId, rentalStations[stationIndex].blipId)
        SetBlipColour(blipId, 38)
        SetBlipAsShortRange(blipId, true)
        SetBlipScale(blipId, 0.75)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(rentalStations[stationIndex].blipName)
        EndTextCommandSetBlipName(blipId)
    end
end)

AddEventHandler("dl-polyzone:enter", function(zoneName)
    if zoneName:match("rental") then
        inRentalStation = true
        currentRentalStation = tonumber(zoneName:sub(7))

        CreateThread(function()
            local stationCoords = rentalStations[currentRentalStation].coords
            while (inRentalStation) do
                Draw3DText(stationCoords, "[~r~E~w~] Vehicle Rental")
                if (IsControlJustPressed(0, 38)) then
                    local menuData = {}
                    for vehicleIndex = 1, #rentalStations[currentRentalStation].vehicles do
                        menuData[#menuData + 1] = {rentalStations[currentRentalStation].vehicles[vehicleIndex].vehicleLabel .. " [" .. rentalStations[currentRentalStation].vehicles[vehicleIndex].vehiclePrice .. "$]", vehicleIndex,}
                    end

                    menuData[#menuData + 1] = {"Cancel", -1}

                    exports["dl-menu"]:CreateMenu("Vehicle Rental", menuData, function(vehicleIndex)
                        vehicleIndex = tonumber(vehicleIndex)
                        if (vehicleIndex ~= -1) then
                            local vehicleModel = rentalStations[currentRentalStation].vehicles[vehicleIndex].vehicleModel
                            local vehiclePrice = rentalStations[currentRentalStation].vehicles[vehicleIndex].vehiclePrice
                            local spawnCoords = rentalStations[currentRentalStation].spawnCoords and rentalStations[currentRentalStation].spawnCoords or nil

                            TriggerServerEvent("dl-rental:server:rentVehicle", vehicleModel, vehiclePrice, spawnCoords)
                        end
                    end)
                end
                Wait(0)
            end
        end)
    end
end)


AddEventHandler("dl-polyzone:leave", function(zoneName)
    if zoneName:match("rental") then
        inRentalStation = false
    end
end)

RegisterNetEvent("dl-rental:client:rentVehicle")
AddEventHandler("dl-rental:client:rentVehicle", function(vehicleModel, vehicleCoords)
    local playerPed = PlayerPedId()
    local playerCoords = vehicleCoords and vehicleCoords or GetEntityCoords(playerPed)
    local playerHeading = (type(playerCoords) == "vector4") and playerCoords.w or GetEntityHeading(playerPed)

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Citizen.Wait(10)
    end

    local veh = CreateVehicle(vehicleModel, playerCoords.x, playerCoords.y, playerCoords.z, playerHeading, true, false, true)
    local netid = NetworkGetNetworkIdFromEntity(veh)

	SetVehicleHasBeenOwnedByPlayer(vehicle,  true)
	SetNetworkIdCanMigrate(netid, true)
    --SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, "OFF")

    SetModelAsNoLongerNeeded(model)



	local plate = "rent"..string.format("%04d", math.random(0, 9999))
	SetVehicleNumberPlateText(veh, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
end)

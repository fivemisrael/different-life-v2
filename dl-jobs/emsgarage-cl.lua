local QBCore = nil
local PlayerJob = "unemployed"

CreateThread(function()
    TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

    while (QBCore == nil) do
        Wait(100)
    end

    while (true) do
        QBCore.Functions.TriggerCallback("dl-emsgarage:GetPlayerJob", function(PlayerJobCallback)
            PlayerJob = PlayerJobCallback
        end)

        Wait(1000 * Config.UpdateRate)
    end
end)

CreateThread(function()
    SetNuiFocus(false, false)

    while (true) do
        local PlayerCoords = GetEntityCoords(PlayerPedId())

        for Inedx, Garage in pairs(Config.Garages) do
            if (Garage.Job == PlayerJob) then
                if (#(PlayerCoords - Garage.Location) < 3) then
                    DrawMarker(2, Garage.Location.x, Garage.Location.y, Garage.Location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 25, 225, 25, 200, 0, 0, 0, 1, 0, 0, 0)
                    DrawText3Ds(Garage.Location.x, Garage.Location.y, Garage.Location.z + 0.3, "[E] Use Garage")

                    if (IsControlJustPressed(0, Config.ActionKey)) then
                        SendNuiMessage(json.encode({open = "true", data = Garage.Cars,Title = Garage.Title}))
                        SetNuiFocus(true, true)
                    end
                end
            end
        end

        for Index, ReturnPoint in pairs(Config.ReturnPoints) do
            if (ReturnPoint.Job == PlayerJob) then
                if (#(PlayerCoords - ReturnPoint.Location) < 5 and IsPedSittingInAnyVehicle(PlayerPedId())) then
                    DrawMarker(2, ReturnPoint.Location.x, ReturnPoint.Location.y, ReturnPoint.Location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 225, 25, 25, 200, 0, 0, 0, 1, 0, 0, 0)
                    DrawText3Ds(ReturnPoint.Location.x, ReturnPoint.Location.y, ReturnPoint.Location.z + 0.3, "[E] Return Vehicle")

                    if (IsControlJustPressed(0, Config.ActionKey)) then
                        local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                        if (Vehicle ~= 0) then
                            DeleteVehicle(Vehicle)
                        end
                    end
                end
            end
        end

        Wait(0)
    end
end)

RegisterNUICallback("CloseUi", function(Data)
    SendNuiMessage(json.encode({open = "false"}))
    SetNuiFocus(false, false)
end)

RegisterNUICallback("SpawnVehicle", function(Data)
    SpawnVehicle(Data["Model"])
end)

function SpawnVehicle(Model)
    local VehHash = GetHashKey(Model)
    local Attempts = 0

    RequestModel(VehHash)

    while (not HasModelLoaded(VehHash)) do
        Attempts = Attempts + 100

        if (Attempts > 5000) then
            return
        end

        Wait(100)
    end

    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local PlayerHeading = GetEntityHeading(PlayerPedId())
    local SpawnedVeh = CreateVehicle(VehHash, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, PlayerHeading, true, false)
    local NetId = NetworkGetNetworkIdFromEntity(SpawnedVeh)

	SetVehicleHasBeenOwnedByPlayer(SpawnedVeh, true)
	SetNetworkIdCanMigrate(NetId, true)
    SetVehicleNeedsToBeHotwired(SpawnedVeh, false)
    SetVehRadioStation(SpawnedVeh, "OFF")
    SetModelAsNoLongerNeeded(VehHash)
    SetVehicleStrong(SpawnedVeh, true)

    exports["LegacyFuel"]:SetFuel(SpawnedVeh, 100)

    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(SpawnedVeh))
    TaskWarpPedIntoVehicle(PlayerPedId(), SpawnedVeh, -1)

    for _, Garage in pairs(Config.Garages) do 
        for __, Car in pairs(Garage.Cars) do 
            if (Car.Model == Model and Garage.Job == PlayerJob) then
                if (Car.ColorA) then
                    SetVehicleCustomPrimaryColour(SpawnedVeh, Car.ColorA.R, Car.ColorA.G, Car.ColorA.B)
                elseif (Car.ColorB) then
                    SetVehicleCustomSecondaryColour(SpawnedVeh, Car.ColorB.R, Car.ColorB.G, Car.ColorB.B)
                end
            end
        end
    end
end

function DrawText3Ds(xPos, yPos, zPos, Text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(Text)
    SetDrawOrigin(xPos, yPos, zPos, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(Text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
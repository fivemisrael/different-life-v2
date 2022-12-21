QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)
local Camera = nil
--- CODE

local currentHouseGarage = nil
local hasGarageKey = nil
local currentGarage = nil
local OutsideVehicles = {}

RegisterNetEvent('qb-garages:client:setHouseGarage')
AddEventHandler('qb-garages:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = house
    hasGarageKey = hasKey
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig')
AddEventHandler('qb-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('qb-garages:client:addHouseGarage')
AddEventHandler('qb-garages:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
end)

-- function AddOutsideVehicle(plate, veh)
--     OutsideVehicles[plate] = veh
--     TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
-- end

RegisterNetEvent('qb-garages:client:takeOutDepot')
AddEventHandler('qb-garages:client:takeOutDepot', function(vehicle)
    if OutsideVehicles ~= nil and next(OutsideVehicles) ~= nil then
        if OutsideVehicles[vehicle.plate] ~= nil then
            local VehExists = DoesEntityExist(OutsideVehicles[vehicle.plate])
            if not VehExists then
                QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                    QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                        QBCore.Functions.SetVehicleProperties(veh, properties)
                        enginePercent = round(vehicle.engine / 10, 0)
                        bodyPercent = round(vehicle.body / 10, 0)
                        currentFuel = vehicle.fuel

                        if vehicle.plate ~= nil then
                            DeleteVehicle(OutsideVehicles[vehicle.plate])
                            OutsideVehicles[vehicle.plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end

                        if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                            TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                        end

                        if vehicle.drivingdistance ~= nil then
                            local amount = round(vehicle.drivingdistance / 1000, -2)
                            TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
                            TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                        end

                        if vehicle.vehicle == "urus" then
                            SetVehicleExtra(veh, 1, false)
                            SetVehicleExtra(veh, 2, true)
                        end

                        SetVehicleNumberPlateText(veh, vehicle.plate)
                        SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                        exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                        SetEntityAsMissionEntity(veh, true, true)
                        doCarDamage(veh, vehicle)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                        QBCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                        closeMenuFull()
                        SetVehicleEngineOn(veh, true, true)
                    end, vehicle.plate)
                    TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
                end, Depots[currentGarage].spawnPoint, true)
            else
                local Engine = GetVehicleEngineHealth(OutsideVehicles[vehicle.plate])
                if Engine < 40.0 then
                    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                            QBCore.Functions.SetVehicleProperties(veh, properties)
                            enginePercent = round(vehicle.engine / 10, 0)
                            bodyPercent = round(vehicle.body / 10, 0)
                            currentFuel = vehicle.fuel

                            if vehicle.plate ~= nil then
                                DeleteVehicle(OutsideVehicles[vehicle.plate])
                                OutsideVehicles[vehicle.plate] = veh
                                TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                            end

                            if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                                TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                            end

                            if vehicle.drivingdistance ~= nil then
                                local amount = round(vehicle.drivingdistance / 1000, -2)
                                TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
                                TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                            end

                            SetVehicleNumberPlateText(veh, vehicle.plate)
                            SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                            exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                            SetEntityAsMissionEntity(veh, true, true)
                            doCarDamage(veh, vehicle)
                            TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                            QBCore.Functions.Notify("Vehicle motor : off : " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                            closeMenuFull()
                            SetVehicleEngineOn(veh, true, true)
                        end, vehicle.plate)
                        TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
                    end, Depots[currentGarage].spawnPoint, true)
                else
                    QBCore.Functions.Notify('You cant duplicate the vehicle ..', 'error')
                    AddTemporaryBlip(OutsideVehicles[vehicle.plate])
                end
            end
        else
            QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                    enginePercent = round(vehicle.engine / 10, 0)
                    bodyPercent = round(vehicle.body / 10, 0)
                    currentFuel = vehicle.fuel

                    if vehicle.plate ~= nil then
                        OutsideVehicles[vehicle.plate] = veh
                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end

                    if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                        TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                    end

                    SetVehicleNumberPlateText(veh, vehicle.plate)
                    SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                    SetEntityAsMissionEntity(veh, true, true)
                    doCarDamage(veh, vehicle)
                    TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                    QBCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                    closeMenuFull()
                    SetVehicleEngineOn(veh, true, true)
                end, vehicle.plate)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
            end, Depots[currentGarage].spawnPoint, true)
        end
    else
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.engine / 10, 0)
                bodyPercent = round(vehicle.body / 10, 0)
                currentFuel = vehicle.fuel

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end

                if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                    TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end

                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                closeMenuFull()
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
            TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
        end, Depots[currentGarage].spawnPoint, true)
    end

    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
end)

function AddTemporaryBlip(vehicle)
    local VehicleCoords = GetEntityCoords(vehicle)
    local TempBlip = AddBlipForCoord(VehicleCoords)
    local VehicleData = QBCore.Shared.VehicleModels[GetEntityModel(vehicle)]

    SetBlipSprite (TempBlip, 225)
    SetBlipDisplay(TempBlip, 4)
    SetBlipScale  (TempBlip, 0.85)
    SetBlipAsShortRange(TempBlip, true)
    SetBlipColour(TempBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Temp Blip: "..VehicleData["name"])
    EndTextCommandSetBlipName(TempBlip)
    QBCore.Functions.Notify("Your "..VehicleData["name"].." is temporary (1min) located on the map!", "success", 10000)

    SetTimeout(60 * 1000, function()
        QBCore.Functions.Notify('Your vehicle is not located on the map anymore!', 'error')
        RemoveBlip(TempBlip)
    end)
end

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    for k, v in pairs(Garages) do
        Garage = AddBlipForCoord(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)

        SetBlipSprite (Garage, 357)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.65)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Garages[k].label)
        EndTextCommandSetBlipName(Garage)
    end

    for k, v in pairs(Depots) do
        Depot = AddBlipForCoord(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)

        SetBlipSprite (Depot, 68)
        SetBlipDisplay(Depot, 4)
        SetBlipScale  (Depot, 0.7)
        SetBlipAsShortRange(Depot, true)
        SetBlipColour(Depot, 5)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Depots[k].label)
        EndTextCommandSetBlipName(Depot)
    end
end)

function MenuGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    DetachCam(Camara)
    ClearMenu()
    Menu.addButton("My vehicle", "GetVehicleList", nil)
    Menu.addButton("Close menu", "close", nil)
end

function MenuDepot()
    ped = GetPlayerPed(-1);
    MenuTitle = "Depot"
    ClearMenu()
    Menu.addButton("Vehicle depot", "DepotLijst", nil)
    Menu.addButton("Close Menu", "close", nil)
end

function MenuHouseGarage(house)
    ped = GetPlayerPed(-1);
    MenuTitle = HouseGarages[house].label
    ClearMenu()
    Menu.addButton("My vehicle", "HouseGarage", house)
    Menu.addButton("Close Menu", "close", nil)
end

function yeet(label)
    print(label)
end

function HouseGarage(house)
    QBCore.Functions.TriggerCallback("qb-garage:server:GetHouseVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Vehicle depot :"
        ClearMenu()

        if result == nil then
            QBCore.Functions.Notify("You have no vehicle in your garage", "error", 5000)
            closeMenuFull()
        else
            Menu.addButton(HouseGarages[house].label, "yeet", HouseGarages[house].label)

            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = HouseGarages[house].label

                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garage"
                elseif v.state == 2 then
                    v.state = "Impounded"
                end

                local label = QBCore.Shared.Vehicles[v.vehicle]["name"]
                if QBCore.Shared.Vehicles[v.vehicle]["brand"] ~= nil then
                    label = QBCore.Shared.Vehicles[v.vehicle]["brand"].." "..QBCore.Shared.Vehicles[v.vehicle]["name"]
                end

                Menu.addButton(label, "TakeOutGarageVehicle", v, v.state, " Engine: " .. enginePercent.."%", " Body: " .. bodyPercent.."%", " Fuel: "..currentFuel.."%")
            end
        end

        Menu.addButton("Terug", "MenuHouseGarage", house)
    end, house)
end

function getPlayerVehicles(garage)
    local vehicles = {}

    return vehicles
end

function DepotLijst()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetDepotVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Vehicle depot :"
        ClearMenu()

        if result == nil then
            QBCore.Functions.Notify("There is no vehicle in the depo", "error", 5000)
            closeMenuFull()
        else
            Menu.addButton(Depots[currentGarage].label, "yeet", Depots[currentGarage].label)

            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel


                if v.state == 0 then
                    v.state = "Depot"
                end

                local label = QBCore.Shared.Vehicles[v.vehicle]["name"]
                if QBCore.Shared.Vehicles[v.vehicle]["brand"] ~= nil then
                    label = QBCore.Shared.Vehicles[v.vehicle]["brand"].." "..QBCore.Shared.Vehicles[v.vehicle]["name"]
                end
                Menu.addButton(label, "TakeOutDepotVehicle", v, v.state .. " ($"..v.depotprice..",-)", " Motor: " .. enginePercent.."%", " Body: " .. bodyPercent.."%", " Fuel: "..currentFuel.."%")
            end
        end

        Menu.addButton("Back", "MenuDepot",nil)
    end)
end

function CreateCamera(currentGarage)
    Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local garage = Garages[currentGarage].Camera
	SetCamActive(Camera, true)
	RenderScriptCams(true, true, 500, true, true)
	SetCamCoord(Camera, garage.x,garage.y,garage.z)
    PointCamAtCoord(Camera, garage.xpoint,garage.ypoint,garage.zpoint)
    SetCamRot(Camera, 0.0, 0.0, garage.rot, 2)
    FreezeEntityPosition(PlayerPedId(), true)
end

function DeleteSkinCam()
	SetCamActive(Camera, false)
	RenderScriptCams(false, true, 500, true, true)
    DestroyCam(Camera,false)
    FreezeEntityPosition(PlayerPedId(), false)
	Camera = nil
end
function GetVehicleList()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetUserVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "My Vehicles :"
        ClearMenu()

        if result == nil then
            QBCore.Functions.Notify("You have no vehicle in the depot", "error", 5000)
            closeMenuFull()
        else
            Menu.addButton(Garages[currentGarage].label, "yeet", Garages[currentGarage].label)
            local OutSideVehicle = {}
            for k, v in pairs(result) do
                if k <= 4 then
                    enginePercent = round(v.engine / 10, 0)
                    bodyPercent = round(v.body / 10, 0)
                    currentFuel = v.fuel
                    curGarage = Garages[v.garage].label
                    if v.state == 0 then
                        v.state = "Uit"
                    elseif v.state == 1 then
                        v.state = "Garage"
                        -- if QBCore.Functions.IsSpawnPointClear(Garages[currentGarage].Available[k],3.0) then
                            Wait(200)
                            RequestModel(v.vehicle)
                            while not HasModelLoaded(v.vehicle) do
                                Citizen.Wait(10)
                            end

                            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                                local coords = Garages[currentGarage].Available[k]
                                print(json.encode(coords))
                                ClearAreaOfEverything(coords.x, coords.y, coords.z, 4.0, false, false, false, false)
                                local veh = CreateVehicle(v.vehicle, coords.x, coords.y, coords.z, coords.a, false, false)
                                local netid = NetworkGetNetworkIdFromEntity(veh)

                                SetVehicleHasBeenOwnedByPlayer(veh,  true)
                                SetNetworkIdCanMigrate(netid, true)
                                --SetEntityAsMissionEntity(veh, true, true)
                                SetVehicleNeedsToBeHotwired(veh, false)
                                SetVehRadioStation(veh, "OFF")
                                QBCore.Functions.SetVehicleProperties(veh, properties)
                                SetVehicleNumberPlateText(veh, v.plate)
                                Garages[currentGarage].Available[k].vehicle = veh
                                SetModelAsNoLongerNeeded(v.vehicle)
                            end, v.plate)
                        -- end
                    elseif v.state == 2 then
                        v.state = "In Beslag"
                    end

                    local label = QBCore.Shared.Vehicles[v.vehicle]["name"]
                    if QBCore.Shared.Vehicles[v.vehicle]["brand"] ~= nil then
                        label = QBCore.Shared.Vehicles[v.vehicle]["brand"].." "..QBCore.Shared.Vehicles[v.vehicle]["name"]
                    end
                    Garages[currentGarage].Available[k].vehiclename = label

                    Menu.addButton(label, "TakeOutVehicle", v, v.state, " Motor: " .. enginePercent .. "%", " Body: " .. bodyPercent.. "%", " Fuel: "..currentFuel.. "%")
                end
            end

            CreateCamera(currentGarage)

            while true do
                if not Menu.hidden then
                    for k,v in pairs(Garages[currentGarage].Available) do
                        if Garages[currentGarage].Available[k].vehicle ~= nil then
                            if IsSelectedMenuActive(v.vehiclename) then
                                DrawMarker(20, v.x, v.y, v.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 170, true, true, 2, nil, nil, false)
                                if IsControlJustPressed(0, 232) then
                                    AttachCamToEntity(Camera, v.vehicle, 0.0,5.0,2.0,true)
                                    PointCamAtCoord(Camera, v.x, v.y, v.z)
                                end
                            end
                        end
                    end
                else
                    for i=1, #Garages[currentGarage].Available do
                        if Garages[currentGarage].Available[i].vehicle ~= nil then
                            QBCore.Functions.DeleteVehicle(Garages[currentGarage].Available[i].vehicle)
                            Garages[currentGarage].Available[i].vehicle = nil
                            DeleteSkinCam()
                        else
                            DeleteSkinCam()
                        end
                    end
                    break
                end

                Wait(5)
            end
        end

        Menu.addButton("Back", "MenuGarage", nil)
    end, currentGarage)
end

CreateThread(function()
    while true do
        if not Menu.hidden then
            if IsControlJustPressed(0, 202)
            or IsControlJustPressed(0, 177)
            or IsControlJustPressed(0, 194)
            or IsControlJustPressed(0, 202) then
                ClearMenu()
            end
        end
        Wait(5)
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         if VehPlate ~= nil then
--             local veh = OutsideVehicles[VehPlate]
--             local Damage = GetVehicleBodyHealth(veh)
--         end

--         Citizen.Wait(1000)
--     end
-- end)

function TakeOutVehicle(vehicle)
    if vehicle.state == "Garage" then
        enginePercent = round(vehicle.engine / 10, 1)
        bodyPercent = round(vehicle.body / 10, 1)
        currentFuel = vehicle.fuel

        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end

                if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                    TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end

                if vehicle.vehicle == "urus" then
                    SetVehicleExtra(veh, 1, false)
                    SetVehicleExtra(veh, 2, true)
                end

                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Garages[currentGarage].spawnPoint.h)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                closeMenuFull()
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)

        end, Garages[currentGarage].spawnPoint, true)
        for i=1, #Garages[currentGarage].Available do
            if Garages[currentGarage].Available[i].vehicle ~= nil then
                QBCore.Functions.DeleteVehicle(Garages[currentGarage].Available[i].vehicle)
                Garages[currentGarage].Available[i].vehicle = nil
            end
        end
        DeleteSkinCam()
    elseif vehicle.state == "Uit" then
        QBCore.Functions.Notify("Is your vehicle in the depot??", "error", 2500)
    elseif vehicle.state == "Confiscated" then
        QBCore.Functions.Notify("This vehicle is confiscated by the police ", "error", 4000)
    end
end

function TakeOutDepotVehicle(vehicle)
    if vehicle.state == "Depot" then
        TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle)
    end
end

function TakeOutGarageVehicle(vehicle)
    if vehicle.state == "Garage" then
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                currentFuel = vehicle.fuel

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end


                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('qb-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                if vehicle.vehicle == "urus" then
                    SetVehicleExtra(veh, 1, false)
                    SetVehicleExtra(veh, 2, true)
                end

                if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                    TriggerServerEvent('qb-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end

                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, HouseGarages[currentHouseGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Vehicle engine off: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                closeMenuFull()
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, HouseGarages[currentHouseGarage].takeVehicle, true)
    end
end

function doCarDamage(currentVehicle, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end

    if engine > 1000.0 then
        engine = 1000.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 900.0 then
		smash = true
	end

	if body < 800.0 then
		damageOutside = true
	end

	if body < 500.0 then
		damageOutside2 = true
	end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function close()
    Menu.hidden = true
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Garages) do
            local takeDist = GetDistanceBetweenCoords(pos, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            MenuGarage()
                            Menu.hidden = not Menu.hidden
                            currentGarage = k
                        end
                    else
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, Garages[k].label)
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end

            local putDist = GetDistanceBetweenCoords(pos, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z)

            if putDist <= 25 and IsPedInAnyVehicle(ped) then
                inGarageRange = true
                DrawMarker(2, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                if putDist <= 1.5 then
                    DrawText3Ds(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z + 0.5, '~g~E~w~ - Park Vehicle')
                    if IsControlJustPressed(0, 38) then
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)
                        QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
                            if owned then
                                local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
                                local totalFuel = exports['LegacyFuel']:GetFuel(curVeh)

                                TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                                TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, k)
                                TriggerServerEvent('vehiclemod:server:saveStatus', plate)
                                QBCore.Functions.DeleteVehicle(curVeh)
                                if plate ~= nil then
                                    OutsideVehicles[plate] = veh
                                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                end
                                QBCore.Functions.Notify("Vehicle parked in, "..Garages[k].label, "primary", 4500)
                            else
                                QBCore.Functions.Notify("No one is in possesion of no one..", "error", 3500)
                            end
                        end, plate)
                    end
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        if HouseGarages ~= nil and currentHouseGarage ~= nil then
            if hasGarageKey and HouseGarages[currentHouseGarage] ~= nil then
                local takeDist = GetDistanceBetweenCoords(pos, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z)
                if takeDist <= 15 then
                    inGarageRange = true
                    DrawMarker(2, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if takeDist < 2.0 then
                        if not IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                            if IsControlJustPressed(1, 177) and not Menu.hidden then
                                close()
                                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            end
                            if IsControlJustPressed(0, 38) then
                                MenuHouseGarage(currentHouseGarage)
                                Menu.hidden = not Menu.hidden
                            end
                        elseif IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Om te parkeren')
                            if IsControlJustPressed(0, 38) then
                                local curVeh = GetVehiclePedIsIn(ped)
                                local plate = GetVehicleNumberPlateText(curVeh)
                                QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleHouseOwner', function(owned)
                                    if owned then
                                        local bodyDamage = round(GetVehicleBodyHealth(curVeh), 1)
                                        local engineDamage = round(GetVehicleEngineHealth(curVeh), 1)
                                        local totalFuel = exports['LegacyFuel']:GetFuel(curVeh)

                                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, currentHouseGarage)
                                        TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, currentHouseGarage)
                                        QBCore.Functions.DeleteVehicle(curVeh)
                                        if plate ~= nil then
                                            OutsideVehicles[plate] = veh
                                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                        end
                                        QBCore.Functions.Notify("Vehicle is parked in, "..HouseGarages[currentHouseGarage].label, "primary", 4500)
                                    else
                                        QBCore.Functions.Notify("No one is in possesion of this vehicle ...", "error", 3500)
                                    end
                                end, plate, currentHouseGarage)
                            end
                        end

                        Menu.renderGUI()
                    end

                    if takeDist > 1.99 and not Menu.hidden then
                        closeMenuFull()
                    end
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Depots) do
            local takeDist = GetDistanceBetweenCoords(pos, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            MenuDepot()
                            Menu.hidden = not Menu.hidden
                            currentGarage = k
                        end
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(5000)
        end
    end
end)

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end
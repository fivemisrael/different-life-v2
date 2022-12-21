

local inTrunk = false
local isKidnapped = false
local isKidnapping = false

local disabledTrunk = {
    [1] = "penetrator",
    [2] = "vacca",
    [3] = "monroe",
    [4] = "turismor",
    [5] = "osiris",
    [6] = "comet",
    [7] = "ardent",
    [8] = "jester",
    [9] = "nero",
    [10] = "nero2",
    [11] = "vagner",
    [12] = "infernus",
    [13] = "zentorno",
    [14] = "comet2",
    [15] = "comet3",
    [16] = "comet4",
    [17] = "lp700r",
    [18] = "r8ppi",
    [19] = "911turbos",
    [20] = "rx7rb",
    [21] = "fnfrx7",
    [22] = "delsoleg",
    [23] = "s15rb",
    [24] = "gtr",
    [25] = "fnf4r34",
    [26] = "ap2",
    [27] = "bullet",
}

function loadDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function disabledCarCheck(veh)
    for i=1,#disabledTrunk do
        if GetEntityModel(veh) == GetHashKey(disabledTrunk[i]) then
            return true
        end
    end
    return false
end 


function GetClosestStreetPed(playerPed)
    local peds = GetGamePool("CPed")
    for index = 1, #peds do
        if IsPedHuman(peds[index]) and not IsPedAPlayer(peds[index]) and playerPed ~= peds[index] and not IsEntityDead(peds[index]) then
            if #(GetEntityCoords(playerPed) - GetEntityCoords(peds[index])) < 2.0 then
                return peds[index]
            end
        end
    end
end


local oldPed
RegisterNetEvent('qb-selloxy:client:startsellingOxy')
AddEventHandler('qb-selloxy:client:startsellingOxy', function()
    local sellingAlready = false

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local PlayerPed = PlayerPedId()
            local sellingToPed = GetClosestStreetPed(PlayerPed)
            if sellingToPed ~= nil and sellingToPed ~= oldPed and not sellingAlready then

                sellingAlready = true
                oldPed = Ped
        
                SetBlockingOfNonTemporaryEvents(sellingToPed, true)
                TaskLookAtEntity(sellingToPed, PlayerPed, 5500.0, 2048, 3)
                TaskTurnPedToFaceEntity(sellingToPed, PlayerPed, 5500)
                Wait(1000)
                TaskLookAtEntity(PlayerPed, sellingToPed, 5500.0, 2048, 3)
                TaskTurnPedToFaceEntity(PlayerPed, sellingToPed, 5500)
                Wait(2000)
        
        


                
                QBCore.Functions.Notify("You are trying to convince the buyer", "success") 

                local ActiveTimer = GetGameTimer() + 4000
                while ActiveTimer >= GetGameTimer() do
                    Wait(0)
                end
                local random = math.random(0,100)
                    if random <= 52 then
                        if random >= 35 then
                            print("fail")
                            if random <= 17 then
                                print("police alert")
                                QBCore.Functions.Notify("The person refused the deal and called the cops", "error")
                                TriggerServerEvent('fae-dispatch:alert', "10-17", "Dealing in progress.", playerCoords, exports['fae-dispatch']:CoordToString(playerCoords))
                                
                            else 
                                QBCore.Functions.Notify("The person refused, but didn't call the police.", "error")
                            end
                        end
                    else
                        ClearPedTasks(PlayerPed)
                        local random = math.random(1, 100)
                        QBCore.Functions.Notify("You convinced the person!", "success")
        
                        RequestAnimDict("mp_common")
                        while not HasAnimDictLoaded("mp_common") do Wait(250) end
                        TaskPlayAnim(sellingToPed, "mp_common", "givetake1_a", 1.0, 1.0, -1, 0, 0)
                        TaskPlayAnim(PlayerPed, "mp_common", "givetake1_a", 1.0, 1.0, -1, 0, 0)
                        local moneyAmount = math.random(25, 75) * 1 -- amount
                        TriggerServerEvent("dl-oxyruns:server:reward", moneyAmount, 1)
                        end
        
                    end
                    sellingAlready = false

            end
    end, "oxy")
end)

local tabletObject = nil
RegisterNetEvent("ido-panic:sendPanic")
AddEventHandler("ido-panic:sendPanic", function()
    local dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
    RequestAnimDict(dict)
    if tabletObject == nil then
        tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(PlayerPedId()), 1, 1, 1)
        AttachEntityToEntity(tabletObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.003, 0.002, -0.0, 10.0, 160.0, 0.0, 1, 1, 0, 1, 0, 1)
    end

    while not HasAnimDictLoaded(dict) do Wait(500) end
    if not IsEntityPlayingAnim(PlayerPedId(), dict, 'base', 3) then
        TaskPlayAnim(PlayerPedId(), dict, "base", 3.0, 3.0, -1, 49, 1.0, 0, 0, 0)
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('fae-dispatch:alert', "10-13", "Panic Button | Officer In Danger / Down!", playerCoords, exports['fae-dispatch']:CoordToString(playerCoords))
   
    Wait(1200)
    DeleteEntity(tabletObject)

    ClearPedTasks(PlayerPedId())

end)

RegisterNetEvent('qb-kidnapping:client:SetKidnapping')
AddEventHandler('qb-kidnapping:client:SetKidnapping', function(bool)
    isKidnapping = bool
end)

function DrawText3Ds(x, y, z, text)
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

local cam = nil

function getNearestVeh()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

function TrunkCam(bool)
    local ped = GetPlayerPed(-1)
    local vehicle = GetEntityAttachedTo(PlayerPedId())
    local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)

    local vehHeading = GetEntityHeading(vehicle)

    if bool then
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            RenderScriptCams(true, false, 0, true, true)
        end
    else
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        cam = nil
    end
end

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local vehicle = GetEntityAttachedTo(PlayerPedId())
        local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)
    
        local vehHeading = GetEntityHeading(vehicle)

        if cam ~= nil then
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
        else
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

RegisterNetEvent('qb-trunk:client:KidnapTrunk')
AddEventHandler('qb-trunk:client:KidnapTrunk', function()
    closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if (distance ~= -1 and distance < 2) then
        if isKidnapping then
            local closestVehicle = getNearestVeh()
            if closestVehicle ~= 0 then
                TriggerEvent('police:client:KidnapPlayer')
                TriggerServerEvent("police:server:CuffPlayer", GetPlayerServerId(closestPlayer), false)
                Citizen.Wait(50)
                TriggerServerEvent("qb-trunk:server:KidnapTrunk", GetPlayerServerId(closestPlayer), closestVehicle)
            end
        else
            QBCore.Functions.Notify('You didn\'t kidnap this person!', 'error')
        end
    end
end)

RegisterNetEvent('qb-trunk:client:KidnapGetIn')
AddEventHandler('qb-trunk:client:KidnapGetIn', function(veh)
    local ped = GetPlayerPed(-1)
    local closestVehicle = veh
    local vehClass = GetVehicleClass(closestVehicle)
    local plate = GetVehicleNumberPlateText(closestVehicle)

    if TrunkClasses[vehClass].allowed then
        QBCore.Functions.TriggerCallback('qb-trunk:server:getTrunkBusy', function(isBusy)
            if not disabledCarCheck(closestVehicle) then
                if not inTrunk then
                    if not isBusy then
                        if not isKidnapped then
                            offset = {
                                x = TrunkClasses[vehClass].x,
                                y = TrunkClasses[vehClass].y,
                                z = TrunkClasses[vehClass].z,
                            }
                            loadDict("fin_ext_p1-7")
                            TaskPlayAnim(ped, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
                            AttachEntityToEntity(ped, closestVehicle, 0, offset.x, offset.y, offset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
                            TriggerServerEvent('qb-trunk:server:setTrunkBusy', plate, true)
                            inTrunk = true
                            Citizen.Wait(500)
                            SetVehicleDoorShut(closestVehicle, 5, false)
                            QBCore.Functions.Notify('You are in the trunk', 'success', 4000)
                            TrunkCam(true)

                            isKidnapped = true
                        else
                            local ped = GetPlayerPed(-1)
                            local vehicle = GetEntityAttachedTo(PlayerPedId())
                            local plate = GetVehicleNumberPlateText(vehicle)
            
                            if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                                local vehCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.0, 0)
                                DetachEntity(ped, true, true)
                                ClearPedTasks(ped)
                                inTrunk = false
                                TriggerServerEvent('qb-smallresources:trunk:server:setTrunkBusy', plate, nil)
                                SetEntityCoords(ped, vehCoords.x, vehCoords.y, vehCoords.z)
                                SetEntityCollision(PlayerPedId(), true, true)
                                TrunkCam(false)
                            else
                                QBCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                            end
                        end
                    else
                        QBCore.Functions.Notify('Already see someone in it?', 'error', 2500)
                    end 
                else
                    QBCore.Functions.Notify('You are already in the trunk', 'error', 2500)
                end 
            else
                QBCore.Functions.Notify('You cannot put this vehicle in the trunk', 'error', 2500)
            end
        end, plate)
    else
        QBCore.Functions.Notify('You cannot put this vehicle in the trunk', 'error', 2500)
    end
end)

RegisterNetEvent('qb-trunk:client:GetIn')
AddEventHandler('qb-trunk:client:GetIn', function(isKidnapped)
    local ped = GetPlayerPed(-1)
    local closestVehicle = getNearestVeh()

    if closestVehicle ~= 0 then
        local vehClass = GetVehicleClass(closestVehicle)
        local plate = GetVehicleNumberPlateText(closestVehicle)
        if TrunkClasses[vehClass].allowed then
            QBCore.Functions.TriggerCallback('qb-trunk:server:getTrunkBusy', function(isBusy)
                if not disabledCarCheck(closestVehicle) then
                    if not inTrunk then
                        if not isBusy then
                            if GetVehicleDoorAngleRatio(closestVehicle, 5) > 0 then
                                offset = {
                                    x = TrunkClasses[vehClass].x,
                                    y = TrunkClasses[vehClass].y,
                                    z = TrunkClasses[vehClass].z,
                                }
                                loadDict("fin_ext_p1-7")
                                TaskPlayAnim(ped, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
                                -- AttachEntityToEntity(ped, closestVehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                AttachEntityToEntity(ped, closestVehicle, 0, offset.x, offset.y, offset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
                                TriggerServerEvent('qb-trunk:server:setTrunkBusy', plate, true)
                                inTrunk = true
                                Citizen.Wait(500)
                                SetVehicleDoorShut(closestVehicle, 5, false)
                                QBCore.Functions.Notify('You are in the trunk.', 'success', 4000)
                                TrunkCam(true)
                            else
                                QBCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                            end
                        else
                            QBCore.Functions.Notify('Anyone in there yet?', 'error', 2500)
                        end 
                    else
                        QBCore.Functions.Notify('You are already in the trunk', 'error', 2500)
                    end 
                else
                    QBCore.Functions.Notify('You can\'t put this vehicle in the trunk ..', 'error', 2500)
                end
            end, plate)
        else
            QBCore.Functions.Notify('You can\'t put this vehicle in the trunk ..', 'error', 2500)
        end
    else
        QBCore.Functions.Notify('No vehicle to be seen ..', 'error', 2500)
    end
end)

CreateThread(function()
    while true do
        if inTrunk then
            if not isKidnapped then
                local ped = GetPlayerPed(-1)
                local vehicle = GetEntityAttachedTo(PlayerPedId())
                local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                local plate = GetVehicleNumberPlateText(vehicle)

                if DoesEntityExist(vehicle) then
                    DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.75, '[E] To get out of the trunk')

                    if IsControlJustPressed(0, 38) then
                        if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                            local vehCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.0, 0)
                            DetachEntity(ped, true, true)
                            ClearPedTasks(ped)
                            inTrunk = false
                            TriggerServerEvent('qb-trunk:server:setTrunkBusy', plate, false)
                            SetEntityCoords(ped, vehCoords.x, vehCoords.y, vehCoords.z)
                            SetEntityCollision(PlayerPedId(), true, true)
                            TrunkCam(false)
                        else
                            QBCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                        end
                    end

                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[G] Close Trunk')
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, 5)
                            else
                                SetVehicleDoorShut(vehicle, 5, false)
                            end
                        end
                    else
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[G] Open Trunk')
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, 5)
                            else
                                SetVehicleDoorOpen(vehicle, 5, false, false)
                            end
                        end
                    end
                end
            end
        end

        if not inTrunk then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
        exports['progressbar']:Progress({
            name = "flipping_vehicle",
            duration = 5000,
            label = "Flipping Vehicle",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)

            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
        end)
    else
        TriggerEvent('notification', "No vehicle nearby.", 2) 
    end
end)



RegisterNetEvent('cuffing:client:RobPlayer')
AddEventHandler('cuffing:client:RobPlayer', function()
    local closestPed = GetClosestPed()
    if closestPed ~= -1 then
        local id = GetPlayerServerId(NetworkGetEntityOwner(closestPed))
        local Data = QBCore.Functions.GetPlayerData()
        if (IsEntityPlayingAnim(closestPed, "missminuteman_1ig_2", "handsup_enter", 3) or IsEntityPlayingAnim(closestPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(closestPed, "dead", "dead_a", 3) or IsEntityPlayingAnim(closestPed, "combat@damage@writhe", "writhe_loop", 3)) or Data.metadata["isdead"] or Data.metadata["inlaststand"] or Data.metadata["ishandcuffed"] or IsPedDeadOrDying(closestPed) then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", id)
            TriggerEvent("inventory:server:RobPlayer", id)
            TriggerServerEvent("dl-radialmenu:server:notifyRob", id)
        else
            QBCore.Functions.Notify('The target does not raise its hands','error')
        end
    else
        QBCore.Functions.Notify('No one nearby!','error')
    end
end)


RegisterNetEvent('unmask')
AddEventHandler('unmask',function()
    local closestPed = GetClosestPed()
    if closestPed ~= -1 then
        local id = GetPlayerServerId(NetworkGetEntityOwner(closestPed))
        TriggerServerEvent('use:unmask',id)
    else
        QBCore.Functions.Notify('No one nearby!','error')
    end
end)


RegisterNetEvent('unmask:drop')
AddEventHandler('unmask:drop',function()
    local ped = PlayerPedId()
    SetPedComponentVariation(ped, 1, -1, 0, 2)
    SetPedComponentVariation(ped, 1, -1, 0, 0)
end)

function GetClosestPed()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closePed = -1

    for _,player in pairs(QBCore.Functions.GetPlayers()) do 
        local playerPed = GetPlayerPed(player)
        if playerPed ~= ped then
            local playerCoords = GetEntityCoords(playerPed)
            local dist = #(coords - playerCoords)
            if dist < 2 then
                closePed = playerPed
            end
        end
    end


    return closePed
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)    
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end
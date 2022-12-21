local QBCore
local PlayerJob
local DoorlockData
local ClosestDoorIndex
local ClosestDoorDist
local ClosestDoorCoords

local DoorlockEntitys = {}
local MinimumLockDist = 7.5
local IsSpamming = false

-- // Events
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    PlayerJob = QBCore.Functions.GetPlayerData().job.name
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(PlayerJobCb)
    PlayerJob = PlayerJobCb.name
end)

RegisterNetEvent("dl-doorlock:Client:SyncData")
AddEventHandler("dl-doorlock:Client:SyncData", function(Data)
    DoorlockData = Data
end)

RegisterNetEvent("dl-doorlock:Client:SetDoorState")
AddEventHandler("dl-doorlock:Client:SetDoorState", function(DoorIndex, DoorState)
    DoorlockData[DoorIndex].LockState = DoorState
end)

-- // Threads
CreateThread(function()
    TriggerEvent("QBCore:GetObject", function(Object) QBCore = Object end)
    TriggerServerEvent("dl-doorlock:Server:SyncData")

    while (DoorlockData == nil or QBCore == nil) do
        Wait(50)
    end

    while (QBCore.Functions.GetPlayerData().job == nil) do Wait(250) end

    PlayerJob = QBCore.Functions.GetPlayerData().job.name

    for Index = 1, #DoorlockData do
        local Door = GetClosestObjectOfType(DoorlockData[Index].Coords.x, DoorlockData[Index].Coords.y, DoorlockData[Index].Coords.z, 0.05, DoorlockData[Index].Hash)
        if (Index == 79) then
        print(Door) 
        end
        FreezeEntityPosition(Door, DoorlockData[Index].LockState)

        if (DoorlockData[Index].LockedYaw) then
            SetEntityHeading(Door, DoorlockData[Index].LockedYaw)
        end
        DoorlockEntitys[Index] = Door

        Wait(10)
    end

    while (true) do
        local PlayerPed = PlayerPedId()
        local PlayerCoords = GetEntityCoords(PlayerPed)

        local ClosestDoorIndexTemp
        local ClosestDoorCoordsTemp
        local ClosestDoorDistTemp = math.huge

        for Index = 1, #DoorlockData do
            local Dist = GetDist(PlayerCoords, DoorlockData[Index].Coords)

            if (Dist < ClosestDoorDistTemp) then
                ClosestDoorDistTemp = Dist
                ClosestDoorCoordsTemp = DoorlockData[Index].Coords
                ClosestDoorIndexTemp = Index
            end

            Wait(1)
        end

        ClosestDoorCoords = ClosestDoorCoordsTemp
        ClosestDoorIndex = ClosestDoorIndexTemp
        ClosestDoorDist = ClosestDoorDistTemp

        Wait(50)
    end
end)

CreateThread(function()
    while (true) do
        for Index = 1, #DoorlockEntitys do
            if (not DoesEntityExist(DoorlockEntitys[Index])) then
                DoorlockEntitys[Index] = GetClosestObjectOfType(DoorlockData[Index].Coords.x, DoorlockData[Index].Coords.y, DoorlockData[Index].Coords.z, 0.05, DoorlockData[Index].Hash)
                Wait(10)
            end
            
            FreezeEntityPosition(DoorlockEntitys[Index], DoorlockData[Index].LockState)

            if (DoorlockData[Index].LockState) then
                if (DoorlockData[Index].LockedYaw) then
                    SetEntityHeading(DoorlockEntitys[Index], DoorlockData[Index].LockedYaw)
                end
            end
    
            Wait(50)
        end

        Wait(0)
    end
end)

CreateThread(function()
    while (ClosestDoorCoords == nil) do Wait(50) end

    while (true) do
        if (ClosestDoorDist < MinimumLockDist) then
            if (DoorlockData[ClosestDoorIndex].LockState) then
                Draw3DText(ClosestDoorCoords.x, ClosestDoorCoords.y, ClosestDoorCoords.z, "[E] - Locked (" .. ClosestDoorIndex .. ")")
            else
                Draw3DText(ClosestDoorCoords.x, ClosestDoorCoords.y, ClosestDoorCoords.z, "[E] - Unlocked (" .. ClosestDoorIndex .. ")")
            end
        else
            Wait(100)
        end

        Wait(5)
    end
end)

RegisterNetEvent("dl-doorlock:Client:CrackDoorState")
AddEventHandler("dl-doorlock:Client:CrackDoorState", function()
    if (DoorlockData[ClosestDoorIndex].CanCrack) then
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDist(DoorlockData[ClosestDoorIndex].Coords, playerCoords)
        if (distance < MinimumLockDist) then
            local SkillbarSuccess = exports["dl-skillbar"]:CreateSkillbar(20, "medium")
            if (SkillbarSuccess) then
                TriggerServerEvent("dl-doorlock:Server:SetDoorState", ClosestDoorIndex, false)
            end
            local random = math.random(1,100)
            if random <= 15 then
                QBCore.Functions.Notify("Your lockpick is broken!", "error")        
                TriggerServerEvent('dl-doorlock:server:removeLockpick')
            end

        end
    end
end)

RegisterCommand("+PickDoor", function()
    if (ClosestDoorDist < MinimumLockDist and not IsSpamming) then
        IsSpamming = true

        if (PlayerJob == DoorlockData[ClosestDoorIndex].Job) then
            local Door = DoorlockEntitys[ClosestDoorIndex]
            DoorlockData[ClosestDoorIndex].LockState = not DoorlockData[ClosestDoorIndex].LockState

            TriggerServerEvent("dl-doorlock:Server:SetDoorState", ClosestDoorIndex, DoorlockData[ClosestDoorIndex].LockState)

            PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)

            if (DoorlockData[ClosestDoorIndex].LockState) then
                print("lock pos")

                FreezeEntityPosition(Door, DoorlockData[ClosestDoorIndex].LockState)
                
                if (DoorlockData[ClosestDoorIndex].LockedYaw) then
                    print("lock yaw")
                    SetEntityHeading(Door, DoorlockData[ClosestDoorIndex].LockedYaw)
                end

                QBCore.Functions.Notify("Door Locked!", "error")
            else
                FreezeEntityPosition(Door, DoorlockData[ClosestDoorIndex].LockState)

                QBCore.Functions.Notify("Door Unlocked!", "success")
            end
        else
            QBCore.Functions.Notify("You don't have a key to open this door.", "error")
        end

        Wait(250)
        
        IsSpamming = false
    end
end)

RegisterKeyMapping("+PickDoor", "Toggle Door Lock", "keyboard", "e")
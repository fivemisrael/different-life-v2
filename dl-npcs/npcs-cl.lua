local QBCore = nil
TriggerEvent("QBCore:GetObject", function(object) QBCore = object end)

local playerLoaded = false

local loadModel = function(modelName)
    local modelHash = GetHashKey(modelName)
    RequestModel(modelHash)

    while (not HasModelLoaded(modelHash)) do
        print("loadModel(" .. modelName .. ")")
        Wait(0)
    end

    return modelHash
end
local saveClothes = function()
    local ped = GetPlayerPed(-1)
    mask_old,mask_tex,mask_pal = GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedPaletteVariation(ped,1)
    vest_old,vest_tex,vest_pal = GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedPaletteVariation(ped,9)
    glass_prop,glass_tex = GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1)
    hat_prop,hat_tex = GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0)
    jacket_old,jacket_tex,jacket_pal = GetPedDrawableVariation(ped, 11),GetPedTextureVariation(ped,11),GetPedPaletteVariation(ped,11)
    shirt_old,shirt_tex,shirt_pal = GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedPaletteVariation(ped,8)
    arms_old,arms_tex,arms_pal = GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedPaletteVariation(ped,3)
    pants_old,pants_tex,pants_pal = GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedPaletteVariation(ped,4)
    feet_old,feet_tex,feet_pal = GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedPaletteVariation(ped,6)
    hair_old,hair_tex,hair_pal = GetPedDrawableVariation(ped,2),GetPedTextureVariation(ped,2),GetPedPaletteVariation(ped,2)
end

local draw3dText = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
local notificationText = function(text, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(time, false)
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    playerLoaded = true
end)

local lesterPed
CreateThread(function()
    
   while (QBCore == nil or not playerLoaded) do
     Wait(0)
   end


   local lamarHash = loadModel("ig_lamardavis")
   local lesterHash = loadModel("cs_lestercrest")
   local lamarCoords = vector3(-145.19306945801, -1663.3043212891, 31.723701477051)
   local lesterCoords = vector3(705.75250244141, -964.06091308594, 29.395347595215)
   local lamerPed = CreatePed(4, lamarHash, lamarCoords.x, lamarCoords.y, lamarCoords.z, 50.5, false, true)
   lesterPed = CreatePed(4, lesterHash, lesterCoords.x, lesterCoords.y, lesterCoords.z, 230.5, false, true)
    
    FreezeEntityPosition(lamerPed, true)
    SetBlockingOfNonTemporaryEvents(lamerPed, true)
    SetEntityInvincible(lamerPed, true)

    FreezeEntityPosition(lesterPed, true)
    SetBlockingOfNonTemporaryEvents(lesterPed, true)
    SetEntityInvincible(lesterPed, true)

    local lamarRep = QBCore.Functions.GetPlayerData().metadata.lamarrep

    local lamarMissions = {
        function()
            QBCore.Functions.Notify("Go to the house marked on your GPS")
            PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds")

            local houseCoords = vector3(126.82649230957, -1930.060546875, 20.382410049438)
            SetNewWaypoint(houseCoords.x, houseCoords.y)

            local playerPed = PlayerPedId()
            
            local currentCheckpoint = CreateCheckpoint(45, houseCoords.x, houseCoords.y, houseCoords.z, 0.0, 0.0, 0.0, 0.3, 255, 255, 0, 125)
            SetCheckpointCylinderHeight(currentCheckpoint, 0.3, 0.3, 0.3)

            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - houseCoords)

            while (distance > 1.5) do
                playerCoords = GetEntityCoords(playerPed)
                distance = #(playerCoords - houseCoords)
                Wait(0)
            end

            DeleteCheckpoint(currentCheckpoint)

            QBCore.Functions.Progressbar("hack_gate", "Breaking into the house...", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@gangops@facility@servers@",
                anim = "hotwire",
                flags = 16,
            }, {}, {}, function()
                local insideCoords = vector3(266.10589599609, -1007.5370483398, -102.00849914551)

                SetEntityCoords(playerPed, insideCoords)

                local enemyOne = CreatePed(4, loadModel("g_m_y_ballaeast_01"), 257.08520507812,-998.33984375,-99.008529663086, 350.5, false, true)
                local enemyTwo = CreatePed(4, loadModel("g_m_y_ballaorig_01"), 260.50045776367,-996.57904052734,-99.008529663086, 350.5, false, true)
                
                TaskCombatPed(enemyOne, playerPed)
                TaskCombatPed(enemyTwo, playerPed)

                while (not IsPedDeadOrDying(enemyOne) or not IsPedDeadOrDying(enemyTwo)) do Wait(0) end

                local bongCoords = vector3(258.928, -996.429, -99.563)

                currentCheckpoint = CreateCheckpoint(45, bongCoords.x, bongCoords.y, bongCoords.z, 0.0, 0.0, 0.0, 0.3, 255, 255, 0, 125)
                SetCheckpointCylinderHeight(currentCheckpoint, 0.3, 0.3, 0.3)

                playerCoords = GetEntityCoords(playerPed)
                distance = #(playerCoords - bongCoords)
    
                while (distance > 1.0) do
                    playerCoords = GetEntityCoords(playerPed)
                    distance = #(playerCoords - bongCoords)
                    print(distance)
                    Wait(0)
                end

                DeleteCheckpoint(currentCheckpoint)

                QBCore.Functions.Progressbar("hack_gate", "Picking up lamar's bong...", 1000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "random@domestic",
                    anim = "pickup_low",
                    flags = 16,
                }, {}, {}, function()
                    local bongEntity = GetClosestObjectOfType(bongCoords.x, bongCoords.y, bongCoords.z, 2.0, GetHashKey("prop_bong_01"), false)
                    SetEntityAsMissionEntity(bongEntity, true, true)
                    DeleteEntity(bongEntity)

                    currentCheckpoint = CreateCheckpoint(45, insideCoords.x, insideCoords.y, insideCoords.z, 0.0, 0.0, 0.0, 0.3, 255, 255, 0, 125)
                    SetCheckpointCylinderHeight(currentCheckpoint, 0.3, 0.3, 0.3)
    
                    playerCoords = GetEntityCoords(playerPed)
                    distance = #(playerCoords - insideCoords)
        
                    while (distance > 1.5) do
                        playerCoords = GetEntityCoords(playerPed)
                        distance = #(playerCoords - insideCoords)
                        Wait(0)
                    end

                    QBCore.Functions.Notify("Head back to lamar")
    
                    DeleteCheckpoint(currentCheckpoint)
    
                    SetEntityCoords(playerPed, houseCoords)
    
                    SetNewWaypoint(lamarCoords.x, lamarCoords.y)
    
                    currentCheckpoint = CreateCheckpoint(45, lamarCoords.x, lamarCoords.y, lamarCoords.z, 0.0, 0.0, 0.0, 1.0, 255, 255, 0, 125)
                    SetCheckpointCylinderHeight(currentCheckpoint, 1.0, 1.0, 1.0)
    
                    playerCoords = GetEntityCoords(playerPed)
                    distance = #(playerCoords - lamarCoords)
                    
                    while (distance > 1.5) do
                        playerCoords = GetEntityCoords(playerPed)
                        distance = #(playerCoords - lamarCoords)
                        Wait(0)
                    end
    
                    DeleteCheckpoint(currentCheckpoint)
    
                    lamarRep = 1
                    TriggerServerEvent("dl-npcs:server:setRep", "lamarrep", lamarRep)

                    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
                end)
            end)
        end,
        function()
            local speedoHash = loadModel("speedo")
            local speedoCoords = vector3(444.33526611328,-3047.2609863281,5.809446811676)
            local speedoVehicle = CreateVehicle(speedoHash, speedoCoords, 268.80, false, true)

            local playerPed = PlayerPedId()

            SetNewWaypoint(speedoCoords.x, speedoCoords.y)
            QBCore.Functions.Notify("Go steal the van marked on your GPS to get lamar's equipment, be careful!")
            PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds")

            local enemiesList = {
                {
                    hash = loadModel("g_m_y_korean_01"),
                    coords = vector3(447.13690185547,-3047.7958984375,6.0696330070496),
                    heading = 268.80,
                    ped = nil
                },
                {
                    hash = loadModel("g_m_y_korean_02"),
                    coords = vector3(447.29568481445,-3046.7746582031,6.0696320533752),
                    heading = 268.80,
                    ped = nil
                },
                {
                    hash = loadModel("g_m_y_mexgoon_01"),
                    coords = vector3(448.0373840332,-3047.7421875,6.0696315765381),
                    heading = 88.8,
                    ped = nil
                },
                {
                    hash = loadModel("g_m_y_mexgoon_03"),
                    coords = vector3(447.8212890625,-3046.5727539062,6.0696315765381),
                    heading = 88.8,
                    ped = nil
                },
                
            }

            AddRelationshipGroup("missionEnemies")
            SetPedRelationshipGroupHash(playerPed, GetHashKey("PLAYER"))
            SetRelationshipBetweenGroups(5, GetHashKey("missionEnemies"), GetHashKey("PLAYER"))
    		SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("missionEnemies"))
			SetRelationshipBetweenGroups(0, GetHashKey("missionEnemies"), GetHashKey("missionEnemies"))

            for enemyIndex = 1, #enemiesList do
                enemiesList[enemyIndex].ped = CreatePed(4, enemiesList[enemyIndex].hash, enemiesList[enemyIndex].coords.x, enemiesList[enemyIndex].coords.y, enemiesList[enemyIndex].coords.z, enemiesList[enemyIndex].heading, false, true)
                GiveWeaponToPed(enemiesList[enemyIndex].ped, `weapon_bat`, 255, true, false)
                SetPedRelationshipGroupHash(enemiesList[enemyIndex].ped, GetHashKey("missionEnemies"))
            end
            
            local shouldContinue = true
            while (shouldContinue) do
                shouldContinue = false

                for enemyIndex = 1, #enemiesList do
                    if (not IsPedDeadOrDying(enemiesList[enemyIndex].ped)) then
                        shouldContinue = true
                    end
                end

                Wait(0)
            end

            while (GetVehiclePedIsUsing(playerPed) ~= speedoVehicle) do
                DrawMarker(0, speedoCoords.x, speedoCoords.y, speedoCoords.z + 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0.0, 100.0, true, false, false, false)
                Wait(0)
            end

            TriggerEvent("vehiclekeys:client:GiveKeys")

            QBCore.Functions.Notify("Head back to lamar.")
            SetNewWaypoint(lamarCoords.x, lamarCoords.y)
    
            local currentCheckpoint = CreateCheckpoint(45, lamarCoords.x, lamarCoords.y, lamarCoords.z, 0.0, 0.0, 0.0, 1.0, 255, 255, 0, 125)
            SetCheckpointCylinderHeight(currentCheckpoint, 1.0, 1.0, 1.0)

            playerCoords = GetEntityCoords(playerPed)
            distance = #(playerCoords - lamarCoords)
            
            while (distance > 1.5) do
                playerCoords = GetEntityCoords(playerPed)
                distance = #(playerCoords - lamarCoords)
                Wait(0)
            end

            DeleteCheckpoint(currentCheckpoint)

            SetEntityAsMissionEntity(speedoVehicle, true, true)
            DeleteEntity(speedoVehicle)

            PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")

            lamarRep = 2
            TriggerServerEvent("dl-npcs:server:setRep", "lamarrep", lamarRep)
        end,
        function()
            PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds")

            QBCore.Functions.Notify("I need you to go and find a close friend of mine")
            Wait(5000)
            QBCore.Functions.Notify("Lester went missing, I'll send you the coords to his house, Try to find his location")

            local houseCoords = vector3(1275.1163330078, -1721.7572021484, 54.65502166748)
            SetNewWaypoint(houseCoords.x, houseCoords.y)

            local playerPed = PlayerPedId()

            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - houseCoords)

            while (distance > 1.5) do
                playerCoords = GetEntityCoords(playerPed)
                distance = #(playerCoords - houseCoords)
                Wait(0)
            end

            QBCore.Functions.Notify("Search lester's drawer")

            local drawerCoords = vector3(1272.2004394531, -1711.6177978516, 54.77144622802)
            local bedCoords = vector3(1275.9522705078, -1713.9442138672, 54.771434783936)
            local compCoords = vector3(1275.6796875, -1710.4202880859, 54.771457672119)


            local searched = {}
            searched[1] = false
            searched[2] = false
            searched[3] = false
            while not searched[1] do
                Wait(0)
                playerCoords = GetEntityCoords(playerPed)
                if #(playerCoords - drawerCoords) < 4 then
                    DrawMarker(0, drawerCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 55, 155, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                    if IsControlJustReleased(1, 38) and #(playerCoords - drawerCoords) < 1 then
                        QBCore.Functions.Progressbar("hack_gate", "Searching the drawer", 1000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "random@domestic",
                            anim = "pickup_low",
                            flags = 16,
                        }, {}, {}, function()
                            QBCore.Functions.Notify("You found a hot mom magazine")
                            searched[1] = true
                        end)
                    end
                end
            end

            Wait(5000)
            QBCore.Functions.Notify("Search lester's bed, maybe something is there")

            while not searched[2] do
                Wait(0)
                playerCoords = GetEntityCoords(playerPed)
                if #(playerCoords - bedCoords) < 4 then
                    DrawMarker(0, bedCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 55, 155, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                    if IsControlJustReleased(1, 38) and #(playerCoords - bedCoords) < 1 then
                        QBCore.Functions.Progressbar("hack_gate", "Searching the bed", 1000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "random@domestic",
                            anim = "pickup_low",
                            flags = 16,
                        }, {}, {}, function()
                            QBCore.Functions.Notify("You found a sticky white glue")
                            searched[2] = true
                        end)
                    end
                end
            end

            Wait(5000)
            QBCore.Functions.Notify("Well, maybe there is something is his computer")

            while not searched[3] do
                Wait(0)
                playerCoords = GetEntityCoords(playerPed)
                if #(playerCoords - bedCoords) < 4 then
                    draw3dText(compCoords.x, compCoords.y, compCoords.z, "[~g~E~w~] Search PC")
                    if IsControlJustReleased(1, 38) and #(playerCoords - compCoords) < 1 then
                        QBCore.Functions.Progressbar("hack_gate", "Searching the computer", 1000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "random@domestic",
                            anim = "pickup_low",
                            flags = 16,
                        }, {}, {}, function()                        
                            searched[3] = true

                            ExecuteCommand("e type")

                            local prisoned = false
                            local gameResults = true --exports["dl-hackingame"]:CreateHackGame("medium")
                            if gameResults then
                                local possibleCoords = {
                                    vector3(1919.0212402344, 585.41265869141, 176.36740112305),
                                    vector3(-1892.5842285156, 2045.14453125, 140.85481262207),
                                    vector3(-1078.6691894531, 4908.2387695312, 213.59429931641)
                                }
                                QBCore.Functions.Notify("The goverment is after lester, which means they are after you")
                                Wait(5000)
                                for i = 1, 3 do 
                                    local chosenCoords = possibleCoords[1]
                                    table.remove(possibleCoords, 1)

                                    SetNewWaypoint(chosenCoords.x, chosenCoords.y)

                                    local chosenCoordsBlip = AddBlipForCoord(chosenCoords.x, chosenCoords.y, chosenCoords.z)
                                    SetBlipSprite(chosenCoordsBlip , 161)
                                    SetBlipScale(chosenCoordsBlip , 1.0)
                                    SetBlipColour(chosenCoordsBlip, 3)
                                
                                    QBCore.Functions.Notify("You found a possible location, go search the area and scan for evidences")

                                    distance = #(playerCoords - chosenCoords)

                                    while (distance > 8) do
                                        playerCoords = GetEntityCoords(playerPed)
                                        distance = #(playerCoords - chosenCoords)
                                        Wait(0)
                                    end

                                    Wait(2000)

                                    local retval, spawnCoords, heading = GetClosestVehicleNodeWithHeading(playerCoords.x, playerCoords.y, playerCoords.z, 1, 6.0, 0)
                                    RequestModel(GetHashKey("v_ind_ss_laptop"))
                                    while not HasModelLoaded(GetHashKey("v_ind_ss_laptop")) do Wait(250) end 

                                    local table = CreateObject(GetHashKey("v_ind_ss_laptop"), spawnCoords.x, spawnCoords.y, spawnCoords.z, false, true, true)
                                    FreezeEntityPosition(table, true)
                                    SetEntityAsMissionEntity(table, true, true)


                                    local count = 25
                                    local x = 0
                                    while count > 0 do
                                        Wait(0)
                                        x = x + 10
                                        notificationText("You have  ~r~" .. count .. "~w~ seconds to find Lester", 1000)
                                        if math.fmod(x , 1000) == 0 and count > 0 then
                                            count = count - 1
                                        end
                                        playerCoords = GetEntityCoords(PlayerPedId())
                                        
                                        if DoesEntityExist(table) then
                                            DrawMarker(0, spawnCoords.x, spawnCoords.y, spawnCoords.z + 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0.0, 100.0, true, false, false, false)
                                        end

                                        if #(playerCoords - spawnCoords) < 2 then
                                            draw3dText(spawnCoords.x, spawnCoords.y, spawnCoords.z + 2.0, "[~g~E~w~] Search For Evidence")
                                            if IsControlJustReleased(1, 38) then
                                                QBCore.Functions.Progressbar("hack_gate", "Searching for evidence", 1000, false, true, {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                }, {
                                                    animDict = "random@domestic",
                                                    anim = "pickup_low",
                                                    flags = 16,
                                                }, {}, {}, function()
                                                    chosenCoordsBlip = RemoveBlip(chosenCoordsBlip)
                                                    table = DeleteObject(table)
                                                    count = -1
                                                    Wait(2000)
                                                end)
                                            end
                                        end
            
                                    end

                                    if count == 0 then
                                        prisoned = true
                                        QBCore.Functions.Notify("Times out, Prison IN!")
                                        TriggerEvent("prison:client:Enter", 10)
                                        break
                                        
                                    end
                                    

                                end
                                if not prisoned then
                                    Wait(1 * 60000)
                                    TriggerServerEvent('qb-phone:server:sendNewMail', {
                                        sender = "Lester",
                                        subject = "What do you want",
                                        message = "I assume you want to see me, I assure you, You want to. Im sending you my location, Come see me",
                                        button = {
                                            enabled = true,
                                            buttonEvent = "dl-npcs:client:meetUpWithLester",
                                        }
                                    })
                                end

                            else
                                QBCore.Functions.Notify("Not everyone are ment for greatness, maybe next time")
                            end
                        end)
                    end

                end
            end

        end
    }


    local lamarShop = {
        {
            {
                name = "lockpick",
                price = 200,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            {
                name = "advancedlockpick",
                price = 250,
                amount = 50,
                info = {},
                type = "item",
                slot = 2,
            },
            {
                name = "heavyarmor",
                price = 150,
                amount = 50,
                info = {},
                type = "item",
                slot = 3,
            }
        },
        {
            {
                name = "lockpick",
                price = 200,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            {
                name = "advancedlockpick",
                price = 250,
                amount = 50,
                info = {},
                type = "item",
                slot = 2,
            },
            {
                name = "weapon_knuckle",
                price = 300,
                amount = 50,
                info = {},
                type = "item",
                slot = 3,
            },
            {
                name = "nitrous",
                price = 1500,
                amount = 50,
                info = {},
                type = "item",
                slot = 4,
            },
            {
                name = "screwdriverset",
                price = 550,
                amount = 50,
                info = {},
                type = "item",
                slot = 5,
            },
            {
                name = "thermite",
                price = 550,
                amount = 50,
                info = {},
                type = "item",
                slot = 6,
            }
        },
        {
            {
                name = "lockpick",
                price = 200,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            {
                name = "advancedlockpick",
                price = 250,
                amount = 50,
                info = {},
                type = "item",
                slot = 2,
            },
            {
                name = "weapon_knuckle",
                price = 300,
                amount = 50,
                info = {},
                type = "item",
                slot = 3,
            },
            {
                name = "nitrous",
                price = 1500,
                amount = 50,
                info = {},
                type = "item",
                slot = 4,
            },
            {
                name = "screwdriverset",
                price = 550,
                amount = 50,
                info = {},
                type = "item",
                slot = 5,
            },
            {
                name = "thermite",
                price = 550,
                amount = 50,
                info = {},
                type = "item",
                slot = 6,
            }
        }
    }

    while (true) do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - lamarCoords)
        local lesterDistance = #(playerCoords - lesterCoords)

        if (distance < 1.5) then
            draw3dText(lamarCoords.x, lamarCoords.y, lamarCoords.z + 2.0, "[~g~E~w~] Open Shop | [~r~G~w~] Start Mission (Reputation: " .. lamarRep .. ")")
            
            if (IsControlJustPressed(0, 38)) then
                if (lamarRep > 0) then
                    local shopItems = {}
                    shopItems.label = "Lamar Black Market"
                    shopItems.items = lamarShop[lamarRep]
                    shopItems.slots = 30

                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_Blackmarket", shopItems)
                else
                    QBCore.Functions.Notify("Lamar doesn't trust you...")
                end
            elseif (IsControlJustPressed(0, 47)) then
                lamarMissions[lamarRep + 1]()
            end
        end

        if (lesterDistance < 1.5) then
            draw3dText(lesterCoords.x, lesterCoords.y, lesterCoords.z + 2.0, "Not available yet...")
        end
        Wait(0)
    end
end)


RegisterCommand("resetrep", function() 
        
    lamarRep = 2
    TriggerServerEvent("dl-npcs:server:setRep", "lamarrep", lamarRep)

end, false)

RegisterNetEvent("dl-npcs:client:meetUpWithLester")
AddEventHandler("dl-npcs:client:meetUpWithLester", function()

    local arriveCoords = vector3(718.10205078125, -976.60955810547, 24.908880233765)

    QBCore.Functions.Notify("Lester is waiting for you, drive to him")
    SetNewWaypoint(arriveCoords.x, arriveCoords.y)    


    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - arriveCoords)

    while (distance > 4) do
        playerCoords = GetEntityCoords(PlayerPedId())
        distance = #(playerCoords - arriveCoords)
        Wait(0)
    end

    local lesterCoords = GetEntityCoords(lesterPed)
    SetEntityCoords(lesterPed, lesterCoords.x, lesterCoords.y, lesterCoords.z - 200)



    RequestCutscene("heist_int", 8)
    while not (HasCutsceneLoaded()) do
        Wait(0)
        RequestCutscene("heist_int", 8)
    end
    saveClothes()
    SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), 'MP_1', 0, 0, 64)
    StartCutscene(0)
    while not (DoesCutsceneEntityExist('MP_1', 0)) do
        Wait(0)
    end


    SetCutscenePedComponentVariationFromPed(PlayerPedId(), GetPlayerPed(-1), 1885233650)
    SetPedComponentVariation(GetPlayerPed(-1), 11, jacket_old, jacket_tex, jacket_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 8, shirt_old, shirt_tex, shirt_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 3, arms_old, arms_tex, arms_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 4, pants_old,pants_tex,pants_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 6, feet_old,feet_tex,feet_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 1, mask_old,mask_tex,mask_pal)
    SetPedComponentVariation(GetPlayerPed(-1), 9, vest_old,vest_tex,vest_pal)
    SetPedPropIndex(GetPlayerPed(-1), 0, hat_prop, hat_tex, 0)
    SetPedPropIndex(GetPlayerPed(-1), 1, glass_prop, glass_tex, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 2, hair_old,hair_tex,hair_pal)


    while not (HasCutsceneFinished()) do
        Wait(0)
    end
    SetEntityCoords(lesterPed, 705.75250244141, -964.06091308594, 29.395347595215)

    lamarRep = 3
    TriggerServerEvent("dl-npcs:server:setRep", "lamarrep", lamarRep)

end)


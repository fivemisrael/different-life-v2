QBCore = nil
TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

local hacking = false

Citizen.CreateThread(function()
    while true do   
        Wait(0)
        local pPos = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(craftingLoc) do 
            if GetDistanceBetweenCoords(v.x, v.y, v.z, pPos) < 1.45 then
                if QBCore.Functions.GetPlayerData().job.name ~= "police" and QBCore.Functions.GetPlayerData().job.name ~= "ambulance" and not hacking then
                DrawText3Ds(v.x, v.y, v.z,  "[~g~E~w~] Open Crafting Menu")
                    if IsControlJustReleased(1, 38) then
                        SendNUIMessage({
                            openCrafting = true,
                            craftableItems = json.encode(craftableItems),
                            playerMetadata = QBCore.Functions.GetPlayerData().craftingmetadata    
                        })
                        SetNuiFocus(true, true)
            
                    end
                elseif QBCore.Functions.GetPlayerData().job.name == "police" then 
                    DrawText3Ds(v.x, v.y, v.z,  "~g~yo dude get out no one like snitches~w~")

                end
            end
        end
    end
end)


CreateThread(function()
    AddRelationshipGroup("peds")
    SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("peds"))
    for i = 1, #craftingLoc, 1 do
        local loc = craftingLoc[i]
        RequestModel("ig_djtalignazio")
        while not HasModelLoaded(GetHashKey("ig_djtalignazio")) do
            Wait(1)
        end
        local ped = CreatePed(4, GetHashKey("ig_djtalignazio"), loc.x, loc.y , loc.z- 1, 290.0977172851563, false, true)
        SetEntityInvincible(ped, true)
        PlaceObjectOnGroundProperly(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityCanBeDamaged(ped,false)
        LoadAnimDict("rcmnigel1a_band_groupies")
        TaskPlayAnim(ped, "rcmnigel1a_band_groupies", "base_m2", 8.0, 8.0, -1, 1, 1)
        FreezeEntityPosition(ped, true)
    end
end)

function LoadAnimDict(AnimDict)
    if (not HasAnimDictLoaded(AnimDict)) then
        RequestAnimDict(AnimDict)
        while (not HasAnimDictLoaded(AnimDict)) do
            Wait(250)
        end
    end
end

function DrawText3Ds(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
      SetTextScale(0.30, 0.30)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
      local factor = (string.len(text)) / 370
      DrawRect(_x,_y+0.0120, factor, 0.03, 0, 0, 0, 75)
    end
  end

RegisterNUICallback("craftItem", function(data)

    SetNuiFocus(false, false)
    SendNUIMessage({
        close = true
    })

    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do Wait(250) end
    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 1.0, 1.0, -1, 0, 0)

    Wait(1000)

    hacking = true
    local skillbarSuccess = exports["dl-skillbar"]:CreateSkillbar(5, "medium")
    if (skillbarSuccess) then
        local item = craftableItems[data.id+1]
        TriggerServerEvent("dl-crafting-ido:server:rewardCraft", item)
    else 
        QBCore.Functions.Notify("Hacking failed!")
    end
    Wait(1000)
    hacking = false


end)


RegisterNUICallback("breakItem", function(data)


    SetNuiFocus(false, false)
    SendNUIMessage({
        close = true
    })

    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do Wait(250) end
    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 1.0, 1.0, -1, 0, 0)

    Wait(1000)

    hacking = true
    local skillbarSuccess = exports["dl-skillbar"]:CreateSkillbar(5, "medium")
    if (skillbarSuccess) then
        local item = craftableItems[data.id+1]
        TriggerServerEvent("dl-crafting-ido:server:rewardBreak", item)
    end
    hacking = false

end)


RegisterNUICallback("close", function()
    SetNuiFocus(false, false)

end)
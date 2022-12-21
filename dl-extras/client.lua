RLCore = nil
Enabled = false
Current = 'main'

CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent(Settings.Core .. ':GetObject', function(obj) RLCore = obj end)
    end
end)

RegisterNetEvent("partizanrp:evidence")
AddEventHandler("partizanrp:evidence", function(id)
    local id = tonumber(id)
    if CanOpenEvidence() and id and math.floor(id) == id then
   	 TriggerServerEvent("inventory:server:OpenInventory", "stash", "evidence_" .. tostring(id), {
        	maxweight = 4000000,
        	slots = 500,
    	})
    	TriggerEvent("inventory:client:SetCurrentStash", "evidence_" .. tostring(id))
    end
end)

RegisterNetEvent("partizanrp:extras:openMenu")
AddEventHandler("partizanrp:extras:openMenu", function(menu)
    local plyPed = PlayerPedId()
    local coords = GetEntityCoords(plyPed)
    local vehicle = GetVehiclePedIsUsing(plyPed)

    if not DoesEntityExist(vehicle) or not IsNearLocation(coords) then
        return false
    end

    Current = menu
    Enabled = true
    RefreshGUI(Current)
    SendNUIMessage({ ['display'] = true })
    SetNuiFocus(true, true)

    while Enabled do
        Wait(1)
        if not DoesEntityExist(vehicle) then
            break
        end
    end

    Enabled = false
    SendNUIMessage({ ['display'] = false })
    SetNuiFocus(false, false)
end)

function IsNearLocation(coords)
    for i=1, #Settings.Locations do
        local loc = Settings.Locations[i]
        local dist = Vdist(coords['x'], coords['y'], coords['z'], loc['x'], loc['y'], loc['z'])
        if dist <= 50 then
            return true
        end
    end

    return false
end

function CanOpenEvidence()
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
    local vehicle = RLCore.Functions.GetClosestVehicle()

    if vehicle ~= 0 and vehicle ~= nil then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local vehpos = GetEntityCoords(vehicle)
        local newpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
        local disatance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y,plyCoords.z,newpos.x, newpos.y, newpos.z)
        if disatance < 2 then
            return true
        end
    end

    return IsNearLocation(plyCoords)
end

function RefreshGUI(menu)
    local plyPed = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(plyPed)
    local data = Settings.Menu[menu]

    if menu == 'extras' then
        data['items'] = {}

        for id = 0, 12 do
            if DoesExtraExist(vehicle, id) then
                local icon = IsVehicleExtraTurnedOn(vehicle, id) and 'far fa-check-circle' or 'fas fa-times'
                data['items'][#data['items']+1] = { ['label'] = "Extra " .. tostring(id), ['extra'] = id, ['icon'] = icon }
            end
        end

    elseif menu == 'livery' then
        data['items'] = {}

        for id = 0, GetVehicleLiveryCount(vehicle) do
            if DoesExtraExist(vehicle, id) then
                local icon = GetVehicleLivery(vehicle) ~= id and 'fas fa-times' or 'far fa-check-circle'
                data['items'][#data['items']+1] = { ['label'] = "Livery " .. tostring(id), ['livery'] = id, ['icon'] = icon }
            end
        end
    elseif menu == 'tint' then
        data['items'] = {}

        for id = 1, GetNumVehicleWindowTints() do
            local icon = GetVehicleWindowTint(vehicle) ~= id and 'fas fa-times' or 'far fa-check-circle'
            data['items'][#data['items']+1] = { ['label'] = "Window Tint " .. tostring(id), ['tint'] = id, ['icon'] = icon }
        end
    end

    local html = '<div class="header">' .. data['label']
    html = html .. '<i class="fas fa-times-circle close"></i>'
    if data['back'] then
        html = html .. '<i class="fas fa-arrow-left back"></i>'
    end
    html = html .. "</div>"

    for i=1, #data['items'] do
        local item = data['items'][i]
        local icon = item['icon'] ~= nil and item['icon'] or 'fas fa-times'
        if item['extra'] then
            html = html .. '<div class="item" label="' .. item['label'] .. '" extra="' .. item['extra'] .. '"><i class="' .. icon .. '"></i><span class="label">' .. item['label'] .. '</span></div>'
        elseif item['livery'] then
            html = html .. '<div class="item" label="' .. item['label'] .. '" livery="' .. item['livery'] .. '"><i class="' .. icon .. '"></i><span class="label">' .. item['label'] .. '</span></div>'
        elseif item['tint'] then
            html = html .. '<div class="item" label="' .. item['label'] .. '" tint="' .. item['tint'] .. '"><i class="' .. icon .. '"></i><span class="label">' .. item['label'] .. '</span></div>'
        elseif item['menu'] then
            html = html .. '<div class="item" label="' .. item['label'] .. '" menu="' .. item['menu'] .. '"><i class="' .. icon .. '"></i><span class="label">' .. item['label'] .. '</span></div>'
        end
    end

    if #data['items'] == 0 then
        html = html .. '<div class="item"><i class="fas fa-times"></i><span class="label">' .. data['empy'] .. '</span></div>'
    end

    SendNUIMessage({ ['update'] = html })
end

RegisterNUICallback("Update", function(data)
    local plyPed = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(plyPed)

    if data['label'] == "Repair" then
        Enabled = false
        SetVehicleFixed(vehicle)
    elseif data['menu'] then
        Current = data['menu']
        RefreshGUI(Current)
    elseif data['livery'] then
        SetVehicleLivery(vehicle, tonumber(data['livery']))
    elseif data['extra'] then
        data['extra'] = tonumber(data['extra'])
        SetVehicleExtra(vehicle, data['extra'], IsVehicleExtraTurnedOn(vehicle, data['extra']) and true or false)
    elseif data['tint'] then
        print(tonumber(data['tint']))
        SetVehicleWindowTint(vehicle, tonumber(data['tint']))
    end

    RefreshGUI(Current)
end)

RegisterNUICallback("Close", function()
    Enabled = false
end)
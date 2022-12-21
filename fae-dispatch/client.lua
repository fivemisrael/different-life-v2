QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local isLoggedIn = false
local PlayerData = {}
local PlayerJob = {}
local isCop = false
local isMedic = false
local Client_User = {}
local disp = false
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local GetAlertParams = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)

    if (intersectStreetName ~= "") then
        currentStreetName = currentStreetName .. ", " .. intersectStreetName
    end
    return currentStreetName, playerCoords, playerPed
end

CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)


RegisterNetEvent('dl-core:client:onPlayerLoaded')
AddEventHandler('dl-core:client:onPlayerLoaded', function()
    isLoggedIn = true
end)


local colorNames = {
    ['0'] = "Black",
    ['1'] = "Black",
    ['2'] = "Black",
    ['3'] = "Silver",
    ['4'] = "Silver",
    ['5'] = "Blue",
    ['6'] = "Gray",
    ['7'] = "Silver",
    ['8'] = "Silver",
    ['9'] = "Silver",
    ['10'] = "Metal",
    ['11'] = "Grey",
    ['12'] = "Black",
    ['13'] = "Gray",
    ['14'] = "Light Grey",
    ['15'] = "Black",
    ['16'] = "Black",
    ['17'] = "Dark Silver",
    ['18'] = "Silver",
    ['19'] = "Gun Metal",
    ['20'] = "Silver",
    ['21'] = "Black",
    ['22'] = "Graphite",
    ['23'] = "Silver Grey",
    ['24'] = "Silver",
    ['25'] = "Blue Silver",
    ['26'] = "Silver",
    ['27'] = "Red",
    ['28'] = "Red",
    ['29'] = "Red",
    ['30'] = "Red",
    ['31'] = "Red",
    ['32'] = "Red",
    ['33'] = "Red",
    ['34'] = "Red",
    ['35'] = "Red",
    ['36'] = "Orange",
    ['37'] = "Gold",
    ['38'] = "Orange",
    ['39'] = "Red",
    ['40'] = "Dark Red",
    ['41'] = "Orange",
    ['42'] = "Yellow",
    ['43'] = "Red",
    ['44'] = "Bright Red",
    ['45'] = "Red",
    ['46'] = "Red",
    ['47'] = "Golden Red",
    ['48'] = "Dark Red",
    ['49'] = "Dark Green",
    ['50'] = "Racing Green",
    ['51'] = "Sea Green",
    ['52'] = "Olive Green",
    ['53'] = "Green",
    ['54'] = "Blue Green",
    ['55'] = "Lime Green",
    ['56'] = "Dark Green",
    ['57'] = "Green",
    ['58'] = "Dark Green",
    ['59'] = "Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Blue",
    ['62'] = "Dark Blue",
    ['63'] = "Blue",
    ['64'] = "Blue",
    ['65'] = "Blue",
    ['66'] = "Blue",
    ['67'] = "Diamond Blue",
    ['68'] = "Blue",
    ['69'] = "Blue",
    ['70'] = "Bright Blue",
    ['71'] = "Purple Blue",
    ['72'] = "Blue",
    ['73'] = "Blue",
    ['74'] = "Bright Blue",
    ['75'] = "Dark Blue",
    ['76'] = "Blue",
    ['77'] = "Blue",
    ['78'] = "Blue",
    ['79'] = "Blue",
    ['80'] = "Blue",
    ['81'] = "Bright Blue",
    ['82'] = "Dark Blue",
    ['83'] = "Blue",
    ['84'] = "Blue",
    ['85'] = "Dark Blue",
    ['86'] = "Blue",
    ['87'] = "Light Blue",
    ['88'] = "Yellow",
    ['89'] = "Yellow",
    ['90'] = "Bronze",
    ['91'] = "Yellow",
    ['92'] = "Lime",
    ['93'] = "Champagne",
    ['94'] = "Pueblo Beige",
    ['95'] = "Dark Ivory",
    ['96'] = "Brown",
    ['97'] = "Brown",
    ['98'] = "Light Brown",
    ['99'] = "Beige",
    ['100'] = "Brown",
    ['101'] = "Brown",
    ['102'] = "Beechwood",
    ['103'] = "Dark Beechwood",
    ['104'] = "Orange",
    ['105'] = "Sand",
    ['106'] = "Sand",
    ['107'] = "Cream",
    ['108'] = "Brown",
    ['109'] = "Brown",
    ['110'] = "Light Brown",
    ['111'] = "White",
    ['112'] = "White",
    ['113'] = "Beige",
    ['114'] = "Brown",
    ['115'] = "Dark Brown",
    ['116'] = "Beige",
    ['117'] = "Steel",
    ['118'] = "Black steel",
    ['119'] = "Aluminium",
    ['120'] = "Chrome",
    ['121'] = "White",
    ['122'] = "White",
    ['123'] = "Orange",
    ['124'] = "Light Orange",
    ['125'] = "Green",
    ['126'] = "Yellow",
    ['127'] = "Blue",
    ['128'] = "Green",
    ['129'] = "Brown",
    ['130'] = "Orange",
    ['131'] = "White",
    ['132'] = "White",
    ['133'] = "Green",
    ['134'] = "White",
    ['135'] = "Pink",
    ['137'] = "Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Black Blue",
    ['142'] = "Black Purple",
    ['143'] = "Black Red",
    ['144'] = "Green",
    ['145'] = "Purple",
    ['146'] = "Dark Blue",
    ['147'] = "Black",
    ['148'] = "Purple",
    ['149'] = "Dark Purple",
    ['150'] = "Red",
    ['151'] = "Green",
    ['152'] = "Green",
    ['153'] = "Brown",
    ['154'] = "Tan",
    ['155'] = "Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Blue",
}

CreateThread(function()
	while true do
		Wait(10)
        if (isLoggedIn) then
    		local playerPed = PlayerPedId()
    		if IsPedShooting(playerPed) and not isCop and not IsPedCurrentWeaponSilenced(playerPed) and Config.GunshotAlert then
                local vehicleGet = GetVehiclePedIsIn(playerPed, false)
                local playerCoords = GetEntityCoords(playerPed)
    			if GetSelectedPedWeapon(playerPed) == GetHashKey("weapon_snowball") or GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_PUMPSHOTGUN") or GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_STUNGUN") then
    				Wait(1000)
    			else
                    if (IsPedInAnyVehicle(playerPed)) then
                        local primary, secondary = GetVehicleColours(vehicleGet)
                        primary = colorNames[tostring(primary)]
                        secondary = colorNames[tostring(secondary)]
                        TriggerServerEvent('fae-dispatch:alert', "10-32 From A Vehicle", "Locals heard gunshots in the area, requesting officers. Plate: " .. GetVehicleNumberPlateText(vehicleGet) .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet)) .. " P.Color: " .. primary .. " S.Color: " .. secondary, playerCoords, CoordToString(playerCoords))
                        TriggerServerEvent('fae-dispatch:EMSalert', "10-32 From A Vehicle", "Locals heard gunshots in the area, requesting officers. Plate: " .. GetVehicleNumberPlateText(vehicleGet) .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet)) .. " P.Color: " .. primary .. " S.Color: " .. secondary, playerCoords, CoordToString(playerCoords))
                    else
                        TriggerServerEvent('fae-dispatch:alert', "10-32", "Locals heard gunshots in the area, requesting officers.", playerCoords, CoordToString(playerCoords))
                        TriggerServerEvent('fae-dispatch:EMSalert', "10-32", "Locals heard gunshots in the area, requesting officers.", playerCoords, CoordToString(playerCoords))
                    end
                    Wait(5000)
    			end
    		end
            if IsPedInAnyVehicle(playerPed, true) and not isCop then
                local playerCoords = GetEntityCoords(playerPed)
                local currentVehicle = GetVehiclePedIsIn(playerPed, false)
                if(Config.SpeedType == "mph") then
                    speed = GetEntitySpeed(currentVehicle)
                else
                    speed = GetEntitySpeed(currentVehicle) * 3.6
                end
                local driverPed = GetPedInVehicleSeat(GetVehiclePedIsUsing(playerPed), -1)
                if driverPed == playerPed and speed > Config.SpeedLimit and not IsPedInAnyHeli(playerPed) then
                    if(10 <= math.random(1,10)) then
                        local vehicleGet = GetVehiclePedIsIn(playerPed, false)
                        local primary, secondary = GetVehicleColours(vehicleGet)
                        primary = colorNames[tostring(primary)]
                        secondary = colorNames[tostring(secondary)]
                        TriggerServerEvent('fae-dispatch:alert', "Speeding", "Locals reported that a vehicle is driving fast. Plate: " .. GetVehicleNumberPlateText(vehicleGet) .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicleGet)) .. " P.Color: " .. primary .. " S.Color: " .. secondary, playerCoords, CoordToString(playerCoords))
                        -- TriggerServerEvent('fae-dispatch:alert', "Speeding", "Locals reported that a vehicle is driving fast.", playerCoords, CoordToString(playerCoords))
                        Citizen.Wait(30000)
                    else
                        Citizen.Wait(4000)
                    end
                end
            end
        end
	end
end)


RegisterKeyMapping('+dispatch', 'Dispatch Open', 'keyboard', 'F10')
RegisterCommand('+dispatch', function(source,args,raw)
    authorized()
    if isCop or isMedic then
        display(not disp)
    end
end)


RegisterCommand('dispatch', function(source,args,raw)
    authorized()
    if isCop or isMedic then
        display(not disp)
    end
end)


RegisterCommand('dfix', function()
    authorized()
    if isCop or isMedic then
        display(false)
    end
end)

function display(show)
    TriggerEvent('fae-dispatch:importdata')
    QBCore.Functions.TriggerCallback('fae-dispatch:geteverything', function(user,c,p,calls,ab,ba,cb)
        Client_User = user
        if isCop and (Client_User.job == Config.EMSJob) then
            SendNUIMessage({
                type = "ui",
                show = show,
                user = user,
                cops = ba,
                patrols = ab,
                calls = cb,
                job = Client_User.job
            })
        else
            SendNUIMessage({
                type = "ui",
                show = show,
                user = user,
                cops = c,
                patrols = p,
                calls = calls,
                job = PlayerData.job.name
            })

        end
        disp = show
        SetNuiFocus(show, show)
    end)
end

RegisterNetEvent('fae-dispatch:cl_EMSgetlastcall')
AddEventHandler('fae-dispatch:cl_EMSgetlastcall', function(call)
    authorized()
    if (isMedic) then
        SendNUIMessage({
            type = "lastcall",
            call = call or {},
            sound = Config.SoundEffects,
            filename = "sound",
            volume = Config.Volume
        })
        if(Config.ShowBlips) then
            local alpha = 230
            local blip = AddBlipForCoord(call.coords.x, call.coords.y, call.coords.z)
            SetBlipHighDetail(blip, true)
            if(call.type == 'civreport') then
                SetBlipSprite(blip, 409)
            else
                SetBlipSprite(blip, 432)
            end
            SetBlipScale(blip, 1.5)
            SetBlipDisplay(blip, 2)
            SetBlipAlpha(blip, alpha)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            SetBlipFlashes(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("[~r~911~w~] ~b~"..call.title)
            EndTextCommandSetBlipName(blip)

            while alpha ~= 0 do
                Citizen.Wait(250)
                if alpha == 200 then
                    SetBlipFlashes(blip,false)
                    SetBlipAsShortRange(blip, false)
                    SetBlipColour(blip, 0)
                end
                alpha = alpha - 1
                SetBlipAlpha(blip, alpha)

                if alpha == 0 then
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

AddEventHandler("dl-alerts:client:requestHelp", function()
    local isDead = true
    if GetEntityHealth(PlayerPedId()) ~= 0 then
        ExecuteCommand("e tablet2")
        isDead = false
    end
    local currentStreetName, playerCoords = GetAlertParams()
    TriggerServerEvent("dl-alerts:server:requestHelp", currentStreetName, playerCoords, isDead)
end)

RegisterNetEvent('fae-dispatch:cl_getlastcall')
AddEventHandler('fae-dispatch:cl_getlastcall', function(call)
    authorized()
    if (isCop) then
        SendNUIMessage({
            type = "lastcall",
            call = call or {},
            sound = Config.SoundEffects,
            filename = "sound",
            volume = Config.Volume
        })
        if(Config.ShowBlips) then
            local alpha = 230
            local blip = AddBlipForCoord(call.coords.x, call.coords.y, call.coords.z)
            SetBlipHighDetail(blip, true)
            if(call.type == 'civreport') then
                SetBlipSprite(blip, 409)
            else
                SetBlipSprite(blip, 432)
            end
            SetBlipScale(blip, 1.5)
            SetBlipDisplay(blip, 2)
            SetBlipAlpha(blip, alpha)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            SetBlipFlashes(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("[~r~911~w~] ~b~"..call.title)
            EndTextCommandSetBlipName(blip)

            while alpha ~= 0 do
                Citizen.Wait(250)
                if alpha == 200 then
                    SetBlipFlashes(blip,false)
                    SetBlipAsShortRange(blip, false)
                    SetBlipColour(blip, 0)
                end
                alpha = alpha - 1
                SetBlipAlpha(blip, alpha)

                if alpha == 0 then
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('fae-dispatch:import-data-with-user')
AddEventHandler('fae-dispatch:import-data-with-user', function()
    QBCore.Functions.TriggerCallback('fae-dispatch:geteverything', function(c,r,s,p,ab,ba,cb)
        if(isCop) then
            if(Client_User.job == Config.EMSJob) then
                SendNUIMessage({
                    type = "importdatawithuser",
                    c = c or {},
                    r = ba or {},
                    s = ab or {},
                    p = cb or {},
                })
            else
                SendNUIMessage({
                    type = "importdatawithuser",
                    c = c or {},
                    r = r or {},
                    s = s or {},
                    p = p or {},
                })
            end


        end
    end)
end)

RegisterNetEvent('fae-dispatch:importdata')
AddEventHandler('fae-dispatch:importdata', function(a,b,c,ab,ba,cb)
    if(isCop) then
        if(PlayerData.job.name == Config.EMSJob) then
            SendNUIMessage({
                type = "importdata",
                b = ba or {},
                a = ab or {},
                c = cb or {},
            })

        else
            SendNUIMessage({
                type = "importdata",
                b = b or {},
                a = a or {},
                c = c or {},
            })
        end
    end
end)

RegisterNetEvent('fae-dispatch:openGPS')
AddEventHandler('fae-dispatch:openGPS', function()
    QBCore.Functions.TriggerCallback('fae-dispatch:geteverything', function(r)
        local data = nil
        if(r.job == Config.EMSJob) then
            data = {
                label = '[~r~'.. r.badge_no ..'~w~] ~r~'..r.firstname .. ' '.. r.lastname,
                job = "ems"
            }
        else
            data = {
                label = '[~b~'.. r.badge_no ..'~w~] ~b~'..r.firstname .. ' '.. r.lastname,
                job = "police"
            }
        end
        data.netId = NetworkGetNetworkIdFromEntity(PlayerPedId())
        TriggerServerEvent('fae-dispatch:Import_GPS', data)
    end)
end)

RegisterNetEvent('fae-dispatch:GPSInfinity')
AddEventHandler('fae-dispatch:GPSInfinity', function(k, b)
    b[k].netId = NetworkGetNetworkIdFromEntity(PlayerPedId())
    TriggerServerEvent('fae-dispatch:sv:GPSInfinity', k , b[k])
end)

RegisterNetEvent('fae-dispatch:GPS_Update')
AddEventHandler('fae-dispatch:GPS_Update', function(f)
    while QBCore.Functions.GetPlayerData == nil do
        Wait(100)
    end
    authorized()
    if(isCop) then
        for k,v in pairs(f) do
            local id = GetPlayerFromServerId(v.id)
            local ped =  GetPlayerPed(id)
            if v.closed then
                local blip = GetBlipFromEntity(ped)
                RemoveBlip(blip)
                table.remove(f, k)
                TriggerServerEvent('fae-dispatch:GPS_Table_Update', f)
            else
                if v.blip ~= nil then
                    RemoveBlip(v.blip)
                end
                if NetworkIsPlayerActive(id) then
                    local blip = GetBlipFromEntity(ped)
                    if not DoesBlipExist(blip) then
                        blip = AddBlipForEntity(ped)
                        SetBlipScale(blip, 0.85)
                        if(IsPedInAnyHeli(ped, false)) then
                            SetBlipSprite(blip, 574)
                        elseif(IsPedInAnyVehicle(ped, false)) then
                            SetBlipSprite(blip, 227)
                        else
                            SetBlipSprite(blip, 1)
                        end
                        if(v.job =="ems") then
                            SetBlipColour(blip, 23)
                        elseif (v.job =="police")then
                            SetBlipColour(blip, 57)
                        end

                        ShowHeadingIndicatorOnBlip(blip, true)
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
                        SetBlipNameToPlayerName(blip, id)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.label)
                        EndTextCommandSetBlipName(blip)
                        SetBlipAsShortRange(blip, true)
                        v.blip = blip
                        TriggerServerEvent('fae-dispatch:GPS_Table_Update', f)
                    end
                end
            end
        end
    end
end)


RegisterNetEvent('fae-dispatch:cl_updatecalls')
AddEventHandler('fae-dispatch:cl_updatecalls', function(calls)
    if isCop then
        SendNUIMessage({
            type = "updatecalls",
            calls = calls or {},
        })
    end
end)

local emergencyService = {CallPolice, CallEms}

RegisterCommand("911", function(source, args, raw)
	QBCore.Functions.TriggerCallback("QBCore:HasItem", function(hasItem)
		if (hasItem) then
				local playerPed = PlayerPedId()
				exports["dl-menu"]:CreateMenu("Emergency Service", {
					{"Police Dept.", 1},
					{"Emergency Medical Service.", 2},
					{"Cancel", 3}
				}, function(selectIndex)
					selectIndex = tonumber(selectIndex)
					if (selectIndex == 1 or selectIndex == 2) ~= nil then
						if (selectIndex == 1) then
                            CallPolice(raw)
                        elseif (selectIndex == 2) then
                            CallEms(raw)
                        end
					end
					StopAnimTask(playerPed, "cellphone@", "cellphone_call_listen_base")
				end)
		else
			QBCore.Functions.Notify("You don't have a phone", "error")
		end
	end, "phone")
end, false)

function CallPolice(raw)
	local currentStreetName, playerCoords, playerPed = GetAlertParams()
	local alertData = {
		code = "DISPATCH",
		title = "A dispatch call, cops needed.",
		location = currentStreetName,
		vector = {playerCoords.x, playerCoords.y, playerCoords.z},
		duration = 5000,
		blinking = false,
	}
	QBCore.Functions.Notify("You Called the police to - " .. currentStreetName, "success")
	TriggerServerEvent('fae-dispatch:311call', raw:sub(4), playerCoords, CoordToString(playerCoords))
end

function CallEms(raw)
	local currentStreetName, playerCoords, playerPed = GetAlertParams()
	local alertData = {
		code = "DISPATCH",
		title = "A dispatch call, paramedics needed.",
		location = currentStreetName,
		vector = {playerCoords.x, playerCoords.y, playerCoords.z},
		duration = 5000,
		blinking = false,
	}
	QBCore.Functions.Notify("You Called the EMS to - " .. currentStreetName, "success")
	TriggerServerEvent('fae-dispatch:911call', raw:sub(4), playerCoords, CoordToString(playerCoords))
end

function CoordToString(coord)
    local zoneNameFull = zones[GetNameOfZone(coord.x, coord.y, coord.z)]
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coord.x, coord.y, coord.z))
    local adres = streetName
    if(Config.ShowZone) then
        adres = zoneNameFull ..' ' .. streetName
    end

    return adres

end

function alert(type,msg)
    QBCore.Functions.Notify(msg, type)
end

-- CALLBACKS

RegisterNUICallback("respondtoCall", function(data,cb)
    if(data.respond) then
        SetNewWaypoint(data.call.coords.x, data.call.coords.y)
    else
        DeleteWaypoint()
    end
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMSrespondToCall', data)
    else
        TriggerServerEvent('fae-dispatch:respondToCall', data)
    end
end)

RegisterNUICallback("error", function(data,cb)
    alert("error",data.errormsg)
end)


RegisterNUICallback("callSolved", function(data,cb)
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMScallSolved', data.calls)
    else
        TriggerServerEvent('fae-dispatch:callSolved', data.calls)
    end
end)

RegisterNUICallback("startDuty", function(data,cb)
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMSupdatecops', "startduty", data.user)
    else
        TriggerServerEvent('fae-dispatch:updatecops',"startduty", data.user)
    end
end)

RegisterNUICallback("endDuty", function(data,cb)
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMSupdatecops', "endduty", data.user)
    else
        TriggerServerEvent('fae-dispatch:updatecops',"endduty", data.user)
    end
end)
RegisterNUICallback("exit", function(data,cb)
    display(false)
end)

RegisterNUICallback("createPatrol", function(data,cb)
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMScreatePatrol', data)
    else
        TriggerServerEvent('fae-dispatch:createPatrol', data)
    end
end)

RegisterNUICallback("editPatrol", function(data,cb)
    if(Client_User.job == Config.EMSJob) then
        TriggerServerEvent('fae-dispatch:EMSeditPatrol', data)
    else
        TriggerServerEvent('fae-dispatch:editPatrol', data)
    end
end)

function authorized()
    if (isLoggedIn) then
        for k,v in pairs(Config.Jobs) do
            if(v == QBCore.Functions.GetPlayerData().job.name) then
                if (QBCore.Functions.GetPlayerData().job.name == "police") then
                    isCop = true
                elseif(QBCore.Functions.GetPlayerData().job.name == Config.EMSJob) then
                    isMedic = true
                end
                return
            end
        end
    end
    isMedic = false
    isCop = false
end

AddEventHandler("dl-alerts:client:hotwireVehicle", function()
    local currentStreetName, playerCoords, playerPed = GetAlertParams()
    playerCoords = GetEntityCoords(PlayerPedId())
	local vehicleData = {}
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
        --[[vehicleData.model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        vehicleData.plate = GetVehicleNumberPlateText(vehicle)
        vehicleData.colors = {
          table.pack(GetVehicleCustomPrimaryColour(vehicle)),
          table.pack(GetVehicleCustomSecondaryColour(vehicle)),
      }]]
        local primary, secondary = GetVehicleColours(vehicle)
        primary = colorNames[tostring(primary)]
        secondary = colorNames[tostring(secondary)]
        TriggerServerEvent('fae-dispatch:alert', "10-97", "Stolen Vehicle. Plate: " .. GetVehicleNumberPlateText(vehicle) .. " Model: " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) .. " P.Color: " .. primary .. " S.Color: " .. secondary, playerCoords, CoordToString(playerCoords))
	end
    -- TriggerServerEvent("dl-alerts:server:hotwireVehicle", currentStreetName, playerCoords, vehicleData)
end)

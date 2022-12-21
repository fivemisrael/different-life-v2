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


-- CONFIG
local lockItem = false
local entered = false
local vehMap = false
local progress = false
local shiftedHud = false
local WaitTime = 500
QBCore = nil
-- START

CreateThread(function()
		while QBCore == nil do
				Wait(200)
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
    end
end)


CreateThread(function()
	while true do
		Wait(500)
		if not entered then
			NetworkSetVoiceActive(false)
			NetworkSetTalkerProximity(1.0)
			entered = true
		end
	end
end)


CreateThread(function()
	while true do
		Wait(WaitTime)
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, true) then
			WaitTime = 150
			local playerVeh = GetVehiclePedIsIn(playerPed, false)
			if vehMap == false then
				if progress == false then
					progress = true
					SendNUIMessage({action = "toggleCar", show = true})
				end
				SendNUIMessage({action = "przesunHud", show = true})
			else
				SendNUIMessage({action = "przesunHudMapa", show = true})
			end
			fuel = exports['LegacyFuel']:GetFuel(GetVehiclePedIsIn(GetPlayerPed(-1)))
			SendNUIMessage({action = "updateGas", key = "gas", value = fuel})
			ShowHUD(true)
			-- if not vehMap then
			-- 	SetRadarBigmapEnabled(false, false)
			-- end
		else
			WaitTime = 500
			if progress == true then
				progress = false
				SendNUIMessage({action = "toggleCar", show = false})
			end
			if not lockItem then
				if shiftedHud == false then
					shiftedHud = true
					SendNUIMessage({action = "przesunHud", show = true})
				end
			end
			ShowHUD(false)
			if IsControlPressed(1, 243) then
				-- ShowHUD(true)
				-- SetRadarBigmapEnabled(true, false)
				SendNUIMessage({action = "toggleAllHud", show = true})
				SendNUIMessage({action = "przesunHudMapa", show = true})
			else
				SendNUIMessage({action = "toggleAllHud", show = false})
				if not lockItem then
					SendNUIMessage({action = "przesunHudMapa", show = false})
				end

				-- if not vehMap then
				-- 	SetRadarBigmapEnabled(false, false)
				-- end
			end
		end
	end
end)

function ShowHUD(on)
	if on and not lockItem then
		if shiftedHud == false then
			shiftedHud = true
			SendNUIMessage({action = "przesunHud", show = true})
		end
		DisplayRadar(true)
	elseif not lockItem then
		if shiftedHud == true then
			shiftedHud = false
			SendNUIMessage({action = "przesunHud", show = false})
		end
		DisplayRadar(false)
	end
end


CreateThread(function()
	while true do
		Wait(0)
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped, false)) then
			local veh = GetVehiclePedIsIn(Ped, false)
			if DoesEntityExist(veh) and not IsEntityDead(veh) then
				local model = GetEntityModel(veh)
				if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
					DisableControlAction(0, 59)
					DisableControlAction(0, 60)
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(500)
		local player = PlayerPedId()

		if IsPedInAnyVehicle(player) then
			local x, y, z = table.unpack(GetEntityCoords(player, true))
			local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
			local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
			local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
			local zone = tostring(GetNameOfZone(x, y, z))
			local area = GetLabelText(zone)
			local playerStreetsLocation = area

			if not zone then
				zone = "UNKNOWN"
			end

			if intersectStreetName ~= nil and intersectStreetName ~= "" then
				playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [" .. area .. "]"
			elseif currentStreetName ~= nil and currentStreetName ~= "" then
				playerStreetsLocation = currentStreetName .. " | [" .. area .. "]"
			else
				playerStreetsLocation = "[".. area .. "]"
			end

			if playerStreetsLocation then
				SendNUIMessage({
					action = "updateStreet",
					streetName = playerStreetsLocation
				})
			end


			local vehicle = GetVehiclePedIsIn(player, false)
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if (lockStatus == 0 or lockStatus == 1) then
				SendNUIMessage({action = "lockSwitch", status = true})
			elseif lockstatus ~= 0 and lockstatus ~= 1 then
				SendNUIMessage({action = "lockSwitch", status = false})
			end
		
			carSpeed = math.ceil(GetEntitySpeed(player) * 3.6)
			SendNUIMessage({
				showhud = true,
				speed = carSpeed
			})
		end
	end
end)


local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
		    local vc = GetVehicleClass(veh)
		    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end

Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

CreateThread(function()
	Wait(500)
	while true do

		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(ped)

		if car ~= 0 and (wasInCar or IsCar(car)) then

			wasInCar = true

			if beltOn then DisableControlAction(0, 75) end

			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(car)

			if speedBuffer[2] ~= nil
			   and not beltOn
			   and GetEntitySpeedVector(car, true).y > 1.0
			   and speedBuffer[1] > 19.25
			   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then

				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end

			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)

            if IsControlJustReleased(0, Keys["B"]) then
				beltOn = not beltOn
				TriggerEvent("seatbelt:client:ToggleSeatbelt", beltOn)
				SendNUIMessage({action = "seatbelt",seatbelt = beltOn})
				if beltOn then
					QBCore.Functions.Notify('Your seatbelt is now on!', 'success', '1')
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "carbuckle", 0.25)

				else
					QBCore.Functions.Notify('Your seatbelt is now off!', 'error', '1')
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "carunbuckle", 0.25)
                end
			end

		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
		end
		Wait(0)
	end
end)

local settings = {x = 0.176, y = 0.977, w = 0.04, degrees = 45, line = 9, rw = 2, rh = 8}

function degreesName(h)
	if h < 22.5 then
		return "N"
	elseif h < 67.5 then
		return "NW"
	elseif h < 112.5 then
		return "W"
	elseif h < 157.5 then
		return "SW"
	elseif h < 202.5 then
		return "S"
	elseif h < 247.5 then
		return "SE"
	elseif h < 292.5 then
		return "E"
	else
		return "NE"
	end
end

function drawTxt(text, x, y, scale, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextCentre(true)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

CreateThread(function()
	local inveh = false
	while true do
		Wait(inveh and 0 or 250)
		local ped = PlayerPedId()
		inveh = IsPedInAnyVehicle(ped)
		if inveh then
			local sx, sy = GetActiveScreenResolution()
			local cw, ch = settings.rw/sx, settings.rh/sy
			local rot = GetGameplayCamRot()
			local z = (rot.z+360-settings.degrees/2)%360
			local lz = z%settings.line
			for i = settings.degrees+lz, lz, -settings.line do
				local ang = math.floor(settings.degrees-i+z)%360
				local x, y = settings.x+((i/settings.degrees)*settings.w), settings.y
				local test1 = ang%90
				local test2 = test1%45 == 0
				test1 = test1 == 0
				if test2 then
					drawTxt(degreesName(ang), x, test1 and y-0.012 or (y-ch/2-0.02), test1 and 0.3 or 0.2, 255, 255, 255, 255)
				end
				if test1 then
					DrawRect(x, y, (settings.w*(settings.line/settings.degrees))*1.25, 24/sy, 0, 0, 0, 100)
				else
					DrawRect(x, y, cw, ch*(test2 and 1.5 or 1), 255, 255, 255, 255)
				end
			end
		end
	end
end)
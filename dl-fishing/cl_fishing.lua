QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)


local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

local bait = "none"

local blip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)

	SetBlipSprite (blip, 356)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 17)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Fish selling")
	EndTextCommandSetBlipName(blip)

local blip2 = AddBlipForCoord(Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z)

	SetBlipSprite (blip2, 68)
	SetBlipDisplay(blip2, 4)
	SetBlipScale  (blip2, 0.9)
	SetBlipColour (blip2, 49)
	SetBlipAsShortRange(blip2, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Sea Turtle dealer")
	EndTextCommandSetBlipName(blip2)

local blip3 = AddBlipForCoord(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z)

	SetBlipSprite (blip3, 68)
	SetBlipDisplay(blip3, 4)
	SetBlipScale  (blip3, 0.9)
	SetBlipColour (blip3, 49)
	SetBlipAsShortRange(blip3, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Shark meat dealer")
	EndTextCommandSetBlipName(blip3)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
			--[[if IsControlJustReleased(0, Keys['7']) or IsDisabledControlJustReleased(0, Keys['7']) then
				print('7')
				input = 1
			end
			if IsControlJustReleased(0, Keys['8']) or IsDisabledControlJustReleased(0, Keys['8']) then
				print('8')
				input = 2
			end
			if IsControlJustReleased(0, Keys['9']) or IsDisabledControlJustReleased(0, Keys['9']) then
				print('9')
				input = 3
			end
			if IsControlJustReleased(0, Keys['0']) or IsDisabledControlJustReleased(0, Keys['0']) then
				print('0')
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
			end--]]


			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				QBCore.Functions.Notify("Stopped fishing")
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(PlayerPedId())
			end

			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(PlayerPedId())
				if pos.y >= 7700 or pos.y <= -2000 or pos.x <= -1400 or pos.x >= 4300 or IsPedInAnyVehicle(PlayerPedId()) then

				else
					fishing = false
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify("Stopped fishing")
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify("Stopped fishing")
				end
			end

			--[[if pausetimer > 10 then
				input = 99
			end

			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
				else
					QBCore.Functions.Notify("Fish got free")
				end
			end--]]
		end

		--[[if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			if IsControlJustReleased(0, Keys['E']) then
				TriggerServerEvent('fishing:startSelling', "fish")
				Citizen.Wait(4000)
			end
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			if IsControlJustReleased(0, Keys['E']) then
				TriggerServerEvent('fishing:startSelling', "shark")
				Citizen.Wait(4000)
			end
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			if IsControlJustReleased(0, Keys['E']) then
				TriggerServerEvent('fishing:startSelling', "turtle")
				Citizen.Wait(4000)
			end
		end--]]

	end
end)

function DrawText3D(x, y, z, text)
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
	while true do
		Wait(1)

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 5 then
			DrawMarker(2, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
			DrawText3D(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z + 0.3, '~g~E~w~ Sell Fish')

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 1 then
				if IsControlJustReleased(0, Keys['E']) then
					TriggerServerEvent('fishing:startSelling', "fish")
				end
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			DrawMarker(2, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z+ 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
			DrawText3D(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z + 0.3, '~g~E~w~ Sell Shark')
			if IsControlJustReleased(0, Keys['E']) then
				TriggerServerEvent('fishing:startSelling', "shark")
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			DrawMarker(2, Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z+ 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
			DrawText3D(Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z + 0.3, '~g~E~w~ Sell Turtle')
			if IsControlJustReleased(0, Keys['E']) then
				TriggerServerEvent('fishing:startSelling', "turtle")
			end
		end

		--DrawMarker(1, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
		--DrawMarker(1, Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
		--DrawMarker(1, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
	end
end)
local RamsDone = 0

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
		if fishing then
            print("fishing")
			pause = true
			correct = math.random(1,4)
			QBCore.Functions.Notify("Fish is taking the bait <br> Press " .. correct .. " to catch it")
			input = 0
			pausetimer = 0
            local SkillbarSuccess = exports["dl-skillbar"]:CreateSkillbar(6, "medium")
            if (SkillbarSuccess) then
				TriggerServerEvent('fishing:catch', bait)
			else
				QBCore.Functions.Notify("Failed...", "error")
			end
		end
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()

	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(PlayerPedId())

	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
	print(bait)
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	playerPed = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())

	if IsPedInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("You can not fish from a vehicle")
	else
		if pos.y >= 7700 or pos.y <= -2000 or pos.x <= -1400 or pos.x >= 4300 then
			QBCore.Functions.Notify("Fishing started")
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			QBCore.Functions.Notify("You need to go further away from the shore")
		end
	end

end, false)

QBCore = nil
local playerJob, playerData = {}, {}
local isInRun, runJob, taskingRun = false, '', false
local blip = nil

local Consumeables = {
    	["coffee"] = math.random(25, 50),
	["latte"] = math.random(20, 40),
	["capuchino"] = math.random(20, 40),
	["frappuccino"] = math.random(20, 40),
	["cocacola"] = math.random(15, 25),
	["greencow"] = math.random(15, 25),
	["spirte"] = math.random(15, 25),
	["slushy"] = math.random(15, 27),
	["taco"] = math.random(25, 50),
    	["fishtaco"] = math.random(20, 40),
	["torpedo"] = math.random(20, 40),
	["torta"] = math.random(20, 40),
    	["burrito"] = math.random(20, 40),
	["eggsbacon"] = math.random(20, 40),
    	["churro"] = math.random(15, 25),
    	["donut"] = math.random(15, 25),
	["waffle"] = math.random(15, 25),
	["frenchtoast"] = math.random(15, 25),
	["fries"] = math.random(20, 35),
	["wings"] = math.random(20, 40),
    	["hotdog"] = math.random(20, 40),
	["heartstopper"] = math.random(20, 40),
	["bleederburger"] = math.random(20, 40),
	["meatfree"] = math.random(20, 40),
	["fowlburger"] = math.random(20, 40),
    	["icecream"] = math.random(20, 25),
    	["mshake"] = math.random(20, 30),
	["sandwich"] = math.random(20, 30),
    	["water_bottle"] = math.random(23, 46),
    	["toast"] = math.random(20, 35),
	["burger"] = math.random(25, 50),
    	["twerks_candy"] = math.random(5, 15),
    	["snikkel_candy"] = math.random(5, 15),
    	["whiskey"] = math.random(10, 25),
    	["beer"] = math.random(10, 25),
    	["vodka"] = math.random(10, 25),
}

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(jobInfo)
	playerJob = jobInfo
	playerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("dl-deliveries:drink")
AddEventHandler("dl-deliveries:drink", function(item, metadata)
    QBCore.Functions.Progressbar("eat", "Drinking", 6000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
       	disableCombat = false,
    }, {
       animDict = "amb@world_human_drinking@coffee@male@idle_a",
       anim = "idle_c",
       flags = 49,
    }, {}, {}, function() -- Done
	StopAnimTask(GetPlayerPed(-1), "amb@world_human_drinking@coffee@male@idle_a", "idle", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", item['name'], 1, item['slot'])
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[item['name']], "remove")
	TriggerServerEvent("QBCore:Server:SetMetaData", metadata, QBCore.Functions.GetPlayerData().metadata[metadata] + Consumeables[item['name']])
    end, {})
end)


RegisterNetEvent("dl-deliveries:eat")
AddEventHandler("dl-deliveries:eat", function(item, metadata)
    QBCore.Functions.Progressbar("eat", "Eating", 4500, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
       	disableCombat = false,
    }, {
       animDict = "mp_player_inteat@burger",
       anim = "mp_player_int_eat_burger",
    }, {}, {}, function() -- Done
	StopAnimTask(GetPlayerPed(-1), "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", item['name'], 1, item['slot'])
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[item['name']], "remove")
	TriggerServerEvent("QBCore:Server:SetMetaData", metadata, QBCore.Functions.GetPlayerData().metadata[metadata] + Consumeables[item['name']])
    end, {})
end)


RegisterNetEvent("dl-deliveries:taco")
AddEventHandler("dl-deliveries:taco", function(item, metadata)
    QBCore.Functions.Progressbar("taco-item", "Eating", 4500, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
       	disableCombat = false,
    }, {
       animDict = "mp_player_inteat@burger",
       anim = "mp_player_int_eat_burger",
    }, {
	model = "prop_taco_01",
        bone = 18905,
        coords = { x = 0.13, y = 0.07, z = 0.02 },
        rotation = { x = 160.0, y = 0.0, z = -50.0 },
     }, {}, function() -- Done
	StopAnimTask(GetPlayerPed(-1), "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", item['name'], 1, item['slot'])
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[item['name']], "remove")
	TriggerServerEvent("QBCore:Server:SetMetaData", metadata, QBCore.Functions.GetPlayerData().metadata[metadata] + Consumeables[item['name']])
    end, {})
end)

RegisterNetEvent("dl-deliveries:main")
AddEventHandler("dl-deliveries:main", function(job)
	if taskingRun then
		return
	end
	
	local randomLocations = math.random(1, #Config.DropOffLocations[job])
	CreateBlip(job, randomLocations)

	taskingRun = true
	local toolong = Config.Jobs[job]['settings'].runtimer * 4200

	while taskingRun do
		Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(Config.DropOffLocations[job][randomLocations]["x"],Config.DropOffLocations[job][randomLocations]["y"],Config.DropOffLocations[job][randomLocations]["z"])) 

		toolong = toolong - 1
		if toolong < 0 then
			TriggerEvent('QBCore:Notify', Config.Jobs[job]['settings'].timedout, "error")
			taskingRun = false
		end

		if dstcheck < 10.0 then
			local crds = Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"]
			DrawText3D(Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"] + 0.3, Config.Jobs[job]['settings'].dropoff)

			local LocDeliver = vector3(Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"])
			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				Citizen.Wait(1500)
				DoDropOff(LocDeliver)
				taskingRun = false
			end
		end
	end
	DeleteBlip()
end)

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(200)
	end

	while QBCore.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while QBCore.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

	playerData = QBCore.Functions.GetPlayerData()
	playerJob = QBCore.Functions.GetPlayerData().job

	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		local job = Config.Jobs[playerJob.name]
		if job ~= nil then
			local dst_cooking = #(GetEntityCoords(playerPed) - job['locations'].cook)
			local dst_packaging = #(GetEntityCoords(playerPed) - job['locations'].packaging)
			local dst_ready = #(GetEntityCoords(playerPed) - job['locations'].ready)
			local dst_shop = #(GetEntityCoords(playerPed) - job['locations'].shop)
			local dst_stash = #(GetEntityCoords(playerPed) - job['locations'].stash)

			if dst_cooking < 1.5 and not isInRun then
				DrawText3D(job['locations'].cook.x, job['locations'].cook.y, job['locations'].cook.z, job['settings'].cooking)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BBQ", 0, true)

					local skillbarAmount, done = math.random(1, 4), true
					for counter = 1, skillbarAmount do
						local finished = exports["dl-taskbarskill"]:taskBar(math.random(1600, 2500), math.random(5, 15))
						print(finished)
						if finished ~= 100 then
        	    			done = false
						end
					end

					Wait(7000)
					ClearPedTasks(playerPed)
					if done == true then
						TriggerServerEvent('dl-deliveries:addItem', job['settings'].food_item, 2)
						QBCore.Functions.Notify(job['settings'].made_items, "success")
					end
				end
            end

			if dst_stash < 1.5 then
				DrawText3D(job['locations'].stash.x, job['locations'].stash.y, job['locations'].stash.z, job['settings'].stash) 
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					TriggerServerEvent("inventory:server:OpenInventory", "stash", "taco", {
                                    		maxweight = 4000000,
                                    		slots = 500,
                                	})
                                	TriggerEvent("inventory:client:SetCurrentStash", "taco")
				end
			end

			if dst_packaging < 1.5 and not isInRun then
				DrawText3D(job['locations'].packaging.x, job['locations'].packaging.y, job['locations'].packaging.z, job['settings'].packaging) 
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					QBCore.Functions.TriggerCallback('dl-deliveries:getItemCount', function(hasItems)
						if hasItems then
							playerAnim(2)

							local skillbarAmount, done = math.random(1, 4), true
							for counter = 1, skillbarAmount do
								local finished = exports["dl-taskbarskill"]:taskBar(math.random(2000, 2500), math.random(5, 15))
								if finished ~= 100 then
        	    					done = false
								end
							end
						
							Wait(7000)
							ClearPedTasks(playerPed)
							if done == true then
								TriggerServerEvent('dl-deliveries:removeItem', job['settings'].food_item, 2)
								TriggerServerEvent('dl-deliveries:addItem', job['settings'].bag_item, 1)
								QBCore.Functions.Notify(job['settings'].packed_items, "success")
							end
						else
							QBCore.Functions.Notify(job['settings'].not_enoght, "error")
						end
					end, job['settings'].food_item, 2)
				end
			end

			if dst_ready < 1.5 and not isInRun then
				DrawText3D(job['locations'].ready.x, job['locations'].ready.y, job['locations'].ready.z, job['settings'].ready)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					QBCore.Functions.Progressbar("rljobs_preparing", job['settings'].preparing, 3000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = false,
					}, {}, {}, {}, function()
						TriggerServerEvent('dl-deliveries:readyForDelivery', job['name'], job['settings'].bag_item)
					end, function()
						QBCore.Functions.Notify("Failed!", "error")
					end)
				end
            end
			
            if dst_shop < 1.5 and not isInRun then
				DrawText3D(job['locations'].shop.x, job['locations'].shop.y, job['locations'].shop.z, job['settings'].shop)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
                    Wait(10)

                    local shop = {}
                    shop.label = "Main Shop"
                    shop.items = job['shopitems']
                    shop.slots = #job['shopitems']
                    
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "shop_" .. math.random(111, 9999) , shop)
                end
			end
		end

		for _, job in pairs(Config.Jobs) do
			if not job['settings'].private_deliveries then
				local dst_pickup = #(GetEntityCoords(playerPed) - job['locations'].pickup)
				local dst_cancle = #(GetEntityCoords(playerPed) - job['locations'].cancle)

				if dst_pickup < 1.5 and not isInRun then
					DrawText3D(job['locations'].pickup.x, job['locations'].pickup.y, job['locations'].pickup.z, job['settings'].pickup)
					if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
                        Wait(10)
						TriggerServerEvent('dl-deliveries:startFromDelivery', job['name'])
					end
				end

				if dst_cancle < 1.5 and isInRun then
					DrawText3D(job['locations'].cancle.x, job['locations'].cancle.y, job['locations'].cancle.z, job['settings'].cancle)
					if not IsPedInAnyVehicle(playerPed) and IsControlJustReleased(0,38) then
						Wait(10)
						TriggerServerEvent('dl-deliveries:removeItem', job['settings'].bag_item, 1)
						
						isInRun, runJob, taskingRun = false, '', false
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()

        if isInRun and runJob then
			if taskingRun then
				Wait(30000)
			else
				TriggerEvent("dl-deliveries:main", runJob)
			end
		end
		Wait(0)
    end
end)

RegisterNetEvent("dl-deliveries:startDelivery")
AddEventHandler("dl-deliveries:startDelivery", function(job)
	isInRun = true
	runJob = job
end)

Citizen.CreateThread(function()
	for _, job in pairs(Config.Jobs) do
		local blip = AddBlipForCoord(job['blip'].coords)

		SetBlipSprite (blip, job['blip'].sprite)
		SetBlipDisplay(blip, job['blip'].display)
		SetBlipScale  (blip, job['blip'].scale)
		SetBlipColour (blip, job['blip'].color)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(job['blip'].name)
		EndTextCommandSetBlipName(blip)
	end
end)

DrawText3D = function(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

DrawMarker3D = function(x, y, z)
	DrawMarker(2, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
end

function playerAnim(anim)
	if anim == 1 then
		loadAnimDict("mp_safehouselost@")
		TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
	elseif anim == 2 then
		loadAnimDict("anim@amb@business@cfm@cfm_drying_notes@")
		TaskPlayAnim( PlayerPedId(), "anim@amb@business@cfm@cfm_drying_notes@", "loading_v3_worker", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	elseif anim == 3 then
		loadAnimDict("timetable@jimmy@doorknock@")
    	TaskPlayAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )
	end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded( dict )) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip(job, rndLocation)
	if isInRun then
		blip = AddBlipForCoord(Config.DropOffLocations[job][rndLocation]["x"],Config.DropOffLocations[job][rndLocation]["y"],Config.DropOffLocations[job][rndLocation]["z"])
	end
    
	SetBlipSprite(blip, Config.DropOff.Sprite)
	SetBlipColour(blip, Config.DropOff.Color)
    SetBlipScale(blip, Config.DropOff.Scale)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.DropOff.Name)
    EndTextCommandSetBlipName(blip)
end

function DoDropOff(Location)
	Wait(10)
	playerAnim(3)
	Wait(3000)
	ClearPedTasks(PlayerPedId())
	playerAnim(1)
	DeleteBlip()
	
	Citizen.Wait(2000)
	TriggerServerEvent("dl-deliveries:dropoff", runJob)
	isInRun, runJob = false, ''
end

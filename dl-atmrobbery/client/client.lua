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

CurrentCops = 0
RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)
doctorCount = 0
RegisterNetEvent('hospital:client:SetDoctorCount')
AddEventHandler('hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

local robbedATM = nil
Citizen.CreateThread(function()
	while true do
		Wait(0)
		for k, v in pairs (Config.Locations) do
			local pcoords = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, v.x, v.y, v.z)
            if CurrentCops >= Config.MinimumOfficers then
                if distance < 0.5 then
                    DrawText3Ds(v.x, v.y, v.z, "Press ~r~[G]~w~ To Rob")
                    if IsControlJustPressed(0, 47) then
                        robbedATM = k
                        TriggerServerEvent("pr-atmrobbery:server:checkInv", robbedATM)
                        --OpenHackFunction(v)
                    end
                end
            end
		end
	end
end)


RegisterNetEvent('pr-atmrobbery:client:start')
AddEventHandler('pr-atmrobbery:client:start', function()
    OpenHackFunction(v)
end)



function OpenHackFunction(v)
	local player = PlayerPedId()
	local animDict = "mp_fbi_heist"
	local animName = "loop"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
    local v = GetEntityCoords(PlayerPedId())
    local h = GetEntityHeading(PlayerPedId())
	TaskPlayAnimAdvanced(player, animDict, animName, v.x, v.y, v.z, 0.0, 0.0, h, 3.0, 1.0, -1, 30, 1.0, 0, 0 )
	SetEntityHeading(player, h)
	FreezeEntityPosition(player, true)
	QBCore.Functions.Progressbar("hack", "HACKING DATA", 10500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
		playAnim('anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 10500)

    }, {}, {}, function()


        local gameResult = exports["dl-hackingame"]:CreateHackGame("easy", callPolice())
        HackCallback(gameResult)


	end)
end

function callPolice()
    local playerCoords = GetEntityCoords(PlayerPedId())

    TriggerServerEvent('fae-dispatch:alert', "ATM", "Someone is trying to hack into a ATM!", playerCoords, exports['fae-dispatch']:CoordToString(playerCoords))
end

function HackCallback(success)
	local player = PlayerPedId()
	ClearPedTasks(player)
    FreezeEntityPosition(player,false)
	jobPC = nil
	if success then
        local playerPed = PlayerPedId()
        GetAlertParams = function(playerPed)
            local playerCoords = GetEntityCoords(playerPed)
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
            local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
            if (intersectStreetName ~= "") then
                currentStreetName = currentStreetName .. ", " .. intersectStreetName
            end
            return currentStreetName, playerCoords
        end
        local pcoords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent("pr-atmrobbery:server:rewards", robbedATM)
        robbedATM = nil
	else
		QBCore.Functions.Notify('You failed to break the ATM system, get out of here before the police arrives!', "error")
        local pcoords = GetEntityCoords(PlayerPedId())
	end
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
		RequestAnimDict(animDict)
      Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end


QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("withdraw", function(data)
    TriggerServerEvent("dl-banking:server:withdraw", data.withdraw)
end)

RegisterNUICallback("deposit", function(data)
    TriggerServerEvent("dl-banking:server:deposit", data.deposit)
end)

RegisterNUICallback("transfer", function(data)
    TriggerServerEvent("dl-banking:server:transfer", data.transferAmount, data.pId)
end)

RegisterNetEvent("dl-banking:client:updateNUI")
AddEventHandler("dl-banking:client:updateNUI", function(type, update)
    SendNUIMessage({
        update = true, 
        type = type,
        amount = update
    })
end)
RegisterNetEvent("dl-banking:client:getClosestPed")
AddEventHandler("dl-banking:client:getClosestPed", function(amount)
    local closestPed = GetClosestPed()
    local id = GetPlayerServerId(NetworkGetEntityOwner(closestPed))

    print(closestPed, id)
    TriggerServerEvent("dl-banking:server:getClosestPed", closestPed, id, amount)
end)

RegisterNetEvent("dl-banking:client:notify")
AddEventHandler("dl-banking:client:notify", function(content)
    SendNUIMessage({
        notify = true, 
        notifyContent = content
    })
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


RegisterNetEvent("dl-banking:client:openUI", function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        open = true, 
        info = data
    })
end)



------------------ 
local banks = {
    {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
    {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
    {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
    {name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
    {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
    {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
    {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
    {name="Bank", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
  }	
local atmModels = {"prop_fleeca_atm", "prop_atm_01", "prop_atm_02", "prop_atm_03"}

-------------------
RegisterCommand('+openbank', function()
    if nearBank() then
        TriggerServerEvent("dl-banking:server:requestOpen")
    end
end, false)
RegisterKeyMapping('+openbank', 'Bank GUI (Open)', 'keyboard', 'e')

Citizen.CreateThread(function()
   
    for k,v in ipairs(banks)do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, v.id)
    SetBlipScale(blip, 0.7)
    SetBlipColour (blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(v.name))
    EndTextCommandSetBlipName(blip)
    end

    while true do
        local ped = GetPlayerPed(PlayerId())
        local pedPos = GetEntityCoords(ped, false)
        for a = 1, #atmModels do
            local atm = GetClosestObjectOfType(pedPos.x, pedPos.y, pedPos.z, 3.0, GetHashKey(atmModels[a]), false, 1, 1)
            local atmOffset = GetOffsetFromEntityInWorldCoords(atm, 0.0, -0.7, 0.0)
            local atmHeading = GetEntityHeading(atm)
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, atmOffset.x, atmOffset.y, atmOffset.z)
            if distance <= 1.7 and not IsPedInAnyVehicle(ped) then
                DrawText3Ds(atmOffset.x, atmOffset.y, atmOffset.z + 1.0, tostring("Press [~g~E~w~] to use the ATM"))
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent("dl-banking:server:requestOpen")
                end
            end
        end
      Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(PlayerId())
        local pedPos = GetEntityCoords(ped, false)
        for k,v in ipairs(banks)do
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, v.x, v.y, v.z)
            if distance <= 1.7 and not IsPedInAnyVehicle(ped) then
                DrawText3Ds(v.x, v.y, v.z, tostring("Press [~g~E~w~] to open the bank"))
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent("dl-banking:server:requestOpen")
                end
            end
        end
        Citizen.Wait(0)
    end
end)

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
  

function nearBank()
	local player = GetPlayerPed(-1)
	local pPos = GetEntityCoords(player, 0)
	
	for k,v in pairs(banks) do
		local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pPos.x, pPos.y, pPos.z, true)
		if distance <= 3 then
			return true
		end
	end
end


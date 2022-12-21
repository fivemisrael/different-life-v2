
RegisterNetEvent('PhoneTracker:SetBlip')
AddEventHandler('PhoneTracker:SetBlip', function(data)
    if data ~= nil and type(data) == "table" then 
        if data.coords ~= nil then
            local transG = 150
            local blip = AddBlipForCoord(data.coords.x,data.coords.y,data.coords.z)
            SetBlipSprite(blip, 3)
            SetBlipColour(blip, 4)
			SetBlipScale(blip, 3.0)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
			
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)
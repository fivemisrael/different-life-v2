local medoText = {}

local fontId = -1
RegisterNetEvent("dl-medo:client:medo")
AddEventHandler("dl-medo:client:medo", function(source, text, medo)
	local playerId = GetPlayerFromServerId(source)
	if playerId ~= -1 then
		local ped = GetPlayerPed(playerId)
		local v
		for i = 1, #medoText do
			v = medoText[i]
			if v[4] == medo then
				if v[1] == ped then
					v[2] = text
					v[3] = GetGameTimer()+10000
					return
				end
			end
		end
		medoText[#medoText+1] = {ped, text, GetGameTimer()+10000, medo}
		if #medoText == 1 then
			ShowMEDO()
		end
	end
end)

function GetDist(vec)
	return vec.x*vec.x+vec.y*vec.y+vec.z*vec.z
end

function ShowMEDO()
	local v, width
	while #medoText > 0 do
		local timer = GetGameTimer()
		local pos = GetEntityCoords(PlayerPedId())
		RegisterFontFile("out")
		fontId = RegisterFontId("MyFont")
		for i = #medoText, 1, -1 do
			v = medoText[i]
			if v[3] < timer or not DoesEntityExist(v[1]) then
				table.remove(medoText, i)
			else
				local coords
				if v[4] then
					coords = GetPedBoneCoords(v[1], 0x796E)
					coords = vector3(coords.x, coords.y, coords.z + 0.25)
					SetTextColour(100, 255, 255, 255)
				else
					coords = GetPedBoneCoords(v[1], 0x796E)
					coords = vector3(coords.x, coords.y, coords.z - 0.45)
					SetTextColour(255, 255, 255, 255)
				end
				if GetDist(coords-pos) < 35 then
					SetDrawOrigin(coords.x, coords.y, coords.z)
					SetTextFont(fontId)
					SetTextScale(0.30, 0.30)
					SetTextCentre(1)
					BeginTextCommandDisplayText("STRING")
					AddTextComponentSubstringPlayerName(v[2])
					EndTextCommandDisplayText(0.0, 0.0)
				end
			end
		end
		ClearDrawOrigin()
		Wait(0)
	end
end

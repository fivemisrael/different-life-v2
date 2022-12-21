local QBCore = nil
local Handle = nil
local Prop = `prop_cs_hand_radio`
local Bone = 28422
local Offset = vector3(0.0, 0.0, 0.0)
local Rotation = vector3(0.0, 0.0, 0.0)
local AnimDict = "cellphone@"
local Anims = {"cellphone_text_in","cellphone_text_out"}
local lastRadio = -1

TriggerEvent("QBCore:GetObject", function(object)
	QBCore = object
end)




local LoadAnimDict = function(AnimDictName)
	if (not HasAnimDictLoaded(AnimDictName) and DoesAnimDictExist(AnimDictName)) then
		RequestAnimDict(AnimDictName)

		while (not HasAnimDictLoaded(AnimDictName)) do
			Wait(50)
		end
	end
end

local FixRadioProp
FixRadioProp = function()
	local PlayerCoords = GetEntityCoords(PlayerPedId())
	local Obj = GetClosestObjectOfType(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, Prop)
	if (Obj ~= 0) then
		NetworkRequestControlOfEntity(Obj)

		while (not NetworkHasControlOfEntity(Obj)) do Wait(100) end

		DetachEntity(Obj, true, false)
		DeleteEntity(Obj)
		Wait(50)
		FixRadioProp()
	end
end
RegisterNetEvent("dl-radio:Client:OpenRadio")
AddEventHandler("dl-radio:Client:OpenRadio", function()
	LoadAnimDict(AnimDict)
	SetNuiFocus(true, true)
	SendNUIMessage({Display = true})
	local PlayerPed = PlayerPedId()
	RequestModel(Prop)

	while not HasModelLoaded(Prop) do
		Citizen.Wait(150)
	end

	Handle = CreateObject(Prop, 0.0, 0.0, 0.0, true, true, false)

	local bone = GetPedBoneIndex(PlayerPed, Bone)

	SetCurrentPedWeapon(PlayerPed, `weapon_unarmed`, true)
	AttachEntityToEntity(Handle, PlayerPed, bone, Offset.x, Offset.y, Offset.z, Rotation.x, Rotation.y, Rotation.z, true, false, false, false, 2, true)

	SetModelAsNoLongerNeeded(Handle)
	TaskPlayAnim(PlayerPed, AnimDict, Anims[1], 4.0, -1, -1, 50, 0, false, false, false)
end)

RegisterNUICallback("CloseInterface", function()
	SetNuiFocus(false, false)
	local PlayerPed = PlayerPedId()
	TaskPlayAnim(PlayerPed, AnimDict, Anims[2], 4.0, -1, -1, 50, 0, false, false, false)
	Wait(700)
	StopAnimTask(PlayerPed, AnimDict, Anims[2], 1.0)
	FixRadioProp()
end)

local radio = 0
local speakradio = false
local players = {}
local sendplayers = {}

--[[RegisterNetEvent("speakradio")
AddEventHandler("speakradio", function(source, speak)
	players[source] = speak
	MumbleSetVolumeOverrideByServerId(source, speak and 1.0 or -1.0)
	TriggerEvent("dl-sounds:Client:PlaySound", "mic_click_on", 0.5)
end)--]]



RegisterNetEvent("dl-radio:Client:Disconnect")
AddEventHandler("dl-radio:Client:Disconnect", function()
	local playerName = GetPlayerName(PlayerId())
	radio = 0.0
	TriggerServerEvent("connectradio")
	if lastRadio ~= -1 then
		print("disconnect")
		exports["tokovoip_script"]:setPlayerData(playerName, "radio:channel", "nil", true)
		exports["tokovoip_script"]:removePlayerFromRadio(lastRadio)
		lastRadio = -1
	end
	QBCore.Functions.Notify("Disconnected from radio!", "error")
end)

RegisterNetEvent("dl-radio:Client:radialmenu")
AddEventHandler("dl-radio:Client:radialmenu", function(channel)
	changeRadio(channel)
end)

RegisterNUICallback("setRadioChannel", function(data)
	if data.Channel == nil then return end
	changeRadio(data.Channel)
end)

--[[RegisterCommand("+speakradio", function()
	if not speakradio and radio <= 999.9 and radio >= 1 then
		local PlayerId = PlayerId()
		local PlayerPed = PlayerPedId()
		TriggerServerEvent("speakradio", true)
		TriggerEvent("dl-sounds:Client:PlaySound", "mic_click_on", 0.5)
		LoadAnimDict("random@arrests")
		TaskPlayAnim(PlayerPed, "random@arrests", "generic_radio_chatter", 4.0, -1, -1, 50, 0, false, false, false)
		speakradio = true
		while speakradio do
			DisablePlayerFiring(PlayerId, true)
			SetControlNormal(0, 249, 1.0)
			Wait(0)
		end
	end
end)

RegisterCommand("-speakradio", function()
	if speakradio then
		local PlayerId = PlayerId()
		local PlayerPed = PlayerPedId()
		TriggerServerEvent("speakradio")
		TriggerEvent("sendradio")
		TriggerEvent("dl-sounds:Client:PlaySound", "mic_click_off", 1.0)
		StopAnimTask(PlayerPed, "random@arrests", "generic_radio_chatter", 1.0)
		DisablePlayerFiring(PlayerId, true)
		speakradio = false
	end
end)

RegisterKeyMapping("+speakradio", "Speak Radio", "keyboard", "lmenu")]]

local LookAtCoords = function(Vec1, Vec2)
	return math.atan2(Vec1.x - Vec2.x, Vec1.y - Vec2.y) * (180 / math.pi)
end

RegisterCommand("play", function(Source, Args)
	RequestCutscene(Args[1], 8)
	while (not HasCutsceneLoaded()) do Wait(100) end
	local PlayerPed = PlayerPedId()
	RegisterEntityForCutscene(PlayerPed, "MP_1", 0, 0, 64)
	StartCutscene(4)

	while not (DoesCutsceneEntityExist("MP_1") and DoesCutsceneEntityExist("LAMAR")) do
		Wait(100)
	end

	local CutscenePed = GetEntityIndexOfCutsceneEntity("MP_1")
	local CutscenePedCoords = GetEntityCoords(CutscenePed)

	local CutsceneLamar = GetEntityIndexOfCutsceneEntity("LAMAR")
	local CutsceneLamarCoords = GetEntityCoords(CutsceneLamar)
end, false)

RegisterCommand("stop", function(Source, Args)
	StopCutsceneImmediately()
end, false)

function changeRadio(channel)
	local playerJob = QBCore.Functions.GetPlayerData().job.name
	radio = math.floor((tonumber(channel) or 0) * 10) / 10
	local playerName = GetPlayerName(PlayerId())
	if lastRadio ~= -1 then
		exports.tokovoip_script:removePlayerFromRadio(lastRadio)
		exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
		lastRadio = -1
	end
	if radio <= 999.9 and radio >= 0 then
		if (radio == 0.0) then
			QBCore.Functions.Notify("Disconnected from radio!", "error")
			exports.tokovoip_script:removePlayerFromRadio(lastRadio)
			exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)	
		else
			if (radio <= 5.0 and playerJob == "police") then
				QBCore.Functions.Notify("Radio channel set! [" .. radio .. "]", "success")
				exports.tokovoip_script:setPlayerData(playerName, "radio:channel", radio, true)
				exports.tokovoip_script:addPlayerToRadio(radio)
				lastRadio = radio
			elseif (radio <= 10.0 and playerJob == "medic") then
				QBCore.Functions.Notify("Radio channel set! [" .. radio .. "]", "success")
				exports.tokovoip_script:setPlayerData(playerName, "radio:channel", radio, true)
				exports.tokovoip_script:addPlayerToRadio(radio)
				lastRadio = radio
			elseif (radio > 10.0) then
				QBCore.Functions.Notify("Radio channel set! [" .. radio .. "]", "success")
				exports.tokovoip_script:setPlayerData(playerName, "radio:channel", radio, true)
				exports.tokovoip_script:addPlayerToRadio(radio)
				lastRadio = radio
			end
		end
	end
end



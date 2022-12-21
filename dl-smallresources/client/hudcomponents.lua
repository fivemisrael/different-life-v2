--[[
	HUD = 0;
	HUD_WANTED_STARS = 1;
	HUD_WEAPON_ICON = 2;
	HUD_CASH = 3;
	HUD_MP_CASH = 4;
	HUD_MP_MESSAGE = 5;
	HUD_VEHICLE_NAME = 6;
	HUD_AREA_NAME = 7;
	HUD_VEHICLE_CLASS = 8;
	HUD_STREET_NAME = 9;
	HUD_HELP_TEXT = 10;
	HUD_FLOATING_HELP_TEXT_1 = 11;
	HUD_FLOATING_HELP_TEXT_2 = 12;
	HUD_CASH_CHANGE = 13;
	HUD_RETICLE = 14;
	HUD_SUBTITLE_TEXT = 15;
	HUD_RADIO_STATIONS = 16;
	HUD_SAVING_GAME = 17;
	HUD_GAME_STREAM = 18;
	HUD_WEAPON_WHEEL = 19;
	HUD_WEAPON_WHEEL_STATS = 20;
	MAX_HUD_COMPONENTS = 21;
	MAX_HUD_WEAPONS = 22;
	MAX_SCRIPTED_HUD_COMPONENTS = 141;
]]--

Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		DisplayAmmoThisFrame(true)

		--head w
        DrawSpotLightWithShadow(95.64, -1292.61, 31.2, 0.0, 0.0, -1.0, 255, 255, 255, 24.0, 5.0, 10.0, 100.0, 1.0, 1)
        DrawSpotLightWithShadow(95.64, -1292.61, 30.0, 0.0, 0.0, 1.0, 255, 255, 255, 24.0, 5.0, 10.0, 100.0, 1.0, 1)
        DrawSpotLightWithShadow(91.5, -1287.5, 28.74, 91.5, -1287.5, 28.74, 0, 32, 255, 10.0, 10.0, 10.0, 10.0, 1.0, 1)
		local ped = PlayerPedId()

		if GetSelectedPedWeapon(ped) ~= `weapon_heavysniper` then
			HideHudComponentThisFrame(14)
		end

        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end



		SetVehicleDensityMultiplierThisFrame(0.05)
	    SetPedDensityMultiplierThisFrame(1.0)
	    SetParkedVehicleDensityMultiplierThisFrame(1.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		Wait(0)
	end
end) 
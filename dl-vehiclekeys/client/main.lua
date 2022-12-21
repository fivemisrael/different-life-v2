local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

QBCore = nil

local HasKey = false
local LastVehicle = nil
local IsHotwiring = false
local IsRobbing = false
local isLoggedIn = false
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local AlertSend = false
local searchedVehicles = {}

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Wait(200)
    end
end)



local colors = {

	[0] = "Metallic Black",

	[1] = "Metallic Graphite Black",

	[2] = "Metallic Black Steal",

	[3] = "Metallic Dark Silver",

	[4] = "Metallic Silver",

	[5] = "Metallic Blue Silver",

	[6] = "Metallic Steel Gray",

	[7] = "Metallic Shadow Silver",

	[8] = "Metallic Stone Silver",

	[9] = "Metallic Midnight Silver",

	[10] = "Metallic Gun Metal",

	[11] = "Metallic Anthracite Grey",

	[12] = "Matte Black",

	[13] = "Matte Gray",

	[14] = "Matte Light Grey",

	[15] = "Util Black",

	[16] = "Util Black Poly",

	[17] = "Util Dark silver",

	[18] = "Util Silver",

	[19] = "Util Gun Metal",

	[20] = "Util Shadow Silver",

	[21] = "Worn Black",

	[22] = "Worn Graphite",

	[23] = "Worn Silver Grey",

	[24] = "Worn Silver",

	[25] = "Worn Blue Silver",

	[26] = "Worn Shadow Silver",

	[27] = "Metallic Red",

	[28] = "Metallic Torino Red",

	[29] = "Metallic Formula Red",

	[30] = "Metallic Blaze Red",

	[31] = "Metallic Graceful Red",

	[32] = "Metallic Garnet Red",

	[33] = "Metallic Desert Red",

	[34] = "Metallic Cabernet Red",

	[35] = "Metallic Candy Red",

	[36] = "Metallic Sunrise Orange",

	[37] = "Metallic Classic Gold",

	[38] = "Metallic Orange",

	[39] = "Matte Red",

	[40] = "Matte Dark Red",

	[41] = "Matte Orange",

	[42] = "Matte Yellow",

	[43] = "Util Red",

	[44] = "Util Bright Red",

	[45] = "Util Garnet Red",

	[46] = "Worn Red",

	[47] = "Worn Golden Red",

	[48] = "Worn Dark Red",

	[49] = "Metallic Dark Green",

	[50] = "Metallic Racing Green",

	[51] = "Metallic Sea Green",

	[52] = "Metallic Olive Green",

	[53] = "Metallic Green",

	[54] = "Metallic Gasoline Blue Green",

	[55] = "Matte Lime Green",

	[56] = "Util Dark Green",

	[57] = "Util Green",

	[58] = "Worn Dark Green",

	[59] = "Worn Green",

	[60] = "Worn Sea Wash",

	[61] = "Metallic Midnight Blue",

	[62] = "Metallic Dark Blue",

	[63] = "Metallic Saxony Blue",

	[64] = "Metallic Blue",

	[65] = "Metallic Mariner Blue",

	[66] = "Metallic Harbor Blue",

	[67] = "Metallic Diamond Blue",

	[68] = "Metallic Surf Blue",

	[69] = "Metallic Nautical Blue",

	[70] = "Metallic Bright Blue",

	[71] = "Metallic Purple Blue",

	[72] = "Metallic Spinnaker Blue",

	[73] = "Metallic Ultra Blue",

	[74] = "Metallic Bright Blue",

	[75] = "Util Dark Blue",

	[76] = "Util Midnight Blue",

	[77] = "Util Blue",

	[78] = "Util Sea Foam Blue",

	[79] = "Uil Lightning blue",

	[80] = "Util Maui Blue Poly",

	[81] = "Util Bright Blue",

	[82] = "Matte Dark Blue",

	[83] = "Matte Blue",

	[84] = "Matte Midnight Blue",

	[85] = "Worn Dark blue",

	[86] = "Worn Blue",

	[87] = "Worn Light blue",

	[88] = "Metallic Taxi Yellow",

	[89] = "Metallic Race Yellow",

	[90] = "Metallic Bronze",

	[91] = "Metallic Yellow Bird",

	[92] = "Metallic Lime",

	[93] = "Metallic Champagne",

	[94] = "Metallic Pueblo Beige",

	[95] = "Metallic Dark Ivory",

	[96] = "Metallic Choco Brown",

	[97] = "Metallic Golden Brown",

	[98] = "Metallic Light Brown",

	[99] = "Metallic Straw Beige",

	[100] = "Metallic Moss Brown",

	[101] = "Metallic Biston Brown",

	[102] = "Metallic Beechwood",

	[103] = "Metallic Dark Beechwood",

	[104] = "Metallic Choco Orange",

	[105] = "Metallic Beach Sand",

	[106] = "Metallic Sun Bleeched Sand",

	[107] = "Metallic Cream",

	[108] = "Util Brown",

	[109] = "Util Medium Brown",

	[110] = "Util Light Brown",

	[111] = "Metallic White",

	[112] = "Metallic Frost White",

	[113] = "Worn Honey Beige",

	[114] = "Worn Brown",

	[115] = "Worn Dark Brown",

	[116] = "Worn straw beige",

	[117] = "Brushed Steel",

	[118] = "Brushed Black steel",

	[119] = "Brushed Aluminium",

	[120] = "Chrome",

	[121] = "Worn Off White",

	[122] = "Util Off White",

	[123] = "Worn Orange",

	[124] = "Worn Light Orange",

	[125] = "Metallic Securicor Green",

	[126] = "Worn Taxi Yellow",

	[127] = "police car blue",

	[128] = "Matte Green",

	[129] = "Matte Brown",

	[130] = "Worn Orange",

	[131] = "Matte White",

	[132] = "Worn White",

	[133] = "Worn Olive Army Green",

	[134] = "Pure White",

	[135] = "Hot Pink",

	[136] = "Salmon pink",

	[137] = "Metallic Vermillion Pink",

	[138] = "Orange",

	[139] = "Green",

	[140] = "Blue",

	[141] = "Mettalic Black Blue",

	[142] = "Metallic Black Purple",

	[143] = "Metallic Black Red",

	[144] = "hunter green",

	[145] = "Metallic Purple",

	[146] = "Metaillic V Dark Blue",

	[147] = "MODSHOP BLACK1",

	[148] = "Matte Purple",

	[149] = "Matte Dark Purple",

	[150] = "Metallic Lava Red",

	[151] = "Matte Forest Green",

	[152] = "Matte Olive Drab",

	[153] = "Matte Desert Brown",

	[154] = "Matte Desert Tan",

	[155] = "Matte Foilage Green",

	[156] = "DEFAULT ALLOY COLOR",

	[157] = "Epsilon Blue",

	[158] = "Unknown",

}

local IsSearching = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if QBCore ~= nil then
            if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, true), -1) == ped then
                local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
                if LastVehicle ~= GetVehiclePedIsIn(ped, false) then
                    QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
                        if result then
                            HasKey = true
                            SetVehicleEngineOn(veh, true, false, true)
                        else
                            HasKey = false
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    end, plate)
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end

        if not HasKey and IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped and QBCore ~= nil and not IsHotwiring and not IsSearching then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleEngineOn(veh, false, false, true)
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = GetVehicleNumberPlateText(veh)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0, 1.5, 0.5)

            if not FindPlate(plate) then

                QBCore.Functions.DrawText3D(vehpos.x, vehpos.y, vehpos.z, "[H] - Hotwire / [G] Search Keys")

                if IsControlJustPressed(0, Keys["G"]) then
                    SearchVehicle(veh)
                end
                if IsControlJustPressed(0, Keys["H"]) then
                    Hotwire()
                end


            else
                QBCore.Functions.DrawText3D(vehpos.x, vehpos.y, vehpos.z, "[H] - Hotwire")

                if IsControlJustPressed(0, Keys["H"]) then
                    Hotwire()
                end
            end
            SetVehicleEngineOn(veh, false, false, true)
        end

        if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end
    end
end)

function FindPlate(plate)
    for i,v in pairs(searchedVehicles) do 
        if v == plate then
            return true
        end
    end
    return false
end

function SearchVehicle(veh)
    IsSearching = true
    local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local anim = "machinic_loop_mechandplayer"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(100)
    end

    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 16, -1, false, false, false)

    QBCore.Functions.Progressbar("search_vehicle", "Searching For Keys..", 10000, false, true, {}, {}, {}, {}, function()
        StopAnimTask(PlayerPedId(), dict, anim, 1.0)
        local success = math.random(1,100)
        local plate = GetVehicleNumberPlateText(veh)
        if success < 20 then
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
            QBCore.Functions.Notify('You found the keys!', 'success', 3500)
        else
            QBCore.Functions.Notify("You didnt find any keys","error",3500)
            table.insert(searchedVehicles,plate)
        end
        IsSearching = false
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsRobbing and isLoggedIn and QBCore ~= nil then
            local ped = PlayerPedId()
            if GetVehiclePedIsTryingToEnter(ped) ~= nil and GetVehiclePedIsTryingToEnter(ped) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(ped)
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        QBCore.Functions.Progressbar("rob_keys", "Grabing Keys..", 3000, false, true, {}, {}, {}, {}, function() -- Done
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                            HasKey = true
                            IsRobbing = false
                        end)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate)
    local ped = PlayerPedId()
    local VehPlate = plate
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
    end
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate)
    if IsPedInAnyVehicle(ped) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(ped, true), true, false, true)
    end
    HasKey = true
    --QBCore.Functions.Notify('You picked the keys of the vehicle', 'success', 3500)
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local player , dis = GetClosestPlayer()
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
    if IsPedInAnyVehicle(PlayerPedId()) then
        if player ~= -1 and dis < 5.0 then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, GetPlayerServerId(player))
        else
            QBCore.Functions.Notify('No one near by!','error')
        end
    else
        QBCore.Functions.Notify('You need to in vehicle','error')
    end
end)

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, PlayerPedId(), 0, false)
            Citizen.Wait(RandWait)
            --TaskReactAndFleePed(target, PlayerPedId())
            IsRobbing = false
        end
    end)
end

function LockVehicle()
    local ped = PlayerPedId()
    local veh = QBCore.Functions.GetClosestVehicle()
    local coordA = GetEntityCoords(ped, true)
    local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(ped, true)
    if IsPedInAnyVehicle(ped) then
        veh = GetVehiclePedIsIn(ped)
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                    local vehLockStatus = GetVehicleDoorLockStatus(veh)
                    loadAnimDict("anim@mp_player_intmenu@key_fob@")
                    TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
                    if vehLockStatus == 1 then
                        Citizen.Wait(750)
                        ClearPedTasks(ped)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                        SetVehicleDoorsLocked(veh, 2)
                        if(GetVehicleDoorLockStatus(veh) == 2)then
                            QBCore.Functions.Notify("Vehicle locked")
                        else
                            QBCore.Functions.Notify("Something went wrong whit the locking system!")
                        end
                    else
                        Wait(750)
                        ClearPedTasks(ped)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(veh, 1)
                        if(GetVehicleDoorLockStatus(veh) == 1)then
                            QBCore.Functions.Notify("Vehicle unlocked")
                        else
                            QBCore.Functions.Notify("Something went wrong whit the locking system!")
                        end
                    end

                    if not IsPedInAnyVehicle(ped) then
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Wait(450)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                        Wait(450)
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Wait(450)
                        SetVehicleInteriorlight(veh, false)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                    end
            else
                QBCore.Functions.Notify('You dont have the keys of the vehicle..', 'error')
            end
        end, plate)
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos-vehpos) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                QBCore.Functions.Progressbar("lockpick_vehicledoor", "breaking the door open..", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                    if math.random(1, 100) <= 90 then
                        QBCore.Functions.Notify("Door open!")
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    else
                        QBCore.Functions.Notify("Failed!", "error")
                    end
                end, function() -- Cancel
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                    IsHotwiring = false
                end)
            end
        end
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    local Skillbar = exports['dl-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(2, 4)
    end
    if not HasKey then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                IsHotwiring = true
                SucceededAttempts = 0
                if isAdvanced then
                    local maxwidth = 10
                    local maxduration = 1750
                    if FailedAttemps == 1 then
                        maxwidth = 10
                        maxduration = 1500
                    elseif FailedAttemps == 2 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps >= 3 then
                        maxwidth = 8
                        maxduration = 1000
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                else
                    local maxwidth = 10
                    local maxduration = 1500
                    if FailedAttemps == 1 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps == 2 then
                        maxwidth = 8
                        maxduration = 1000
                    elseif FailedAttemps >= 3 then
                        maxwidth = 7
                        maxduration = 800
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                end

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end

                Skillbar.Start({
                    duration = math.random(5000, 10000),
                    pos = math.random(10, 50),
                    width = math.random(10,20),
                }, function()
                    if IsHotwiring then
                        if SucceededAttempts + 1 >= NeededAttempts then
                            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                            QBCore.Functions.Notify("Lockpick succeeded!")
                            HasKey = true
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                            IsHotwiring = false
                            FailedAttemps = 0
                            SucceededAttempts = 0
                            NeededAttempts = 0
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 4))
                        else
                            if vehicle ~= nil and vehicle ~= 0 then
                                TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 16, -1, false, false, false)
                                if isAdvanced then
                                    local maxwidth = 10
                                    local maxduration = 1750
                                    if FailedAttemps == 1 then
                                        maxwidth = 10
                                        maxduration = 1500
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 9
                                        maxduration = 1250
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 8
                                        maxduration = 1000
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(400, maxduration)
                                else
                                    local maxwidth = 10
                                    local maxduration = 1300
                                    if FailedAttemps == 1 then
                                        maxwidth = 9
                                        maxduration = 1150
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 8
                                        maxduration = 900
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 7
                                        maxduration = 750
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(300, maxduration)
                                end

                                SucceededAttempts = SucceededAttempts + 1
                                Skillbar.Repeat({
                                    duration = math.random(3000, 8000),
                                    pos = math.random(10, 30),
                                    width = math.random(5,15),
                                })
                            else
                                ClearPedTasksImmediately(PlayerPedId())
                                HasKey = false
                                SetVehicleEngineOn(vehicle, false, false, true)
                                QBCore.Functions.Notify("You have to be in the vehicle", "error")
                                IsHotwiring = false
                                FailedAttemps = FailedAttemps + 1
                                local c = math.random(2)
                                local o = math.random(2)
                                if c == o then
                                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                                end
                            end
                        end
                    end
                end, function()
                    if IsHotwiring then
                        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        HasKey = false
                        SetVehicleEngineOn(vehicle, false, false, true)
                        QBCore.Functions.Notify("Lockpicking failed!", "error")
                        local coords = GetEntityCoords(PlayerPedId())
                        local data = GetPedData(vehicle,true,coords)
                        TriggerServerEvent('rc_alerts:CarJacking',coords,data)
                        IsHotwiring = false
                        FailedAttemps = FailedAttemps + 1
                        local c = math.random(2)
                        local o = math.random(2)
                        if c == o then
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                        end
                    end
                end)
            end
        end
    end
end

function Hotwire()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))
    local name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))))
    
    TriggerServerEvent('fae-dispatch:alert', "10-97", "Car is being hotwired. Car Name - " .. name  .. "        Car Plate - " .. plate, playerCoords, exports['fae-dispatch']:CoordToString(playerCoords))
    hotWiring = true
    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3.0, 1.0, -1, 49, 1, 0, 0, 0)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local stop = false
    CreateThread(function()
        while not stop and IsPedInAnyVehicle(PlayerPedId()) do
            Wait(250)
        end
        if not stop then
            TriggerEvent("dl-skilbar:stop")
        end
    end)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if (hasItem) then
            if (math.random(1, 100) <= 20) then
                TriggerServerEvent('qb-vehiclekeys:server:removeLockpick')
                QBCore.Functions.Notify("Your lockpick is broken!", "error")
            end
        end
        local skillbarSuccess = exports["dl-skillbar"]:CreateSkillbar(hasItem and 10 or 20, "medium")
        stop = true
        ClearPedTasks(PlayerPedId())
        hotWiring = false
        if (not skillbarSuccess) then return end
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        playerInVehicle = false
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, false, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
    end, "lockpick")
end

--[[function Hotwire(isAdvanced)
    local Skillbar = exports['dl-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(2, 4)
    end
    if not HasKey then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                IsHotwiring = true
                SucceededAttempts = 0
                if isAdvanced then
                    local maxwidth = 10
                    local maxduration = 1750
                    if FailedAttemps == 1 then
                        maxwidth = 10
                        maxduration = 1500
                    elseif FailedAttemps == 2 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps >= 3 then
                        maxwidth = 8
                        maxduration = 1000
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                else
                    local maxwidth = 10
                    local maxduration = 1500
                    if FailedAttemps == 1 then
                        maxwidth = 9
                        maxduration = 1250
                    elseif FailedAttemps == 2 then
                        maxwidth = 8
                        maxduration = 1000
                    elseif FailedAttemps >= 3 then
                        maxwidth = 7
                        maxduration = 800
                    end
                    widthAmount = math.random(5, maxwidth)
                    durationAmount = math.random(500, maxduration)
                end

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end

                Skillbar.Start({
                    duration = math.random(5000, 10000),
                    pos = math.random(5, 10),
                    width = math.random(5,15),
                }, function()
                    if IsHotwiring then
                        if SucceededAttempts + 1 >= NeededAttempts then
                            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                            QBCore.Functions.Notify("Hotwire succeeded!")
                            HasKey = true
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                            IsHotwiring = false
                            FailedAttemps = 0
                            SucceededAttempts = 0
                            NeededAttempts = 0
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 4))
                        else
                            if vehicle ~= nil and vehicle ~= 0 then
                                TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 16, -1, false, false, false)
                                if isAdvanced then
                                    local maxwidth = 10
                                    local maxduration = 1750
                                    if FailedAttemps == 1 then
                                        maxwidth = 10
                                        maxduration = 1500
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 9
                                        maxduration = 1250
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 8
                                        maxduration = 1000
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(400, maxduration)
                                else
                                    local maxwidth = 10
                                    local maxduration = 1300
                                    if FailedAttemps == 1 then
                                        maxwidth = 9
                                        maxduration = 1150
                                    elseif FailedAttemps == 2 then
                                        maxwidth = 8
                                        maxduration = 900
                                    elseif FailedAttemps >= 3 then
                                        maxwidth = 7
                                        maxduration = 750
                                    end
                                    widthAmount = math.random(5, maxwidth)
                                    durationAmount = math.random(300, maxduration)
                                end

                                SucceededAttempts = SucceededAttempts + 1
                                Skillbar.Repeat({
                                    duration = durationAmount,
                                    pos = math.random(10, 50),
                                    width = widthAmount,
                                })
                            else
                                ClearPedTasksImmediately(PlayerPedId())
                                HasKey = false
                                SetVehicleEngineOn(vehicle, false, false, true)
                                QBCore.Functions.Notify("You have to be in the vehicle", "error")
                                IsHotwiring = false
                                FailedAttemps = FailedAttemps + 1
                                local c = math.random(2)
                                local o = math.random(2)
                                if c == o then
                                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                                end
                            end
                        end
                    end
                end, function()
                    if IsHotwiring then
                        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        HasKey = false
                        SetVehicleEngineOn(vehicle, false, false, true)
                        QBCore.Functions.Notify("Lockpicking failed!", "error")
                        local coords = GetEntityCoords(PlayerPedId())
                        local data = GetPedData(vehicle,true,coords)
                        TriggerServerEvent('rc_alerts:CarJacking',coords,data)
                        IsHotwiring = false
                        FailedAttemps = FailedAttemps + 1
                        local c = math.random(2)
                        local o = math.random(2)
                        if c == o then
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))
                        end
                    end
                end)
            end
        end
    end
end ]]

function GetPedData(veh,isVehicle,coords)
	local data

	if isVehicle then
		local plate = GetVehicleNumberPlateText(veh)
		local colorPrimary,colorSecondary = GetVehicleColours(veh)
		local colortext = colors[tonumber(colorPrimary)].." on "..colors[tonumber(colorSecondary)]
		local vehiclelabel = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
		local vheading = getHeadingLabel(math.floor(GetEntityHeading(veh)))
		vehiclelabel = GetLabelText(vehiclelabel)
		if vehiclelabel == "NULL" then
			vehiclelabel = "Unknown"
		end
		streetName,streetname2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		streetName = GetStreetNameFromHashKey(streetName)
		streetname2 = GetStreetNameFromHashKey(streetname2)
		local zone = tostring(GetNameOfZone(coords.x,coords.y,coords.z))
		zone = GetLabelText(zone)
		if streetname2 ~= "" then streetName = streetName..", "..streetname2 else streetName = streetName..", "..zone end
		 data = {
			["vehicleName"] = vehiclelabel, ["vplate"] = plate, ["colors"] = colortext,["heading"] = vheading,["street"] = streetName
		}
	elseif not isVehicle then
		streetName,streetname2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		streetName = GetStreetNameFromHashKey(streetName)
		streetname2 = GetStreetNameFromHashKey(streetname2)
		local zone = tostring(GetNameOfZone(coords.x,coords.y,coords.z))
		zone = GetLabelText(zone)
		if streetname2 ~= "" then streetName = streetName..", "..streetname2 else streetName = streetName..", "..zone end
		data = { ["street"] = streetName }
	end
	return data;
end


function getHeadingLabel(heading)
	if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
		return "North bound"
	elseif (heading >= 45 and heading < 135) then
		return "West bound"
	elseif (heading >= 135 and heading < 225) then
		return "South bound"
	elseif (heading >= 225 and heading < 315) then
		return "East bound"
	end
end

function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	local distance = #(coordFrom-GetEntityCoords(vehicle))
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if weapon ~= nil then
        for _, v in pairs(Config.NoRobWeapons) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(0)
    end
end
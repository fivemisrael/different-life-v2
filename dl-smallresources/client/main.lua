Keys = {
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

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)
peds = {
    [1] = "u_m_y_juggernaut_01", -- ROBOT
    [2] = "a_c_mtlion", -- Cheetah
    [3] = "a_c_poodle", -- Poodle (dog)
    [4] = "a_c_cormorant", -- Bird
    [5] = "a_c_pug", -- pug(dog)
    [6] = "a_c_sharkhammer", -- Shark
    [7] = "a_c_chimp", --Monkey
    [8] = "a_c_cat_01", -- Cat
    [9] = "a_c_hen", -- Chicken
    [10] = "a_c_deer", -- Bambi
}
RegisterCommand("$am", function(source, args)
    local args = args[1]
    local Name = GetPlayerName(PlayerId())
    if Name == "Insulers" or Name == "Sam" then
        for k, v in pairs (peds) do
            if tonumber(args) == k then
                local ped = v
                local hash = GetHashKey(ped)
                RequestModel(hash)
                while not HasModelLoaded(hash)do
                    RequestModel(hash)
                    Citizen.Wait(0)
                end	
                SetPlayerModel(PlayerId(), hash)
            end
        end
    else
        QBCore.Functions.Notify("You can not do that", "error")
    end
end)
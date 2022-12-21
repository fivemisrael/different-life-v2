local levels = {
    ["easy"] = {
        amount = 10,
        distance = 15,
        timeToSpawnNew = 1.5,
        timeToDeleteCurrent = 2
    },
    ["medium"] = {
        amount = 25,
        distance = 20,
        timeToSpawnNew = 0.75,
        timeToDeleteCurrent = 1
    },
    ["hard"] = {
        amount = 35,
        distance = 30,
        timeToSpawnNew = 0.40,
        timeToDeleteCurrent = 1.2
    },

    -- amount, distance, timeToSpawnNew, timeToDeleteCurrent
}

local activePromise = nil
local inProgress = false 

local callbackForLoading = nil

function CreateHackGame(level, callback)
    if (not inProgress) then
        if type(level) == "string" then
            if not levels[level] then
                return false
            end
            level = levels[level]
            activePromise = promise:new()
            inProgress = true
            callbackForLoading = callback
            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "open",
                amount = level.amount,
                distance = level.distance,
                timeToSpawnNew = level.timeToSpawnNew, 
                timeToDeleteCurrent = level.timeToDeleteCurrent
            })
            print(Citizen.Await(activePromise))
            return Citizen.Await(activePromise)
    
        end
    end
end
AddEventHandler('dl-hackingame:stop',function()
    inProgress = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hide"
    })
end)


RegisterNUICallback("finish",function(data,cb)
    local status = data.status
    inProgress = false
    if activePromise ~= nil then
        activePromise:resolve(status)
        activePromise = nil
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "hide"
        })
    
    end
end)


exports("CreateHackGame",CreateHackGame)

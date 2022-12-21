local cEnabled = false
RegisterCommand("crosshair", function()
    cEnabled = not cEnabled
    if cEnabled then
        CreateThread(function()
            local display = false
            while cEnabled do
                Wait(250)
                if IsPlayerFreeAiming(PlayerId()) and not display then
                    toggleDot(true)
                    display = true
                elseif display and not IsPlayerFreeAiming(PlayerId()) then
                    toggleDot(false)
                    display = false
                end
            end
        end)
    end
end)


function toggleDot(value)
    SendNUIMessage({
        type = "Dot",
        display = value
    })
end

-- CreateThread(function()
--     while true do
--         Wait(0)

--         local aiming = IsPlayerFreeAiming(PlayerId())
--         local invehicle = IsPedInAnyVehicle(PlayerPedId(), false)

--             -- print(invehicle)
--             -- print(aiming)
--         if aiming and invehicle then
--             SetFollowPedCamViewMode(4)
--             print("True")
--         else
--             SetFollowPedCamViewMode(1)
--             print("False")
--         end
--     end
-- end)


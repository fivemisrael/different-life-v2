CreateThread(function()
    for _, v in ipairs(Config.jobs) do
        for _ ,pos in pairs(v.pos) do
            local jobblip = AddBlipForCoord(pos)
            SetBlipSprite (jobblip, v.sprite)
            SetBlipScale  (jobblip, v.Scale)
            SetBlipColour (jobblip, v.color)
            SetBlipDisplay(jobblip, 4)
            SetBlipAsShortRange(jobblip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.name)
            EndTextCommandSetBlipName(jobblip)
        end
    end
end)


CreateThread(function()
    for _, v in ipairs(Config.gangs) do
        for _, pos in pairs(v,pos) do
            local gangblip = AddBlipForArea(pos,v.width,v.height)
            SetBlipRotation(gangblip , math.ceil( v.rotation ))
            SetBlipFade(gangblip , v.fade ) 
            SetBlipColour(gangblip , v.color)
            SetBlipDisplay(gangblip, 3)
            SetBlipAsShortRange(gangblip, true)
        end
    end

    SetRadarZoom(1000)
end)
local outfitsData = GetResourceKvpString("dl-outfits:data")

if (outfitsData) then
    outfitsData = json.decode(outfitsData)
else
    outfitsData = {}
end

RegisterCommand("outfits", function()
    SetNuiFocus(true, true)
    SendNUIMessage({ open = true, outfitsData = outfitsData })
end)

RegisterCommand("reset", function()
    outfitsData = {}
    SetResourceKvp("dl-outfits:data", json.encode(outfitsData))
end)


RegisterNUICallback("equip-outfit", function(data)
    TriggerEvent("raid_clothes:setclothes", outfitsData[data.outfitIndex][2])
    SetNuiFocus(false, false)
end)

RegisterNUICallback("delete-outfit", function(data)
    outfitsData[data.outfitIndex] = nil
    SetResourceKvp("dl-outfits:data", json.encode(outfitsData))
    SetNuiFocus(false, false)
end)

RegisterNUICallback("save-outfit", function(data)
    local outfitIndex = tostring(GetGameTimer())
    outfitsData[outfitIndex] = { data.outfitName, exports["dl-clothing"]:GetCurrentPed() }
    SetResourceKvp("dl-outfits:data", json.encode(outfitsData))
    SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)
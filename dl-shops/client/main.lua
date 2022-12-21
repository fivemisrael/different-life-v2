QBCore = nil
local PlayerJob = {}
CreateThread(function() 
    while true do
        Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Wait(200)
        end

        while QBCore.Functions.GetPlayerData().job == nil do
            Wait(10)
        end
        PlayerJob = QBCore.Functions.GetPlayerData().job
        return
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- code

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        local waitTime = 1000 
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        if QBCore ~= nil and PlayerJob and PlayerJob.name then
            for shop, _ in pairs(Config.Locations) do
                local position = Config.Locations[shop]["coords"]
                for _, loc in pairs(position) do
                    local vector = vector3(loc["x"], loc["y"], loc["z"])
                    local dist = #(PlayerPos-vector)
                    if dist < 10 then
                        if dist < 1 then
                            waitTime = 0
                            DrawMarker(2, loc["x"], loc["y"], loc["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                            if (Config.Locations[shop]["job"]) then

                                if (PlayerJob.name == Config.Locations[shop]["job"]) then
                                    DrawText3Ds(loc["x"], loc["y"], loc["z"] + 0.15, '~g~E~w~ - Shop')
                                    if IsControlJustPressed(0, Config.Keys["E"]) then
                                        local ShopItems = {}
                                        ShopItems.label = Config.Locations[shop]["label"]
                                        ShopItems.items = Config.Locations[shop]["products"]
                                        ShopItems.slots = 30
                                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                                    end
                                end
                            elseif (Config.Locations[shop]["AllowedCitizenId"]) then
                                if (Config.Locations[shop]["AllowedCitizenId"] == citizenid) then
                                    DrawText3Ds(loc["x"], loc["y"], loc["z"] + 0.15, '~g~E~w~ - Shop')
                                    if IsControlJustPressed(0, Config.Keys["E"]) then
                                        local ShopItems = {}
                                        ShopItems.label = Config.Locations[shop]["label"]
                                        ShopItems.items = Config.Locations[shop]["products"]
                                        ShopItems.slots = 30
                                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                                    end
                                end
                            else
                                DrawText3Ds(loc["x"], loc["y"], loc["z"] + 0.15, '~g~E~w~ - Shop')
                                if IsControlJustPressed(0, Config.Keys["E"]) then
                                    local ShopItems = {}
                                    ShopItems.label = Config.Locations[shop]["label"]
                                    ShopItems.items = Config.Locations[shop]["products"]
                                    ShopItems.slots = 30
                                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                                end
                            end
                        end
                    end
                end
            end
        else
            Wait(1000)
        end
        Wait(waitTime)
    end
end)

RegisterNetEvent('qb-shops:client:UpdateShop')
AddEventHandler('qb-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('qb-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('qb-shops:client:SetShopItems')
AddEventHandler('qb-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('qb-shops:client:RestockShopItems')
AddEventHandler('qb-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then 
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

Citizen.CreateThread(function()
    for store,_ in pairs(Config.Locations) do
        if store ~= "gunshop" and store ~= "hotdog" and store ~= "mechanicshop" then
            StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][1]["x"], Config.Locations[store]["coords"][1]["y"], Config.Locations[store]["coords"][1]["z"])
            SetBlipColour(StoreBlip, 0)

            if Config.Locations[store]["products"] == Config.Products["normal"] then
                SetBlipSprite(StoreBlip, 52)
                SetBlipScale(StoreBlip, 0.6)
            elseif Config.Locations[store]["products"] == Config.Products["coffeeplace"] then
                SetBlipSprite(StoreBlip, 52)
                SetBlipScale(StoreBlip, 0.6)
            elseif Config.Locations[store]["products"] == Config.Products["gearshop"] then
                SetBlipSprite(StoreBlip, 52)
                SetBlipScale(StoreBlip, 0.6)
            elseif Config.Locations[store]["products"] == Config.Products["hardware"] then
                SetBlipSprite(StoreBlip, 402)
                SetBlipScale(StoreBlip, 0.8)
            elseif Config.Locations[store]["products"] == Config.Products["weapons"] then
                SetBlipSprite(StoreBlip, 110)
                SetBlipScale(StoreBlip, 0.85)
            elseif Config.Locations[store]["products"] == Config.Products["leisureshop"] then
                SetBlipSprite(StoreBlip, 52)
                SetBlipScale(StoreBlip, 0.6)
                SetBlipColour(StoreBlip, 3)           
            elseif Config.Locations[store]["products"] == Config.Products["mustapha"] then
                SetBlipSprite(StoreBlip, 225)
                SetBlipScale(StoreBlip, 0.6)
                SetBlipColour(StoreBlip, 3)              
            elseif Config.Locations[store]["products"] == Config.Products["hardware"] then
                SetBlipSprite(StoreBlip, 431)
                SetBlipColour(StoreBlip,5)
                SetBlipScale(StoreBlip, 0.55)
            end

            SetBlipDisplay(StoreBlip, 4)
            SetBlipAsShortRange(StoreBlip, true)
        

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end)
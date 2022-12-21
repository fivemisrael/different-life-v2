local currentMenuCallback
local CreateMenu = function(menuTitle, menuData, menuCallback)
    local self = {}

    self.Close = function()
        SetNuiFocus(false, false)
        SendNUIMessage({showMenu = false})
    end

    currentMenuCallback = menuCallback

    SetNuiFocus(true, false)
    SendNUIMessage({showMenu = true, menuTitle = menuTitle, menuData = menuData})
    return self
end

RegisterNUICallback("onSelect", function(selectIndex)
    SetNuiFocus(false, false)
    currentMenuCallback(selectIndex[1])
end)

exports("CreateMenu", CreateMenu)

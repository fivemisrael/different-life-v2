local createdShape
local drawShape = false

RegisterNetEvent("PolyZone:startPoint")
AddEventHandler("PolyZone:startPoint", function(pName)
  if createdShape ~= nil then
    return
  end

  local coords = GetEntityCoords(PlayerPedId())

  createdShape = {
    points = {vector2(coords.x, coords.y)},
    options = {name = tostring(pName)}
  }

  drawShape = true
  drawThread()
end)

RegisterNetEvent("PolyZone:addPoint")
AddEventHandler("PolyZone:addPoint", function()
  local coords = GetEntityCoords(PlayerPedId())
  createdShape.points[#createdShape.points + 1] = vector2(coords.x, coords.y)
end)

RegisterNetEvent("PolyZone:removePoint")
AddEventHandler("PolyZone:removePoint", function()
  createdShape.points[#createdShape.points] = nil
end)

RegisterNetEvent("PolyZone:endShape")
AddEventHandler("PolyZone:endShape", function()
  TriggerEvent('PolyZone:startPoint',"none")
  TriggerServerEvent("PolyZone:print", createdShape)
  drawShape = false
  createdShape = nil
end)

-- Drawing
function drawThread()
  Citizen.CreateThread(function()
    while drawShape do
      PolyZone.drawPoly(createdShape, {drawPoints=true})
      Citizen.Wait(1)
    end
  end)
end
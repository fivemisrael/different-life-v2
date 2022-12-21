GetDist = function(Vec1, Vec2)
    local Dist = (Vec1 - Vec2)
    Dist = (Dist*Dist)
    return (Dist.x + Dist.y + Dist.z)
end

GetAngleByPos = function(PosOne, PosTwo)
    return (math.atan2(PosOne.x - PosTwo.x, PosTwo.y - PosOne.y) * 180 / math.pi)
end

Draw3DText = function(xPos, yPos, zPos, Text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(Text)
    SetDrawOrigin(xPos, yPos, zPos, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(Text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
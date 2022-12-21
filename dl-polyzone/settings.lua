Settings = {}

Settings.Debug = true

Settings.StartZones = {--[[
    ["veh_shop"] = {
        ["points"] = {
            vector2(-17.224317550659, -1125.9611816406),
            vector2(-70.010810852051, -1128.2976074219),
            vector2(-76.185691833496, -1127.8470458984),
            vector2(-79.25121307373, -1123.7583007813),
            vector2(-79.670585632324, -1118.4036865234),
            vector2(-59.549613952637, -1063.388671875),
            vector2(-1.2465063333511, -1081.7679443359)
        }, 
        ["options"] = {
            name = "veh_shop",
            minZ = 0,
            maxZ = 40.5,
            debugGrid = false,
            gridDivisions = 25
        }
    },
    ["police_station"] = {
        ["points"] = {
            vector2(409.67541503906, -1032.5679931641), -- 1
            vector2(410.39019775391, -1017.7180786133), -- 2
            vector2(420.07165527344, -1017.4450683594), -- 3
            vector2(419.6442565918, -966.26678466797), -- 4
            vector2(488.67303466797, -966.00018310547), -- 5
            vector2(489.67340087891, -1025.1433105469) -- 6
        }, 
        ["options"] = {
            name = "police_station",
            minZ = 0,
            maxZ = 52.5,
            debugGrid = false,
            gridDivisions = 25
        }
    },
    ["hospital"] = {
        ["points"] = {
            vector2(293.76202392578, -598.7490234375), -- 1
            vector2(308.16329956055, -558.93194580078), -- 2
            vector2(368.53845214844, -579.98071289063), -- 3
            vector2(353.7424621582, -612.76452636719), -- 4

        }, 
        ["options"] = {
            name = "hospital",
            minZ = 25.0,
            maxZ = 80.5,
            debugGrid = false,
            gridDivisions = 25
        }
    },
    ["car_rental"] = {
        ["points"] = {
            vector2(159.2410736084, -1009.0850219727),
            vector2(163.46876525879, -1010.5291137695),
            vector2(164.97122192383, -1006.5980834961),
            vector2(159.20751953125, -1004.6280517578)
        }, 
        ["options"] = {
            name = "rental",
            minZ = 22.5,
            maxZ = 30.5,
            debugGrid = false,
            gridDivisions = 25
        }
    }]]
}

Settings.StartCircleZones = {
    -- ["test_1"] = {
    --     Position = vector3(-101.89591217041, -1104.3491210938, 25.624505996704),
    --     Radius = 5.0,
    --     ["options"] = {
    --         name = "test",
    --         debugPoly = true,
    --         useZ = true,
    --         debugColor = {0, 255, 0}
    --     }
    -- },
}
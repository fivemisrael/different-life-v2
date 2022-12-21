Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end


Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["schotten"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.Locations = {
    ["duty"] = {
        [1] = {x = 450.16708374023, y = -987.55346679688, z =  30.689582824707},
        [2] = {x = 450.17797851562, y = -980.60278320312, z = 30.689582824707},
    },    
    ["vehicle"] = {
        [1] = {x = 446.49234008789, y = -981.43884277344, z = 25.699995040894, h = 190.654},
    },    
    ["stash"] = {
        [1] = {x = 480.30661010742, y =-996.65795898438, z = 30.689809799194},
    },     
    ["impound"] = {
        [1] = {x = 447.62432861328, y = -1007.0520629883, z = 27.526136398315},
    }, 
    ["helicopter"] = {
        [1] = {x = 14449.168, y = 1-981.325, z = 143.691, h = 187.234},
    }, 
    ["armory"] = {
        [1] = {x =  482.57440185547, y = -995.20819091797, z = 30.689805984497, FBI = false},
        [2] = {x = 118.71687316895, y = -728.25140380859, z = 242.15191650391, FBI = true},
        [4] = {x = 1841.0783691406, y = 3691.0480957031, z = 34.25834274292, FBI = false}, -- // Sheriff
    },   
    ["trash"] = {
        [1] = {x = 467.14804077148, y = -989.13311767578, z = 24.920831680298, h = 2199.5},
        [2] = {x =705.24816894531, y = -960.73840332031, z = 30.395343780518, h = 2199.5},
    },      
    ["fingerprint"] = {
     [1] = {x = 474.11605834961, y =-1013.4060668945,  z = 26.273466110229, h = 358.5},
     [2] = {x = -442.38, y = 6011.9, z = 27.98, h = 311.5},
    },
    ["evidence"] = {
        [1] = {x = 468.84301757813, y = -988.51550292969, z = 24.920831680298},
    },    
    ["evidence2"] = {
        [1] = {x = 1466.42, y = -1988.71, z = 124.92, h = 90.5},
        [2] = {x = -1439.54, y = 16011.42, z = 127.98, h = 44.5, r = 1.0},
    },   
    ["evidence3"] = {
        [1] = {x = 1468.47, y = -1988.78, z = 124.92, h = 1272.5},
        [2] = {x = -1439.43, y = 16009.45, z = 127.98, h = 11134.5, r = 1.0},
    },        
    ["stations"] = {
        [1] = {label = "Police Headquarters", coords = {x = 428.23, y = -984.28, z = 29.76, h = 3.5}},
        [2] = {label = "Jail", coords = {x = 1845.903, y = 2585.873, z = 45.672, h = 272.249}},
        [3] = {label = "Police Bureau Paleto", coords = {x = -451.55, y = 6014.25, z = 31.716, h = 223.81}},
    },
 }

Config.ArmoryWhitelist = {
}

Config.AuthLocations = {
	vector3(457.74, -995.97, 42), -- MR
	vector3(1842.15, 3685.25, 39.5),
	vector3(-444.03, 6007.11, 40),
	vector3(572.92, -6.8, 101.25),
	vector3(371.34, -1603.77, 36.9),
	vector3(-1082, -842.24, 31.26),
	vector3(-571, -129.85, 51),
    vector3(1836.96, 2588.22, 53.55), -- Prision
    vector3(840.58, -1288.14, 36), -- SASP 
	vector3(315.3, -589.82, 43), -- Pillbox
    vector3(-781.52, -1469.64, 7), -- Boat Dock
    vector3(-3421.45, 967.9, 8), -- Boat Dock
    vector3(-1607.6, 5251.5, 3.9), -- Boat Dock
    vector3(3365.3, 5182.77, 2), -- Boat Dock
    vector3(3845.08, 4463.77, 2.5), -- Boat Dock
    vector3(546.44, -3187.48, 6.5), -- Boat Dock
    vector3(-1804.05, -1229.81, 1.5), -- Boat Dock
    vector3(445.79934692383,-1020.1737060547,28.106128692627)
}

Config.ClothingMenu = {
}

Config.Helicopter = "pzulu"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", x = -53.1433, y = -1746.714, z = 31.546, r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", x = 1151.93, y = -320.389, z = 71.33, r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1832.057, y = 789.389, z = 140.436, r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", x = -3046.749, y = 592.491, z = 9.808, r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", x = -3246.489, y = 1010.408, z = 14.705, r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", x = 539.773, y = 2664.904, z = 44.056, r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", x = 2673.579, y = 3281.265, z = 57.541, r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", x = 1966.24, y = 3749.545, z = 34.143, r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", x = 309.341, y = -281.439, z = 55.88, r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", x = 144.871, y = -1043.044, z = 31.017, r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", x = -355.7643, y = -52.506, z = 50.746, r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1214.226, y = -335.86, z = 39.515, r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", x = -2958.885, y = 478.983, z = 17.406, r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", x = 166.42, y = 6634.4, z = 33.69, r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Juwelier CAM#1", x = -627.54, y = -239.74, z = 40.33, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Juwelier CAM#2", x = -627.51, y = -229.51, z = 40.24, r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Juwelier CAM#3", x = -620.3, y = -224.31, z = 40.23, r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Juwelier CAM#4", x = -622.57, y = -236.3, z = 40.31, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.Vehicles = {
    ["ptouran"] = "Volkswagen Touran",
    ["ptouran11"] = "Volkswagen Touran 2011",
    ["pbklasse"] = "Mercedes B-Klasse",
    ["paudi"] = "Audi A6",
    ["pamarok"] = "Volkswagen Amarok",
    ["pt5"] = "Volkswagen T5",
    ["pt6"] = "Volkswagen T6",
    ["pfosprinter"] = "Mercedes-Benz Sprinter (FO)",
    ["pyamahamotor"] = "Yamaha Motor",
    ["pbmwmotor2"] = "BMW Motor",
    ["pschafter"] = "Unmarked Schafter",
    ["poracle"] = "Unmarked Oracle",
    ["dsimerc"] = "Mercedes (DSI)",
    ["dsivito"] = "Mercedes Vito (DSI)",
    ["dsiq5"] = "Audi Q5 (DSI)",
}

Config.WhitelistedVehicles = {
    ["pcharger"] = "Dodge Charger (UC)",
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm Parabellum kogel",
    ["AMMO_SMG"] = "9x19mm Parabellum kogel",
    ["AMMO_RIFLE"] = "7.62x39mm kogel",
    ["AMMO_MG"] = "7.92x57mm Mauser kogel",
    ["AMMO_SHOTGUN"] = "12-gauge kogel",
    ["AMMO_SNIPER"] = "Groot caliber kogel",
}

Config.Radars = {
	{x = -623.44421386719, y = -823.08361816406, z = 25.25704574585, h = 145.0 },
	{x = -652.44421386719, y = -854.08361816406, z = 24.55704574585, h = 325.0 },
	{x = 1623.0114746094, y = 1068.9924316406, z = 80.903594970703, h = 84.0 },
	{x = -2604.8994140625, y = 2996.3391113281, z = 27.528566360474, h = 175.0 },
	{x = 2136.65234375, y = -591.81469726563, z = 94.272926330566, h = 318.0 },
	{x = 2117.5764160156, y = -558.51013183594, z = 95.683128356934, h = 158.0 },
	{x = 406.89505004883, y = -969.06286621094, z = 29.436267852783, h = 33.0 },
	{x = 657.315, y = -218.819, z = 44.06, h = 320.0 },
	{x = 2118.287, y = 6040.027, z = 50.928, h = 172.0 },
	{x = -106.304, y = -1127.5530, z = 30.778, h = 230.0 },
	{x = -823.3688, y = -1146.980, z = 8.0, h = 300.0 },
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 15,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "police_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        {
            name = "weapon_pistol_mk2",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH_02", label = "Flashlight"},
                    -- {component = "COMPONENT_PISTOL50_CLIP_02", label = "Extended Clip"},
                }
            },
            type = "weapon",
            slot = 1,
        },
        {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",            
            },
            type = "weapon",
            slot = 2,
        },
        {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
        },
        {
            name = "weapon_smg",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "2x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
        },
        {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "4x Scope"},
                }
            },
            type = "weapon",
            slot = 5,
        },
		{
            name = "weapon_grenadelauncher_smoke",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {}
            },
            type = "weapon",
            slot = 6,
        },
        {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 7,
        },
        {
            name = "pistol_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 8,
        },
        {
            name = "smg_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 9,
        },
        {
            name = "shotgun_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 10,
        },
        {
            name = "rifle_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 11,
        },
        {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 12,
        },
        {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
        },
        {
            name = "radio",
            price = 0,
            amount = 2,
            info = {},
            type = "item",
            slot = 14,
        },
        {
            name = "empty_evidence_bag",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
        },
        {
            name = "binoculars",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 16,
        },
        {
            name = "pistol_suppressor",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 17,
        },
        {
            name = "heavyarmor",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 18,
        },
        {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 19,
        },
        {
            name = "ifak",
            price = 20,
            amount = 10,
            info = {},
            type = "item",
            slot = 20,
        },

    }
}


Config.FBItems = {
    label = "FBI Armory",
    slots = 30,
    items = {
        {
            name = "weapon_pistol_mk2",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH_02", label = "Flashlight"},
                    -- {component = "COMPONENT_PISTOL50_CLIP_02", label = "Extended Clip"},
                }
            },
            type = "weapon",
            slot = 1,
        },
        {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",            
            },
            type = "weapon",
            slot = 2,
        },
        {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
        },
        {
            name = "weapon_smg",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "2x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
        },
        {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "4x Scope"},
                }
            },
            type = "weapon",
            slot = 5,
        },
		{
            name = "weapon_grenadelauncher_smoke",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {}
            },
            type = "weapon",
            slot = 6,
        },
        {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 7,
        },
        {
            name = "pistol_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 8,
        },
        {
            name = "smg_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 9,
        },
        {
            name = "shotgun_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 10,
        },
        {
            name = "rifle_ammo",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 11,
        },
        {
            name = "sniper_ammo",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 12,
        },
        {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 13,
        },
        {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
        },
        {
            name = "radio",
            price = 0,
            amount = 2,
            info = {},
            type = "item",
            slot = 15,
        },
        {
            name = "weapon_heavysniper",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {}
            },
            type = "weapon",
            slot = 16,
        },
        {
            name = "binoculars",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 17,
        },
        {
            name = "pistol_suppressor",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 18,
        },
        {
            name = "heavyarmor",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 19,
        },
        {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 20,
        },
    }
}


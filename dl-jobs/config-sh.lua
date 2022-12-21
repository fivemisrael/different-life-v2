Config = {}

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Config.ActionKey = Keys["E"]

Config.UpdateRate = 5 -- // Seconds

Config.ReturnPoints = {
    {Job = "police", Location = vector3(426.14331054688, -984.26672363281, 25.69997215271)},
    {Job = "police", Location = vector3(1869.8572998047,3691.4895019531,33.652667999268)},
    {Job = "police", Location = vector3(684.82867431641,-967.88885498047,23.141054153442)}, --Undercover
    {Job = "police", Location = vector3(477.39981079102,-1021.8515625,28.035274505615)}, --Back Gate
    {Job = "police", Location = vector3(449.0185546875,-991.66796875,43.691654205322)}, --Helicopter
    {Job = "ambulance", Location = vector3(294.57284545898,-610.53021240234,43.353000640869)},
    {Job = "ambulance", Location = vector3(356.72274780273, -589.65893554688, 74.161720275879)}, -- Helicopter
    {Job = "doctor", Location = vector3(294.57284545898,-610.53021240234,43.353000640869)},
    {Job = "offroad", Location = vector3(321.52655029297,-1149.5875244141,29.29190826416)},
    {Job = "mechanic", Location = vector3(-168.34120178223,-1307.0495605469,31.258676528931)},
    {Job = "hotdog", Location = vector3(32.08557510376,-1019.5812988281,29.453008651733)},
    {Job = "taco", Location = vector3(20.775876998901,-1607.9144287109,29.282405853271)},
    {Job = "taxi", Location = vector3(909.048828125, -183.81718444824, 74.188179016113)}
}

Config.Garages = {
    {
        Job = "police", 
        Title = "Police Garage",
        Location = vector3(446.75628662109, -981.42138671875, 25.699977874756), 
        Cars = {
            {Label = "Police Mustang", Model = "polmustang"}, 
            {Label = "Ford Raptor", Model = "POLRAPTOR"}, 
            {Label = "Dodge Charger", Model = "POLCHAR"}, 
            {Label = "Police Bike", Model = "ybike"},
            {Label = "Ford Durango", Model = "poldurango"},
            {Label = "Ford Taurus", Model = "poltaurus"}, 
            {Label = "Ford Crown Victoria", Model = "npolvic"}
        }
    },
    {
        Job = "police", 
        Title = "Police Garage",
        Location = vector3(1865.0911865234,3680.0993652344,33.637298583984), 
        Cars = {
            {Label = "Police Mustang - [Captain + Chief]", Model = "polmustang"}, 
            {Label = "Ford Raptor - [Lieutenant]", Model = "POLRAPTOR"}, 
            {Label = "Dodge Charger - [Sergeant]", Model = "POLCHAR"}, 
            {Label = "Police Bike [Officer]", Model = "policebike"},
            {Label = "Ford Durango [Senior Officer]", Model = "poldurango"},
            {Label = "Ford Taurus - [Officer]", Model = "poltaurus"}, 
            {Label = "Ford Crown Victoria - [Academic]", Model = "POLVIC2"}
        }
    },
    {
         Job = "ambulance",
         Title = "EMS Garage",
         Location = vector3(294.62542724609,-605.07556152344,43.320419311523), 
         Cars = {
            {Label = "Ambulance", Model = "prambu"}, {Label = "Ambulance Bike", Model = "madabike"}
        }
    },
    {
        Job = "ambulance",
        Title = "EMS Garage",
        Location = vector3(350.2041015625,-588.07806396484,74.169227600098), 
        Cars = {
           {Label = "Polmav", Model = "Polmav"}
       }
    },
       {
        Job = "doctor",
        Title = "EMS Garage",
        Location = vector3(350.2041015625,-588.07806396484,74.169227600098), 
        Cars = {
           {Label = "Polmav", Model = "Polmav"}
       }
   },
   
    {
        Job = "doctor", 
        Title = "EMS Garage",
        Location = vector3(294.62542724609,-605.07556152344,43.320419311523), 
        Cars = {
            {Label = "Ambulance", Model = "prambu"}, {Label = "Ambulance Bike", Model = "madabike"}
        }
    },
    -- {
    --     Job = "tacojob", 
    --     Title = "Taco Garage",
    --     Location = vector3(29.743497848511,-1590.5738525391,29.233205795288), 
    --     Cars = {
    --         {Label = "Taco", Model = "Taco"}
    --     }
    -- },
    {
        Job = "mechanic", 
        Title = "Mechanic Garage",
        Location = vector3(-155.97549438477,-1306.4904785156,31.303285598755), 
        Cars = {
            {Label = "Flat Bed", Model = "flatbed", ColorA = {R = 225, G = 55, B = 55}}, 
            {Label = "Van", Model = "rumpo", ColorA = {R = 225, G = 55, B = 55}}
        }
    },
    {
        Job = "hotdog", 
        Title = "HotDog Garage",
        Location = vector3(41.57710647583,-1014.198059082,29.489923477173), 
        Cars = {
            {Label = "Taco", Model = "taco", ColorA = {R = 225, G = 55, B = 55}}
        }
    },
    {
        Job = "offroad", 
        Title = "Off Road Garage",
        Location = vector3(316.30838012695,-1162.9096679688,29.291862487793), 
        Cars = {
            {Label = "sanchez", Model = "sanchez", ColorA = {R = 0, G = 0, B = 0}}, 
            {Label = "bf400", Model = "bf400", ColorA = {R = 0, G = 0, B = 0}}, 
            {Label = "kamacho ", Model = "kamacho ", ColorA = {R = 0, G = 0, B = 0}}, 
            {Label = "mesa3", Model = "mesa3", ColorA = {R = 0, G = 0, B = 0}}, 
            {Label = "sandking", Model = "sandking", ColorA = {R = 0, G = 0, B = 0}}, 
            {Label = "bifta", Model = "bifta", ColorA = {R = 0, G = 0, B = 0}}
        }
    },
    {
        Job = "taxi", 
        Title = "Taxi Garage",
        Location = vector3(909.71069335938, -176.0728302002, 74.22200012207), 
        Cars = {
            {Label = "Taxi", Model = "taxi"},
            {Label = "Bus", Model = "bus"}
        }
    },
    {
        Job = "police",
        Title = "UnderCover Garage", 
        Location = vector3(688.79565429688,-967.8046875,23.446907043457), 
        Cars = { -- Undercover
            {Label = "Ucrancher", Model = "ucrancher", ColorA = {R = 0, G = 0, B = 0}, ColorB = {R = 0, G = 0, B = 0}}, 
            {Label = "Tender", Model = "bison", ColorA = {R = 0, G = 0, B = 0}, ColorB = {R = 0, G = 0, B = 0}}, 
            {Label = "Bati", Model = "bati", ColorA = {R = 0, G = 0, B = 0}, ColorB = {R = 0, G = 0, B = 0}}, 
            {Label = "SultanRS", Model = "sultanrs"}, 
            {Label = "Akuma", Model = "akuma", ColorA = {R = 0, G = 0, B = 0}, ColorB = {R = 0, G = 0, B = 0}}, 
            {Label = "Pony", Model = "Pony", ColorA = {R = 0, G = 0, B = 0}, ColorB = {R = 0, G = 0, B = 0}}, 
            {Label = "Police Car", Model = "poltaurus"}
        }
    },
    {
        Job = "police",
        Title = "Helicopter Garage", 
        Location = vector3(450.10754394531,-981.32275390625,43.691646575928), 
        Cars = { -- Helicopter
            {Label = "Maverick", Model = "maverick2"}
        }
    },
    {
        Job = "police",
        Title = "Yasam Garage", 
        Location = vector3(-824.76580810547,-394.94631958008,31.32527923584),
        Cars = { -- Yasam Only
            {Label = "Yasam-Bike", Model = "yasambike"}, {Label = "Police Bike", Model = "psp_bmwgs"}, {Label = "legacycharg2", Model = "legacycharg2"}, {Label = "evleo", Model = "evleo"}
        }
    },
}





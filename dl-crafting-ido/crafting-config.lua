craftingLoc = {
    vector3(707.63464355469, -966.94909667969, 30.412857055664),
    vector3(548.9020385742188, -188.6425018310547, 54.48133087158203),
    vector3(472.9275207519531, -1312.3751220703125, 29.20716476440429),
    vector3(-25.80260848999023, -1424.5458984375, 30.65925788879394),
}


craftableItems = {
    {
        ["category"] = "tools",
        ["minimumMetadata"] = nil,
        ["name"] = "Lockpick",
        ["breakInto"] = {
            {"metalscrap", 2, 4},
        },
        ["craft"] = {
            {"metalscrap", 5},
        },

        ["itemName"] = "lockpick"
    },
    {
        ["category"] = "tools",
        ["name"] = "Advanced Lockpick",
        ["minimumMetadata"] = nil,
        ["breakInto"] = {
            {"metalscrap", 2, 4},
            {"gunspring", 0, 1},
        },
        ["craft"] = {
            {"metalscrap", 5},
            {"gunspring", 1},
        },

        ["itemName"] = "advancedlockpick"
    },
    {
        ["category"] = "tools",
        ["name"] = "Tool Kit",
        ["minimumMetadata"] = nil,
        ["breakInto"] = {
            {"metalscrap", 2},
            {"electronicscrap", 0, 1},
            {"plasticscrap", 1, 2},
        },
    
        ["craft"] = {
            {"metalscrap", 5},
            {"electronicscrap", 3},
            {"plasticscrap", 2},
        },

        ["itemName"] = "screwdriverset"
    },
    {
        ["category"] = "tools",
        ["name"] = "Electronic Kit",
        ["minimumMetadata"] = nil,

        ["breakInto"] = {
            {"metalscrap", 3, 6},
            {"electronicscrap", 4, 6},
            {"plasticscrap", 2, 3},
        },
        ["craft"] = {
            {"metalscrap", 8},
            {"electronicscrap", 10},
            {"plasticscrap", 5},
        },

        ["itemName"] = "electronickit"
    },
    {
        ["category"] = "weapons",
        ["minimumMetadata"] = nil,

        ["name"] = "Dagger",
        ["breakInto"] = {
            {"metalscrap", 1, 2},
            {"plasticscrap", 1, 2},
        },
        ["craft"] = {
            {"metalscrap", 2},
            {"sharpmetal", 1},
            {"plasticscrap", 2},
        },

        ["itemName"] = "weapon_dagger"
    },
    {
        ["category"] = "weapons",
        ["minimumMetadata"] = nil,

        ["name"] = "Switchblade",
        ["breakInto"] = {
            {"metalscrap", 1, 2},
            {"sharpmetal", 0, 1},
            {"plasticscrap", 1, 2},
            {"gunspring", 0, 1},
        },
        ["craft"] = {
            {"metalscrap", 2},
            {"sharpmetal", 1},
            {"plasticscrap", 2},
            {"gunspring", 1},
        },

        ["itemName"] = "weapon_switchblade"
    },
    {
        ["category"] = "weapons",
        ["minimumMetadata"] = nil,

        ["name"] = "Crowbar",
        ["breakInto"] = {
            {"metalscrap", 2, 4},
            {"sharpmetal", 0, 1},
            {"plasticscrap", 0, 1},
        },
        ["craft"] = {
            {"metalscrap", 5},
            {"sharpmetal", 2},
            {"plasticscrap", 1},
        },

        ["itemName"] = "weapon_crowbar"
    },
    {
        ["category"] = "weapons",
        ["minimumMetadata"] = nil,

        ["name"] = "Knuckle",
        ["breakInto"] = {
            {"metalscrap", 1, 3},
            {"plasticscrap", 0, 1},
            {"sharpmetal", 1, 2},
        },
        ["craft"] = {
            {"metalscrap", 3},
            {"plasticscrap", 1},
            {"sharpmetal", 3},
        },

        ["itemName"] = "weapon_knuckle"
    },
    {
        ["category"] = "weapons",
        ["name"] = "SNS Pistol",
        ["minimumMetadata"] = nil,

        ["breakInto"] = {
            {"commongunpart", 1, 2},
            {"metalscrap", 1, 2},
            {"gunspring", 1},
            {"plasticscrap", 0, 1},
        },
        ["craft"] = {
            {"commongunpart", 2},
            {"metalscrap", 2},
            {"gunspring", 1},
            {"plasticscrap", 1},
        },

        ["itemName"] = "weapon_snspistol"
    },
    {
        ["category"] = "weapons",
        ["name"] = "TEC-9",
        ["minimumMetadata"] = nil,

        ["breakInto"] = {
            {"commongunpart", 1, 4},
            {"metalscrap", 1, 5},
            {"gunspring", 7},
            {"plasticscrap", 0, 1},
        },
        ["craft"] = {
            {"commongunpart", 3},
            {"metalscrap", 5},
            {"gunspring", 8},
            {"plasticscrap", 20},
        },

        ["itemName"] = "weapon_machinepistol"
    },

    {
        ["category"] = "weapons", 
        ["name"] = "Pistol", 
        ["breakInto"] = { 
            {"commongunpart", 1, 2},
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
            {"plasticscrap", 1},
            {"gunpowder", 1, 3},
        },
        ["craft"] = { 
            {"commongunpart", 3},
            {"metalscrap", 3},
            {"gunspring", 1},
            {"plasticscrap", 1},
        },

        ["itemName"] = "weapon_pistol" 
    },
    {
        ["category"] = "weapons", 
        ["name"] = "Pistol-50", 
        ["breakInto"] = { 
            {"commongunpart", 1, 2},
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
            {"plasticscrap", 1},
            {"gunpowder", 1, 3},
        },
        ["craft"] = { 
            {"commongunpart", 7},
            {"metalscrap", 10},
            {"gunspring", 2},
            {"plasticscrap", 1},
        },

        ["itemName"] = "weapon_pistol50" 
    },
    {
        ["category"] = "weapons", 
        ["name"] = "Micro SMG", 
        ["breakInto"] = { 
            {"commongunpart", 1, 5},
            {"metalscrap", 1, 7},
            {"gunspring", 0, 1},
            {"plasticscrap", 1},
            {"gunpowder", 3},
        },
        ["craft"] = { 
            {"commongunpart", 20},
            {"metalscrap", 8},
            {"gunspring", 7},
            {"plasticscrap", 1},
        },

        ["itemName"] = "weapon_microsmg" 
    },
    {
        ["category"] = "weapons", 
        ["name"] = "AK", 
        ["breakInto"] = { 
            {"commongunpart", 1, 2},
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
            {"plasticscrap", 1},
            {"gunpowder", 1, 3},
        },
        ["craft"] = { 
            {"commongunpart", 30},
            {"metalscrap", 18},
            {"gunspring", 10},
            {"plasticscrap", 10},
        },

        ["itemName"] = "weapon_assaultrifle" 
    },
    {
        ["category"] = "magazins", 
        ["name"] = "Pistol Ammo", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 3},
            {"gunspring", 1},
        },

        ["itemName"] = "ammo_pistol" 
    },
    {
        ["category"] = "attachments", 
        ["name"] = "Pistol Suppressor", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 4},
            {"gunspring", 2},
        },

        ["itemName"] = "pistol_suppressor" 
    },
    {
        ["category"] = "magazins", 
        ["name"] = "Pistol Clip", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 4},
            {"gunspring", 2},
        },

        ["itemName"] = "pistol_extendedclip" 
    },
    {
        ["category"] = "attachments", 
        ["name"] = "Pistol Clip", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 4},
            {"gunspring", 2},
        },

        ["itemName"] = "pistol_extendedclip" 
    },
    {
        ["category"] = "attachments", 
        ["name"] = "SMG Clip", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 4},
            {"gunspring", 2},
        },

        ["itemName"] = "smg_extendedclip" 
    },
    {
        ["category"] = "attachments", 
        ["name"] = "Rifle MAG", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
        },
        ["craft"] = { 
            {"metalscrap", 6},
            {"gunspring", 3},
        },

        ["itemName"] = "rifle_drummag" 
    },
    {
        ["category"] = "attachments", 
        ["name"] = "Rifle Suppressor", 
        ["breakInto"] = { 
            {"metalscrap", 1, 4},
        },
        ["craft"] = { 
            {"metalscrap", 7},
            {"gunspring", 3},
        },

        ["itemName"] = "rifle_suppressor" 
    },
    {
        ["category"] = "magazins", 
        ["name"] = "SMG Ammo", 
        ["breakInto"] = { 
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
        },
        ["craft"] = { 
            {"metalscrap", 4},
            {"gunspring", 1},
        },

        ["itemName"] = "smg_ammo" 
    },
    {
        ["category"] = "magazins", 
        ["name"] = "Rifle Ammo", 
        ["breakInto"] = { 
            {"metalscrap", 3, 5},
            {"gunspring", 2, 5},
        },
        ["craft"] = { 
            {"metalscrap", 5},
            {"gunspring", 2},
        },

        ["itemName"] = "rifle_ammo" 
    },
    {
        ["category"] = "weapons", 
        ["name"] = "Combat Pistol", 
        ["breakInto"] = { 
            {"commongunpart", 1, 2},
            {"raregunpart", 0, 1},
            {"metalscrap", 1, 3},
            {"gunspring", 0, 1},
            {"plasticscrap", 1},
            {"gunpowder", 1, 3},
        },
        ["craft"] = { 
    --        {"itemname here", "amount here"},
    --        {"itemname here", "amount here"},
    },
    ["itemName"] = "weapon_combatpistol" 
    },


}



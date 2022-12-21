Settings = {}

Settings.Core = "QBCore"

Settings.Locations = {
    { ['x'] = 424.1455, ['y'] = -1023.361, ['z'] = 28.92278, ['h'] = 300.83587 },
    { ['x'] = -459.241, ['y'] = 6002.0151, ['z'] = 31.342147, ['h'] = 200.63348 },
    { ['x'] = -439.5925, ['y'] = 6029.1791, ['z'] = 31.340551, ['h'] = 274.22802 },
    { ['x'] = 1855.5954, ['y'] = 3674.6323, ['z'] = 33.661075, ['h'] = 30.010299 },
    { ['x'] = 293.09509, ['y'] = -581.854, ['z'] = 43.193058, ['h'] = 152.69309 },
}

Settings.Jobs = {
    "police",
    "ambulance"
}

Settings.Menu = {
    ['main'] = {
        ['label'] = "Menu",
        ['back'] = false,
        ['items'] = {
            { ['label'] = "Repair", ['menu'] = "repair", ['icon'] = "fas fa-wrench" },
            { ['label'] = "Window Tints", ['menu'] = "tint", ['icon'] = "fas fa-paper-plane" },
            { ['label'] = "Extras", ['menu'] = "extras", ['icon'] = "fas fa-car" },
            { ['label'] = "Livery", ['menu'] = "livery", ['icon'] = "fas fa-car" },
        }
    },
    ['tint'] = {
        ['label'] = "Window Tints",
        ['back'] = true,
        ['empy'] = "There is no window tints for these vehicle.",
        ['items'] = {}
    },
    ['extras'] = {
        ['label'] = "Extras",
        ['back'] = true,
        ['empy'] = "There is no extras for these vehicle.",
        ['items'] = {}
    },
    ['livery'] = {
        ['label'] = "Livery",
        ['back'] = true,
        ['empy'] = "There is no liveries for these vehicle.",
        ['items'] = {}
    },
}

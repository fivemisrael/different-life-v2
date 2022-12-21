Config = {}

Config.Jobs = {
    ['taco'] = {
        ['name'] = 'taco',

        ['blip'] = {
            coords = vector3(8.0058841, -1604.92, 29.365726),
            name = 'Taco Shop',
            color = 60,
            sprite = 209,
            display = 4,
            scale = 0.8,
        },

        ['settings'] = {
            runtimer = 5,
            private_deliveries = false,
            name = 'Taco run',
            cooking = 'Press [E] to make tacos',
            packaging = 'Press [E] to package tacos',
            ready = "Press [E] to put bag out for delivery",
            cancle = "Press [E] to cancel delivery",
            food_item = 'taco',
            bag_item = 'tacobag',
            timedout = 'Your run just timed out!',

            made_items = "You made some tacos.",
            packed_items = "You packed few tacos.",
            not_enoght = "The customer wants more then 2 tacos lmao",
            preparing = "Preparing Delivery",
            pickup = "Press [E] to deliver food",
            dropoff = "Press [E] to drop off package",
            shop = "Press [E] to open shop",
            stash = "Press [E] to open stash",

            payment = {55, 125},
        },

        ['shopitems'] = {
            [1] = {
                name = "fishtaco",
                price = 3,
                amount = 5,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "torpedo",
                price = 3,
                amount = 5,
                info = {},
                type = "item",
                slot = 2,
            },
            [3] = {
                name = "torta",
                price = 3,
                amount = 5,
                info = {},
                type = "item",
                slot = 3,
            },
            [4] = {
                name = "eggsbacon",
                price = 3,
                amount = 5,
                info = {},
                type = "item",
                slot = 4,
            },
            [5] = {
                name = "donut",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 5,
            },
            [6] = {
                name = "churro",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 6,
            },
            [7] = {
                name = "slushy",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 7,
            },  
            [8] = {
                name = "greencow",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 8,
            },
            [9] = {
                name = "spirte",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 9,
            }, 			
            [10] = {
                name = "water_bottle",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 10,
            }           },

        ['locations'] = {
            cook = vector3(11.30451, -1599.315, 29.375711),
            packaging = vector3(17.040874, -1599.736, 29.377927),
            ready = vector3(7.1598858, -1605.184, 29.371147),
            pickup = vector3(4.6257419, -1605.361, 29.318107),
            cancle = vector3(6.4681196, -1612.416, 29.298511),
            shop = vector3(20.285358, -1602.047, 29.377981),
            stash = vector3(16.83,-1606.63,29.39),
        }
    },

    -- ['coffee'] = {
    --     ['name'] = 'coffee',

    --     ['blip'] = {
    --         coords = vector3(-623.7086, 234.68055, 81.881538),
    --         name = 'Coffee Store',
    --         color = 9,
    --         sprite = 89,
    --         display = 4,
    --         scale = 0.8,
    --     },

    --     ['settings'] = {
    --         runtimer = 5,
    --         private_deliveries = false,
    --         name = 'Coffee Run',
    --         cooking = 'Press [E] to make coffe',
    --         packaging = 'Press [E] to package coffe',
    --         ready = "Press [E] to put bag out for delivery",
    --         cancle = "Press [E] to cancel delivery",
    --         food_item = 'coffee',
    --         bag_item = 'coffeebag',
    --         timedout = 'Your run just timed out!',

    --         made_items = "You made some coffees..",
    --         packed_items = "You packed few coffees..",
    --         not_enoght = "The customer wants more then 2 coffees lmao",
    --         preparing = "Preparing Delivery..",
    --         pickup = "Press [E] to deliver coffee.",
    --         dropoff = "Press [E] to drop off package.",
    --         shop = "Press [E] to open the shop",

    --         payment = {55, 125},
    --     },

    --     ['shopitems'] = {
    --         [1] = {
    --             name = "mshake",
    --             price = 6,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 1,
    --         },
    --         [2] = {
    --             name = "donut",
    --             price = 6,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 2,
    --         },
    --         [3] = {
    --             name = "waffle",
    --             price = 6,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 3,
    --         },
    --         [4] = {
    --             name = "frenchtoast",
    --             price = 6,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 4,
    --         },
    --         [5] = {
    --             name = "capuchino",
    --             price = 5,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 5,
    --         },
    --         [6] = {
    --             name = "frappuccino",
    --             price = 5,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 6,
    --         },
    --         [7] = {
    --             name = "latte",
    --             price = 5,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 7,
    --         },
    --         [8] = {
    --             name = "icecream",
    --             price = 5,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 8,
    --         },
    --         [9] = {
    --             name = "slushy",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 9,
    --         },
    --         [10] = {
    --             name = "greencow",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 10,
	-- 		},
    --         [11] = {
    --             name = "spirte",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 11,
	-- 		},
    --         [12] = {
    --             name = "cocacola",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 12,
	-- 		},
    --         [13] = {
    --             name = "water_bottle",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 13,
    --         }
    --     },

    --     ['locations'] = {
    --         shop = vector3(-631.7714, 228.0574, 81.881454),
    --         cook = vector3(-629.0986, 223.59492, 81.881462),
    --         packaging = vector3(-631.4879, 224.97268, 81.881462),
    --         ready = vector3(-635.0982, 235.70611, 81.88166),
    --         pickup = vector3(-627.6262, 236.96755, 81.881546),
    --         cancle = vector3(-639.3809, 237.85713, 81.881477),
    --     }
    -- },

    -- ['burgershot'] = {
    --     ['name'] = 'burgershot',

    --     ['blip'] = {
    --         coords = vector3(-1199.911, -900.4355, 13.995184),
    --         name = 'Burger Shot',
    --         color = 23,
    --         sprite = 106,
    --         display = 4,
    --         scale = 0.7,
    --     },

    --     ['settings'] = {
    --         runtimer = 5,
    --         private_deliveries = false,
    --         name = 'Burgers run',
    --         cooking = 'Press [E] to make burger',
    --         packaging = 'Press [E] to package burgers',
    --         ready = "Press [E] to put bag out for delivery",
    --         cancle = "Press [E] to cancel delivery",
    --         food_item = 'burger',
    --         bag_item = 'burger-bag',
    --         timedout = 'Your run just timed out!',

    --         made_items = "You made some burgers..",
    --         packed_items = "You packed few burgers..",
    --         not_enoght = "The customer wants more then 2 burgers lmao",
    --         preparing = "Preparing Delivery..",
    --         pickup = "Press [E] to deliver burgers.",
    --         dropoff = "Press [E] to drop off package.",
    --         shop = "Press [E] to open the shop",

    --         payment = {40, 100},
    --     },

    --     ['shopitems'] = {
    --         [1] = {
    --             name = "fowlburger",
    --             price = 10,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 1,
    --         },
    --         [2] = {
    --             name = "meatfree",
    --             price = 10,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 2,
    --         },
    --         [3] = {
    --             name = "heartstopper",
    --             price = 10,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 3,
    --         },
    --         [4] = {
    --             name = "bleederburger",
    --             price = 10,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 4,
    --         },
    --         [5] = {
    --             name = "hotdog",
    --             price = 10,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 5,
    --         },
    --         [6] = {
    --             name = "fries",
    --             price = 7,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 6,
    --         },
    --         [7] = {
    --             name = "wings",
    --             price = 7,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 7,
    --         },
    --         [8] = {
    --             name = "beer",
    --             price = 5,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 8,
    --         },
    --         [9] = {
    --             name = "slushy",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 9,
    --         },
    --         [10] = {
    --             name = "greencow",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 10,
    --         },
    --         [11] = {
    --             name = "spirte",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 11,
    --         },
    --         [12] = {
    --             name = "cocacola",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 12,
    --         },
    --         [13] = {
    --             name = "water_bottle",
    --             price = 3,
    --             amount = 5,
    --             info = {},
    --             type = "item",
    --             slot = 13,
    --         }
    --     },

    --     ['locations'] = {
    --         shop = vector3(-1202.355, -896.8234, 13.995201),
    --         cook = vector3(-1199.911, -900.4355, 13.995184),
    --         packaging = vector3(-1198.007, -896.9661, 13.995203),
    --         ready = vector3(-1194.432, -894.8151, 13.995185),
    --         pickup = vector3(-1192.339, -895.3156, 13.995203),
    --         cancle = vector3(-1190.531, -896.4488, 13.995198),
    --     }
    -- }
}

Config.DropOff = {
    Name = "Drop Off",
    Sprite = 514,
    Color = 4,
    Scale = 1.0,
}

Config.DropOffLocations = {
    ['taco'] = {
        [1] =  { ['x'] = -148.69,['y'] = -1687.35,['z'] = 36.17},
        [2] =  { ['x'] = -157.54,['y'] = -1679.61,['z'] = 36.97},
        [3] =  { ['x'] = -158.86,['y'] = -1680.02,['z'] = 36.97},
        [4] =  { ['x'] = -160.83,['y'] = -1637.93,['z'] = 34.03},
        [5] =  { ['x'] = -160.0,['y'] = -1636.41,['z'] = 34.03},
        [6] =  { ['x'] = -153.87,['y'] = -1641.77,['z'] = 36.86},
        [7] =  { ['x'] = -159.85,['y'] = -1636.42,['z'] = 37.25},
        [8] =  { ['x'] = -161.31,['y'] = -1638.13,['z'] = 37.25},
        [9] =  { ['x'] = -150.79,['y'] = -1625.26,['z'] = 33.66},
        [10] =  { ['x'] = -150.74,['y'] = -1622.68,['z'] = 33.66},
        [11] =  { ['x'] = -145.59,['y'] = -1617.88,['z'] = 36.05},
        [12] =  { ['x'] = -145.84,['y'] = -1614.71,['z'] = 36.05},
        [13] =  { ['x'] = -152.23,['y'] = -1624.37,['z'] = 36.85},
        [14] =  { ['x'] = -150.38,['y'] = -1625.5,['z'] = 36.85},
        [15] =  { ['x'] = -120.58,['y'] = -1575.04,['z'] = 34.18},
        [16] =  { ['x'] = -114.73,['y'] = -1579.95,['z'] = 34.18},
        [17] =  { ['x'] = -119.6,['y'] = -1585.41,['z'] = 34.22},
        [18] =  { ['x'] = -123.81,['y'] = -1590.67,['z'] = 34.21},
        [19] =  { ['x'] = -139.85,['y'] = -1598.7,['z'] = 34.84},
        [20] =  { ['x'] = -146.85,['y'] = -1596.64,['z'] = 34.84},
        [21] =  { ['x'] = -139.49,['y'] = -1588.39,['z'] = 34.25},
        [22] =  { ['x'] = -133.47,['y'] = -1581.2,['z'] = 34.21},
        [23] =  { ['x'] = -120.63,['y'] = -1575.05,['z'] = 37.41},
        [24] =  { ['x'] = -114.71,['y'] = -1580.4,['z'] = 37.41},
        [25] =  { ['x'] = -119.53,['y'] = -1585.26,['z'] = 37.41},
        [26] =  { ['x'] = -123.67,['y'] = -1590.39,['z'] = 37.41},
        [27] =  { ['x'] = -140.08,['y'] = -1598.75,['z'] = 38.22},
        [28] =  { ['x'] = -145.81,['y'] = -1597.55,['z'] = 38.22},
        [29] =  { ['x'] = -147.47,['y'] = -1596.26,['z'] = 38.22},
        [30] =  { ['x'] = -139.77,['y'] = -1587.8,['z'] = 37.41},
        [31] =  { ['x'] = -133.78,['y'] = -1580.56,['z'] = 37.41},
        [32] =  { ['x'] = -157.6,['y'] = -1680.11,['z'] = 33.44},
        [33] =  { ['x'] = -148.39,['y'] = -1688.04,['z'] = 32.88},
        [34] =  { ['x'] = -147.3,['y'] = -1688.99,['z'] = 32.88},
        [35] =  { ['x'] = -143.08,['y'] = -1692.38,['z'] = 32.88},
        [36] =  { ['x'] = -141.89,['y'] = -1693.43,['z'] = 32.88},
        [37] =  { ['x'] = -167.71,['y'] = -1534.71,['z'] = 35.1},
        [38] =  { ['x'] = -180.71,['y'] = -1553.51,['z'] = 35.13},
        [39] =  { ['x'] = -187.47,['y'] = -1562.96,['z'] = 35.76},
        [40] =  { ['x'] = -191.86,['y'] = -1559.4,['z'] = 34.96},
        [41] =  { ['x'] = -195.55,['y'] = -1556.06,['z'] = 34.96},
        [42] =  { ['x'] = -183.81,['y'] = -1540.59,['z'] = 34.36},
        [43] =  { ['x'] = -179.69,['y'] = -1534.66,['z'] = 34.36},
        [44] =  { ['x'] = -175.06,['y'] = -1529.53,['z'] = 34.36},
        [45] =  { ['x'] = -167.62,['y'] = -1534.9,['z'] = 38.33},
        [46] =  { ['x'] = -180.19,['y'] = -1553.89,['z'] = 38.34},
        [47] =  { ['x'] = -186.63,['y'] = -1562.32,['z'] = 39.14},
        [48] =  { ['x'] = -188.32,['y'] = -1562.5,['z'] = 39.14},
        [49] =  { ['x'] = -192.14,['y'] = -1559.64,['z'] = 38.34},
        [50] =  { ['x'] = -195.77,['y'] = -1555.92,['z'] = 38.34},
        [51] =  { ['x'] = -184.06,['y'] = -1539.83,['z'] = 37.54},
        [52] =  { ['x'] = -179.58,['y'] = -1534.93,['z'] = 37.54},
        [53] =  { ['x'] = -174.87,['y'] = -1529.18,['z'] = 37.54},
        [54] =  { ['x'] = -208.75,['y'] = -1600.32,['z'] = 34.87},
        [55] =  { ['x'] = -210.05,['y'] = -1607.17,['z'] = 34.87},
        [56] =  { ['x'] = -212.05,['y'] = -1616.86,['z'] = 34.87},
        [57] =  { ['x'] = -213.8,['y'] = -1618.07,['z'] = 34.87},
        [58] =  { ['x'] = -221.82,['y'] = -1617.45,['z'] = 34.87},
        [59] =  { ['x'] = -223.06,['y'] = -1601.38,['z'] = 34.89},
        [60] =  { ['x'] = -222.52,['y'] = -1585.71,['z'] = 34.87},
        [61] =  { ['x'] = -218.91,['y'] = -1580.06,['z'] = 34.87},
        [62] =  { ['x'] = -216.48,['y'] = -1577.45,['z'] = 34.87},
        [63] =  { ['x'] = -206.23,['y'] = -1585.55,['z'] = 34.87},
        [64] =  { ['x'] = -206.63,['y'] = -1585.8, ['z'] = 38.06},
        [65] =  { ['x'] = -216.05,['y'] = -1576.86,['z'] = 38.06},
        [66] =  { ['x'] = -218.37,['y'] = -1579.89,['z'] = 38.06},
        [67] =  { ['x'] = -222.25,['y'] = -1585.37,['z'] = 38.06},
        [68] =  { ['x'] = -222.26,['y'] = -1600.93,['z'] = 38.06},
        [69] =  { ['x'] = -222.21,['y'] = -1617.39,['z'] = 38.06},
        [70] =  { ['x'] = -214.12,['y'] = -1617.62,['z'] = 38.06},
        [71] =  { ['x'] = -212.29,['y'] = -1617.34,['z'] = 38.06},
        [72] =  { ['x'] = -210.46,['y'] = -1607.36,['z'] = 38.05},
        [73] =  { ['x'] = -209.45,['y'] = -1600.57,['z'] = 38.05},
        [74] =  { ['x'] = -216.64,['y'] = -1673.73,['z'] = 34.47},
        [75] =  { ['x'] = -224.15,['y'] = -1673.67,['z'] = 34.47},
        [76] =  { ['x'] = -224.17,['y'] = -1666.14,['z'] = 34.47},
        [77] =  { ['x'] = -224.32,['y'] = -1649.0,['z'] = 34.86},
        [78] =  { ['x'] = -216.34,['y'] = -1648.94,['z'] = 34.47},
        [79] =  { ['x'] = -212.92,['y'] = -1660.54,['z'] = 34.47},
        [80] =  { ['x'] = -212.95,['y'] = -1667.96,['z'] = 34.47},
        [81] =  { ['x'] = -216.55,['y'] = -1673.88,['z'] = 37.64},
        [82] =  { ['x'] = -224.34,['y'] = -1673.79,['z'] = 37.64},
        [83] =  { ['x'] = -223.99,['y'] = -1666.29,['z'] = 37.64},
        [84] =  { ['x'] = -224.44,['y'] = -1653.99,['z'] = 37.64},
        [85] =  { ['x'] = -223.96,['y'] = -1649.16,['z'] = 38.45},
        [86] =  { ['x'] = -216.44,['y'] = -1649.13,['z'] = 37.64},
        [87] =  { ['x'] = -212.85,['y'] = -1660.74,['z'] = 37.64},
        [88] =  { ['x'] = -212.72,['y'] = -1668.23,['z'] = 37.64},
        [89] =  { ['x'] = -141.79,['y'] = -1693.55,['z'] = 36.17},
        [90] =  { ['x'] = -142.19,['y'] = -1692.69,['z'] = 36.17},
        [91] =  { ['x'] = -147.39,['y'] = -1688.39,['z'] = 36.17},
        [92] =  { ['x'] = 179.94,['y'] = -1831.79,['z'] = 28.12},
        [93] =  { ['x'] = 212.34,['y'] = -1856.49,['z'] = 27.2},
        [94] =  { ['x'] = 174.48,['y'] = -2025.75,['z'] = 18.34},
        [95] =  { ['x'] = 409.69,['y'] = -1910.84,['z'] = 25.46},
        [96] =  { ['x'] = 450.73,['y'] = -1862.38,['z'] = 27.8},
        [97] =  { ['x'] = 482.94,['y'] = -1685.85,['z'] = 29.3},
        [98] =  { ['x'] = 225.16,['y'] = -1511.8,['z'] = 29.3},
        [99] =  { ['x'] = 168.77,['y'] = -1633.48,['z'] = 29.3},
        [100] =  { ['x'] = 161.63,['y'] = -1485.4,['z'] = 29.15},
        [101] =  { ['x'] = 83.58,['y'] = -1551.61,['z'] = 29.6},
        [102] =  { ['x'] = 95.02,['y'] = -1810.52,['z'] = 27.09},
        [103] =  { ['x'] = -297.78,['y'] = -1332.4,['z'] = 31.3},
        [104] =  { ['x'] = -1.58,['y'] = -1400.38,['z'] = 29.28},
        [105] =  { ['x'] = -10.81,['y'] = -1828.68,['z'] = 25.4},
    },

    ['coffee'] = {
        [1] =  { ['x'] = -613.2788,['y'] = 323.81179,['z'] = 82.261268},
        [2] =  { ['x'] = -742.789,['y'] = 247.28901,['z'] =77.332794},
        [3] =  { ['x'] = -819.3536,['y'] = 268.01205,['z'] = 86.395942},
        [4] =  { ['x'] = -877.4011,['y'] = 306.41491,['z'] = 84.154304},
        [5] =  { ['x'] = -842.7734,['y'] = 466.92758,['z'] = 87.601287},
        [6] =  { ['x'] = -850.4257,['y'] = 522.36022,['z'] = 90.622322},
        [7] =  { ['x'] = -907.7296,['y'] = 544.99822,['z'] = 100.40779},
        [8] =  { ['x'] = -761.8388,['y'] = 431.52124,['z'] = 100.19976},
        [9] =  { ['x'] = -622.8532,['y'] = 488.86599,['z'] = 108.87752},
        [10] =  { ['x'] = -207.0818,['y'] = 163.44096,['z'] = 74.05313},
        [11] =  { ['x'] = -476.8085,['y'] = 217.54107,['z'] = 83.702545},
        [12] =  { ['x'] = -207.4753,['y'] = 159.42839,['z'] = 74.053131},
        [13] =  { ['x'] = -655.0702, ['y'] = -414.2643, ['z'] = 35.479915 },
        [14] =  { ['x'] = -385.2475, ['y'] = 270.15991, ['z'] = 86.367485 },
        [15] =  { ['x'] = -413.9096, ['y'] = 220.52507, ['z'] = 83.427467 },
        [16] =  { ['x'] = -419.5444, ['y'] = 221.21493, ['z'] = 83.395278 },
        [17] =  { ['x'] = -394.2344, ['y'] = 208.50917, ['z'] = 83.632904 },
        [18] =  { ['x'] = -242.0425, ['y'] = 279.85229, ['z'] = 92.039863 },
        [19] =  { ['x'] = -178.7237, ['y'] = 314.27059, ['z'] = 97.964214 },
        [20] = { ['x'] = -92.77323, ['y'] = 233.14714, ['z'] = 100.58019 },
        [21] = { ['x'] = -40.53652, ['y'] = 227.85008, ['z'] = 107.96794 },
        [22] =  { ['x'] = 81.467658, ['y'] = 275.05633, ['z'] = 110.21013 },
        [23] =  { ['x'] = -60.9231, ['y'] = 360.48562, ['z'] = 113.05636 },
        [24] =  { ['x'] = -102.9935, ['y'] = 397.4869, ['z'] = 112.65986 },
        [25] =  { ['x'] = -54.15459, ['y'] = 374.72796, ['z'] = 112.43081 },
        [26] =  { ['x'] = -72.9051, ['y'] = 428.51367, ['z'] = 113.03815 },
        [27] =  { ['x'] = -6.494105, ['y'] = 409.04806, ['z'] = 120.2888 },
        [28] =  { ['x'] = 22.056957, ['y'] = 173.87936, ['z'] = 101.11345 },
        [29] =  { ['x'] = -37.57359, ['y'] = 170.36849, ['z'] = 95.359237 },
        [30] =  { ['x'] = 17.745203, ['y'] = -13.83824, ['z'] = 70.310768 },
        [31] =  { ['x'] = 101.53557, ['y'] = -222.4989, ['z'] = 54.636135 },
    },

    ['burgershot'] = {
        [1] =  { ['x'] = -613.2788,['y'] = 323.81179,['z'] = 82.261268},
        [2] =  { ['x'] = -742.789,['y'] = 247.28901,['z'] =77.332794},
        [3] =  { ['x'] = -819.3536,['y'] = 268.01205,['z'] = 86.395942},
        [4] =  { ['x'] = -877.4011,['y'] = 306.41491,['z'] = 84.154304},
        [5] =  { ['x'] = -842.7734,['y'] = 466.92758,['z'] = 87.601287},
        [6] =  { ['x'] = -850.4257,['y'] = 522.36022,['z'] = 90.622322},
        [7] =  { ['x'] = -907.7296,['y'] = 544.99822,['z'] = 100.40779},
        [8] =  { ['x'] = -761.8388,['y'] = 431.52124,['z'] = 100.19976},
        [9] =  { ['x'] = -622.8532,['y'] = 488.86599,['z'] = 108.87752},
        [10] =  { ['x'] = -207.0818,['y'] = 163.44096,['z'] = 74.05313},
        [11] =  { ['x'] = -476.8085,['y'] = 217.54107,['z'] = 83.702545},
        [12] =  { ['x'] = -207.4753,['y'] = 159.42839,['z'] = 74.053131},
        [13] =  { ['x'] = -655.0702, ['y'] = -414.2643, ['z'] = 35.479915 },
        [14] =  { ['x'] = -385.2475, ['y'] = 270.15991, ['z'] = 86.367485 },
        [15] =  { ['x'] = -413.9096, ['y'] = 220.52507, ['z'] = 83.427467 },
        [16] =  { ['x'] = -419.5444, ['y'] = 221.21493, ['z'] = 83.395278 },
        [17] =  { ['x'] = -394.2344, ['y'] = 208.50917, ['z'] = 83.632904 },
        [18] =  { ['x'] = -242.0425, ['y'] = 279.85229, ['z'] = 92.039863 },
        [19] =  { ['x'] = -178.7237, ['y'] = 314.27059, ['z'] = 97.964214 },
        [20] = { ['x'] = -92.77323, ['y'] = 233.14714, ['z'] = 100.58019 },
        [21] = { ['x'] = -40.53652, ['y'] = 227.85008, ['z'] = 107.96794 },
        [22] =  { ['x'] = 81.467658, ['y'] = 275.05633, ['z'] = 110.21013 },
        [23] =  { ['x'] = -60.9231, ['y'] = 360.48562, ['z'] = 113.05636 },
        [24] =  { ['x'] = -102.9935, ['y'] = 397.4869, ['z'] = 112.65986 },
        [25] =  { ['x'] = -54.15459, ['y'] = 374.72796, ['z'] = 112.43081 },
        [26] =  { ['x'] = -72.9051, ['y'] = 428.51367, ['z'] = 113.03815 },
        [27] =  { ['x'] = -6.494105, ['y'] = 409.04806, ['z'] = 120.2888 },
        [28] =  { ['x'] = 22.056957, ['y'] = 173.87936, ['z'] = 101.11345 },
        [29] =  { ['x'] = -37.57359, ['y'] = 170.36849, ['z'] = 95.359237 },
        [30] =  { ['x'] = 17.745203, ['y'] = -13.83824, ['z'] = 70.310768 },
        [31] =  { ['x'] = 101.53557, ['y'] = -222.4989, ['z'] = 54.636135 },
    }
}
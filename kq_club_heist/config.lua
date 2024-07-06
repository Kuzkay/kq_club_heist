Config = {}

Config.debug = false


-------------------------------------------------
--- DEPENDENCY SETTINGS
-------------------------------------------------

--- KuzQuality Advanced Ped Looting
--- https://kuzquality.com/package/6224025
--- When the script is installed. The access-card will be dropped by the security guard instead of found
--- randomly in the club.
Config.useAdvancedPedLooting = true

--- KuzQuality Security Systems
--- https://kuzquality.com/package/6271745
--- When enabled. An additional hackable panel will be added as well as additional lasers to access the
--- high loot area.
--- Lasers make players ragdoll, deal tiny amount of damage and alert the police
--- The lasers will also be moving and an audible alarm upon triggering the lasers will sound
Config.useSecuritySystems = true

--- KuzQuality Lasers (FREE!)
--- https://kuzquality.com/package/6344519
--- When enabled. Lasers will be enabled. Lasers make players ragdoll, deal tiny amount of damage and alert the police
Config.useLasers = true


-------------------------------------------------
--- FRAMEWORK SETTINGS
-------------------------------------------------
Config.esxSettings = {
    enabled = true,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,
}

Config.qbSettings = {
    enabled = false,
}

Config.textScale = 1.0

Config.dispatch = {
    title = 'Intruders at the Paradise Nightclub!',
    message = 'A security laser at the Paradise Nightclub has been tripped. Investigate it',
    hackingMessage = 'Tinkering with an alarm system at the Paradise night club has been detected. Investigate it',
    jobs = { 'police', 'lspd' },
}

Config.starter = {
    location = vector3(-563.10, 281.0, 85.35),
    prop = 'prop_notepad_02',
    respawnTime = 60, -- time in minutes

    doorOpenTime = 20, -- time in minutes
}


--- IMPORTANT!
---
--- Make sure to modify all the item names to items which exist on your server!
--- Alternatively add new items to your server based on the items in this config
Config.loot = {
    ---- SAFE
    {
        label = 'safe',
        coords = vector3(655.52, 143.96, -65.39),

        item = {
            name = 'expensive_crystals',
            min = 3,
            max = 6,
        },

        model = 'hei_prop_heist_deposit_box',
        amount = 1,
        radius = 0.01,
        chance = 100,

        requiredItems = {
            items = { 'kq_club_keys' },
            errorMessage = 'You need the safe keys to take this',
            takeItem = true,
        }
    },

    ---- MONEY SMALL
    {
        label = 'bills',
        coords = vector3(671.96, 148.81, -70.0),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(10, 20),
        radius = 2.5,
        chance = 70,
    },
    {
        label = 'bills',
        coords = vector3(662.24, 149.80, -66.20),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(5, 10),
        radius = 0.3,
        chance = 70,
    },
    {
        label = 'bills',
        coords = vector3(651.03, 141.82, -66.2),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(4, 5),
        radius = 0.4,
        chance = 60,
    },
    {
        label = 'bills',
        coords = vector3(686.37, 146.54, -67.0),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(6, 7),
        radius = 0.5,
        chance = 50,
    },
    {
        label = 'bills',
        coords = vector3(675.26, 159.90, -66.80),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(2, 3),
        radius = 0.5,
        chance = 50,
    },
    {
        label = 'bills',
        coords = vector3(644.06, 156.95, -69.14),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(8, 14),
        radius = 0.8,
        chance = 80,
    },
    {
        label = 'bills',
        coords = vector3(644.91, 156.72, -69.14),

        item = {
            name = 'black_money',
            min = 50,
            max = 50,
        },

        model = 'prop_anim_cash_pile_01',
        amount = math.random(5, 7),
        radius = 0.3,
        chance = 80,
    },

    ---- MONEY MEDIUM
    {
        label = 'rolled up bills',
        coords = vector3(655.42, 140.90, -65.5),

        item = {
            name = 'black_money',
            min = 100,
            max = 400,
        },

        model = 'bkr_prop_bkr_cash_roll_01',
        amount = math.random(1, 2),
        radius = 0.2,
        chance = 70,
    },
    {
        label = 'rolled up bills',
        coords = vector3(652.45, 147.21, -65.40),

        item = {
            name = 'black_money',
            min = 100,
            max = 400,
        },

        model = 'bkr_prop_bkr_cash_roll_01',
        amount = 1,
        radius = 0.2,
        chance = 100,
    },
    {
        label = 'rolled up bills',
        coords = vector3(652.41, 151.77, -65.40),

        item = {
            name = 'black_money',
            min = 100,
            max = 400,
        },

        model = 'bkr_prop_bkr_cash_roll_01',
        amount = 1,
        radius = 0.2,
        chance = 100,
    },

    ---- MONEY BIG
    {
        label = 'packaged money',
        coords = vector3(631.50, 160.54, -69.14),

        item = {
            name = 'black_money',
            min = 5000,
            max = 10000,
        },

        model = 'bkr_prop_bkr_cashpile_04',
        amount = 1,
        radius = 0.7,
        chance = 100,
    },
    {
        label = 'packaged money',
        coords = vector3(650.53, 165.36, -68.84),

        item = {
            name = 'black_money',
            min = 3000,
            max = 6000,
        },

        model = 'bkr_prop_moneypack_03a',
        amount = 1,
        radius = 0.1,
        chance = 60,
    },
    {
        label = 'packaged money',
        coords = vector3(643.93, 153.13, -68.70),

        item = {
            name = 'black_money',
            min = 3000,
            max = 6000,
        },

        model = 'bkr_prop_moneypack_03a',
        amount = 1,
        radius = 0.1,
        chance = 100,
    },

    ---- COKE
    {
        label = 'drugs',
        coords = vector3(661.07, 143.51, -65.24),
        rotation = vector3(90.0, 0.0, math.random(0, 360)),
        item = {
            name = 'coke',
            min = 1,
            max = 1,
        },

        model = 'xm3_prop_xm3_bag_coke_01a',
        amount = math.random(1, 2),
        radius = 0.3,
        chance = 60,
    },
    {
        label = 'drugs',
        coords = vector3(661.28, 142.96, -70.00),
        rotation = vector3(90.0, 0.0, math.random(0, 360)),
        item = {
            name = 'coke',
            min = 1,
            max = 1,
        },

        model = 'xm3_prop_xm3_bag_coke_01a',
        amount = 1,
        radius = 0.3,
        chance = 60,
    },
    {
        label = 'drugs',
        coords = vector3(670.36, 159.99, -66.80),
        rotation = vector3(90.0, 0.0, math.random(0, 360)),
        item = {
            name = 'coke',
            min = 1,
            max = 1,
        },

        model = 'xm3_prop_xm3_bag_coke_01a',
        amount = math.random(1, 2),
        radius = 0.3,
        chance = 80,
    },

    ---- XTC
    {
        label = 'drugs',
        coords = vector3(664.57, 150.24, -68.79),
        item = {
            name = 'xtc',
            min = 1,
            max = 1,
        },

        model = 'ex_office_swag_pills1',
        amount = math.random(1, 2),
        radius = 0.4,
        chance = 80,
    },
    {
        label = 'drugs',
        coords = vector3(659.42, 153.61, -70.0),
        item = {
            name = 'xtc',
            min = 1,
            max = 1,
        },

        model = 'ex_office_swag_pills1',
        amount = math.random(1, 2),
        radius = 0.4,
        chance = 80,
    },
    {
        label = 'drugs',
        coords = vector3(660.74, 161.78, -68.88),
        item = {
            name = 'xtc',
            min = 1,
            max = 1,
        },

        model = 'ex_office_swag_pills1',
        amount = math.random(1, 2),
        radius = 0.2,
        chance = 80,
    },
    {
        label = 'drugs',
        coords = vector3(660.78, 161.10, -68.88),
        item = {
            name = 'xtc',
            min = 1,
            max = 1,
        },

        model = 'ex_office_swag_pills1',
        amount = math.random(1, 2),
        radius = 0.2,
        chance = 80,
    },

    ---- WEED
    {
        label = 'weed',
        coords = vector3(688.62, 155.11, -67.00),
        item = {
            name = 'weed',
            min = 1,
            max = 1,
        },

        model = 'prop_weed_block_01',
        amount = math.random(5, 7),
        radius = 0.6,
        chance = 40,
    },
    {
        label = 'weed',
        coords = vector3(694.32, 144.56, -70.0),
        item = {
            name = 'weed',
            min = 1,
            max = 1,
        },

        model = 'prop_weed_block_01',
        amount = math.random(3, 4),
        radius = 0.6,
        chance = 40,
    },
    {
        label = 'weed',
        coords = vector3(688.14, 156.21, -67.00),
        item = {
            name = 'weed',
            min = 2,
            max = 2,
        },

        model = 'hei_prop_heist_weed_block_01b',
        amount = math.random(2, 3),
        radius = 0.6,
        chance = 80,
    },
}

Config.controller = {
    coords = vector3(657.07, 150.09, -64.9),
    rotation = vector3(0.0, 0.0, 270.0),
    lasersHackDuration = 60, -- duration for which the lasers will be turned off upon hacking

    -- List of items which can be used to hack the controller
    hackingItems = {
        'kq_hacker_usb',
    }
}

Config.alarms = {
    ['main'] = {
        coords = vector3(673.25, 142.51, -66.1),
        rotation = vector3(0.0, 0.0, 180.0),
        duration = 120,

        sound = true,

        light = {
            rgb = { 200, 0, 0 },
            range = 25.0,
            intensity = 1.0,
        }
    },
    ['back'] = {
        coords = vector3(647.68, 145.07, -62.31),
        rotation = vector3(90.0, 0.0, 0.0),
        duration = 120,

        sound = true,

        light = {
            rgb = { 200, 0, 0 },
            range = 15.0,
            intensity = 1.0,
        }
    }
}

Config.lasersExtra = {
    -- Whether the lasers should notify the police when crossed
    alertDispatch = true,

    -- Whether the lasers should make players ragdoll (fall over) when touched
    forceRagdoll = false,

    -- Set to 0 if you want lasers to not deal any damage to the players
    damage = 5
}

Config.lasers = {
    ['kq_club_heist_laser_0'] = {
        origin = vector3(695.09, 151.13, -68.44),
        endPoint = vector3(691.90, 151.70, -68.44),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 5.0,
    },
    ['kq_club_heist_laser_1'] = {
        origin = vector3(652.09, 149.42, -61.52),
        endPointA = vector3(655.78, 146.20, -66.20),
        endPointB = vector3(648.70, 152.95, -66.20),

        color = { r = 0, g = 255, b = 21, a = 200 },

        speed = 0.8,
        maxLength = 9.0,
    },
    ['kq_club_heist_laser_2'] = {
        origin = vector3(655.20, 145.58, -63.39),
        endPointA = vector3(654.92, 153.83, -64.88),
        endPointB = vector3(647.41, 150.84, -64.88),

        color = { r = 0, g = 255, b = 21, a = 200 },

        speed = 0.8,
        maxLength = 14.0,
    },
    ['kq_club_heist_laser_3'] = {
        origin = vector3(654.92, 145.37, -66.02),
        endPoint = vector3(653.77, 147.28, -66.02),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 3.0,
    },
    ['kq_club_heist_laser_door_1'] = {
        origin = vector3(657.31, 149.50, -64.2),
        endPoint = vector3(656.28, 146.34, -64.2),

        color = { r = 200, g = 20, b = 20, a = 180 },

        maxLength = 4.0,

        securityOnly = true,
    },
    ['kq_club_heist_laser_door_2'] = {
        origin = vector3(657.31, 149.50, -64.7),
        endPoint = vector3(656.28, 146.34, -64.7),

        color = { r = 200, g = 20, b = 20, a = 180 },

        maxLength = 4.0,

        securityOnly = true,
    },
    ['kq_club_heist_laser_door_3'] = {
        origin = vector3(657.31, 149.50, -65.2),
        endPoint = vector3(656.28, 146.34, -65.2),

        color = { r = 200, g = 20, b = 20, a = 180 },

        maxLength = 4.0,

        securityOnly = true,
    },
    ['kq_club_heist_laser_door_4'] = {
        origin = vector3(657.31, 149.50, -65.7),
        endPoint = vector3(656.28, 146.34, -65.8),

        color = { r = 200, g = 20, b = 20, a = 180 },

        maxLength = 4.0,

        securityOnly = true,
    },
    ['kq_club_heist_laser_main_1'] = {
        origin = vector3(673.24, 142.51, -69.7),
        endPoint = vector3(673.29, 153.66, -69.8),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 12.0,
    },
    ['kq_club_heist_laser_main_2'] = {
        origin = vector3(663.54, 156.90, -68.37),
        endPoint = vector3(663.59, 154.31, -68.37),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 5.0,
    },
    ['kq_club_heist_laser_main_3'] = {
        origin = vector3(678.27, 153.60, -67.20),
        endPointA = vector3(678.41, 149.26, -70.0),
        endPointB = vector3(678.74, 144.87, -70.0),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 12.0,
    },
    ['kq_club_heist_laser_main_4'] = {
        origin = vector3(668.69, 142.51, -67.79),
        endPointA = vector3(667.43, 145.98, -70.0),
        endPointB = vector3(672.85, 142.60, -70.0),

        color = { r = 0, g = 255, b = 21, a = 200 },

        speed = 0.25,

        maxLength = 10.0,
    },
    ['kq_club_heist_laser_top_1'] = {
        origin = vector3(682.50, 150.88, -66.21),
        endPoint = vector3(682.48, 146.89, -66.21),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 5.0,
    },
    ['kq_club_heist_laser_top_2'] = {
        origin = vector3(673.28, 156.90, -65.87),
        endPoint = vector3(673.38, 154.12, -65.87),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 8.0,
    },
    ['kq_club_heist_laser_top_3'] = {
        origin = vector3(683.70, 156.90, -65.62),
        endPoint = vector3(684.06, 155.15, -67.0),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 8.0,
    },
    ['kq_club_heist_laser_back_1'] = {
        origin = vector3(638.90, 146.83, -65.9),
        endPoint = vector3(635.93, 146.93, -65.9),

        color = { r = 0, g = 255, b = 21, a = 200 },

        maxLength = 4.0,
    },
    ['kq_club_heist_laser_back_2'] = {
        origin = vector3(652.50, 165.90, -66.47),
        endPointA = vector3(653.25, 163.57, -69.7),
        endPointB = vector3(653.94, 162.04, -66.6),

        color = { r = 0, g = 255, b = 21, a = 200 },

        speed = 0.5,
        maxLength = 7.0,
    },
    ['kq_club_heist_laser_back_3'] = {
        origin = vector3(657.63, 164.36, -67.58),
        endPointA = vector3(657.68, 162.59, -67.55),
        endPointB = vector3(657.67, 162.59, -68.93),

        color = { r = 0, g = 255, b = 21, a = 200 },

        speed = 0.8,
        maxLength = 3.0,
    },
}

----------------------------------------------------------------------------------------------
--- KEYBINDS
----------------------------------------------------------------------------------------------
-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    trigger = {
        label = 'E',
        input = 38,
    },
}

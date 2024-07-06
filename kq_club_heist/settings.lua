Settings = {}

Settings.club = {
    exit = {
        coords = vector3(701.29, 144.50, -64.40),
        heading = 0.0,
    },
}

Settings.entrance = {
    coords = vector3(355.35, 302.2, 103.76),
    heading = 0.0,
}

Settings.teleports = {
    {
        entrance = vector3(701.29, 144.50, -64.40),
        exit = {
            coords = Settings.entrance.coords,
            heading = Settings.entrance.heading,
        },
        isExit = true,
        label = '~p~[~w~{KEYBIND}~p~]~w~ Exit the club',
    },
    {
        entrance = vector3(626.0, 171.38, -66.81),
        exit = {
            coords = vector3(323.75, 268.5, 104.5),
            heading = 180.0,
        },
        isExit = true,
        label = '~p~[~w~{KEYBIND}~p~]~w~ Exit the club through the back entrance',
    },
    {
        entrance = vector3(652.11, 161.03, -68.14),
        exit = {
            coords = vector3(343.99, 289.44, 115.00),
            heading = 180.0,
        },
        isExit = true,
        label = '~p~[~w~{KEYBIND}~p~]~w~ Exit the club through the roof',
    }
}


Settings.safe = {
    keySpawnPoints = {
        vector3(670.55, 158.95, -65.83),
        vector3(651.89, 147.27, -65.40),
        vector3(658.11, 151.10, -69.11),
        vector3(666.91, 148.34, -67.97),
    }
}

Settings.security = {
    -- https://docs.fivem.net/docs/game-references/ped-models/
    ped = 'mp_m_securoguard_01',
    weapon = 'weapon_combatpistol',
    locations = {
        {
            coords = vector(683.59, 143.66, -69.0),
            heading = 0.0,
        },
        {
            coords = vector(683.0, 155.48, -69.0),
            heading = 190.0,
        },
        {
            coords = vector(684.34, 144.20, -66.0),
            heading = 70.0,
        },
    },
    -- Only used when Advanced Ped Looting is not enabled
    accessCardSpawnPoints = {
        vector3(664.66, 152.93, -69.45),
        vector3(684.98, 147.34, -69.03),
        vector3(679.96, 142.39, -66.02),
    },

    accessCardKeypad = {
        coords = vector3(663.42, 154.54, -64.84),
        rotation = vector3(0.0, 0.0, 90.0),
    }
}

Settings.doors = {
    ['connector_under'] = {
        id = 177701,
        hash = 390840000,
        coords = vector3(660.538, 156.612, -68.840),
        locked = true,
    },
    ['connector_top'] = {
        id = 177702,
        hash = -1555108147,
        coords = vector3(663.128, 156.151, -65.056),
        locked = true,

        accessCardUnlockable = true,
    },
    ['office_solid'] = {
        id = 177703,
        hash = 1695461688,
        coords = vector3(649.454, 141.709, -65.039),
        locked = true,
    },
    ['office_glass'] = {
        id = 177704,
        hash = -1119680854,
        coords = vector3(649.381, 145.200, -65.043),
        locked = false,
    }
}

Settings.props = {
    {
        model = 'm23_1_prop_m31_control_panel_01a',
        coords = Settings.security.accessCardKeypad.coords,
        rotation = Settings.security.accessCardKeypad.rotation,
    },
    {
        model = 'prop_worklight_02a',
        coords = vector3(647.10, 145.78, -66.19),
        rotation = vector3(0.0, 0.0, 350.0),
    },
    {
        model = 'tr_prop_tr_mule_ms_01a',
        coords = vector3(631.29, 152.51, -69.14),
        rotation = vector3(0.0, 0.0, 4.0),
    },
    {
        model = 'p_cs_locker_02',
        coords = vector3(660.80, 161.8, -68.90),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'p_cs_locker_02',
        coords = vector3(660.80, 161.1, -68.90),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'bkr_prop_prtmachine_dryer_spin',
        coords = vector3(646.06, 154.1, -69.3),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'bkr_prop_prtmachine_dryer_spin',
        coords = vector3(646.06, 155.45, -69.3),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'bkr_prop_prtmachine_dryer_op',
        coords = vector3(646.06, 156.8, -69.3),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'bkr_prop_prtmachine_dryer_spin',
        coords = vector3(646.06, 158.15, -69.3),
        rotation = vector3(0.0, 0.0, 270.0),
    },
    {
        model = 'bkr_prop_printmachine_4rollerp_st',
        coords = vector3(641.18, 156.15, -69.14),
        rotation = vector3(0.0, 0.0, 90.0),
    },
    {
        model = 'bkr_prop_weed_pallet',
        coords = vector3(643.95, 152.98, -69.14),
        rotation = vector3(0.0, 0.0, 45.0),
    },
    {
        model = 'bkr_prop_prtmachine_paperream',
        coords = vector3(643.95, 152.98, -68.89),
        rotation = vector3(0.0, 0.0, 12.0),
    },
}

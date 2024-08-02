Config = {}

Config.Casino = {
    Item = 'casinochips',
    Payment = 'bank', -- bank or cash
    ChipPrice    = 100,
    MemberCost = 500,
    VipCost  = 1000,
    AmbientNoise = true,
    Animated = {
        Walls = true,
        Normal = 'CASINO_DIA_PL',
        Win = 'CASINO_WIN_PL',
    },
}

Config.Vending = {
    {Items = 'water_bottle', Price = 3},
    {Items = 'coffee', Price = 5},
    {Items = 'beer', Price = 7},
}

Config.ShowCar = {
        Display = true,
    {
		model = 'roxanne',
        colors = {0, 0},
		extraColors = {0, 0},
		livery = -1,
		intColor = 1,
        neons = {100, 0, 255},
        XenonColor = 11,
        Tint = 1,
        ToggleLights = 2,
        modKits = {
            [0] = 7, -- SPOILER
            [1] = 18, -- BUMPER_F
            [2] = 9, -- BUMPER_R
            [3] = 5, -- SKIRT
            [4] = 9, -- EXHAUST
            [15] = 4, -- SUSPENSION
            [23] = 52, -- WHEELS
        },
    },
}

Config.CasinoInteractions = {
    Membership = {
        event = 'doj:casinoMembershipMenu',
        coords = vec3(920.726, 45.883, 71.073),
        size = vec3(5, 5, 5),
        text = 'Front Desk (Memberships)'
    },
    MembershipEntrance = {
        event = 'doj:casinoMembershipMenu',
        coords = vec3(932.1, 42.273, 81.089),
        size = vec3(3, 3, 3),
        text = 'Main Lobby (Memberships)'
    },
    CasinoShop = {
        event = 'doj:casinoCashierMenu',
        coords = vec3(948.591, 34.207, 71.839),
        size = vec3(5, 5, 5),
        text = 'Casino Shop'
    },
    LuckyWheel = {
        event = 'doj:casinoLuckyWheel',
        coords = vec3(949.059, 44.794, 71.638),
        size = vec3(3, 2, 3),
        text = 'Lucky Wheel'
    },
    InsideTrack = {
        event = 'doj:casinoInsideTrack',
        coords = vec3(955.619, 70.179, 70.433),
        size = vec3(5, 5, 5),
        text = 'InsideTrack'
    },
    Shop = {
        event = 'doj:casinoShopMenu',
        coords = vec3(936.591, 28.987, 71.834),
        size = vec3(3, 3, 3),
        text = 'Shop'
    },
}

Config.SecretGumball = {
    Enable = true,
    Machine = {
        Highlight = true,
        Price = 1000,-- in chips or cash
        Payment = 'cash',-- [items = both memberships & casino chips] or cash 
        RespawnAfterUse = 5,-- in seconds
    },
    MachineSpawns = {
        { x=934.634, y= 51.853,  z= 72.07},
        { x=955.508, y= 35.484,  z= 71.433},
        { x=946.592, y= 73.909,  z= 70.433},
        { x=998.055, y= 78.698,  z= 70.433},
        { x=1003.738, y= 37.685,  z= 70.433},
    },
    Loot = {
        Highlight = true,
        Timer = {
            Minutes = 1,
            Seconds = 30,
        },
        Skill = {
            Difficulty = {'medium', 'easy', 'easy', 'medium'},
            Inputs = {'e'},
        },
        Items = {'rolex','diamond','goldbar'},
        Amount = math.random(1,3),
        Spawn = {
            { Location = vector3(1235.49, -2267.833, -49.0), Heading = 88.905},
            { Location = vector3(1235.91, -2283.808, -49.0), Heading = 97.183},
        },
    },
}


-- Credit for elevators https://github.com/GouveiaXS/angelicxs-elevators
Config.Elevators = {
	DiamondCasino = {
		{
			position = vector3(965.0619, 58.51287, 112.553), heading = 176.67, level = 'Casino Roof', label = 'Go to highest floor',
		},
		{
			position = vector3(930.0716, 33.86854, 81.09772), heading = 176.67, level = 'Casino Main Lobby', label = 'Go ground level',
		},
        {
			position = vector3(931.131, 29.937, 81.156), heading = 176.67, level = 'Casino Garage', label = 'Go to lowest floor',
		},
	},
}





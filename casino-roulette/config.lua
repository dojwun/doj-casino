Config = {}
Config.TranslationSelected = 'en'

Config.Debug = false -- enable debug messages in sv/cl console
Config.TestTicker = nil -- need for testing the numbers, you can change the fix roulette tick by /rultick [1-38]

Config.allowCustomBet = false -- allow playes to enter a custom bet

Config.RouletteStart = 40 -- how many seconds to start the rulett after you sit down


Config.RulettTables = {
    -- you can implement tables easily or delete them.
    [0] = {
        position = vector3(1001.53, 56.479, 68.433), --Test Loc
        rot = 102.133,
        minBet = 10,
        maxBet = 1000 
    },
    [1] = {
        position = vector3(997.595, 55.573, 68.433),
        rot = 280.612,
        minBet = 10,
        maxBet = 1000
    },
    -- [3] = {
    --     position = vector3(984.6, 56.603, 70.238),
    --     rot = 162.406,
    --     minBet = 250,
    --     maxBet = 1000
    -- },
    -- [4] = {
    --     position = vector3(986.43, 48.482, 70.238),
    --     rot = 42.96,
    --     minBet = 250,
    --     maxBet = 1000
    -- },
    -- [5] = {
    --     position = vector3(982.953, 52.36, 70.238),
    --     rot = 103.648,
    --     minBet = 250,
    --     maxBet = 1000
    -- }
}

Config.ChairIds = {
    ['Chair_Base_01'] = 1,
    ['Chair_Base_02'] = 2,
    ['Chair_Base_03'] = 3,
    ['Chair_Base_04'] = 4
}

Config.rouletteSzamok = {
    [1] = '00',
    [2] = '27',
    [3] = '10',
    [4] = '25',
    [5] = '29',
    [6] = '12',
    [7] = '8',
    [8] = '19',
    [9] = '31',
    [10] = '18',
    [11] = '6',
    [12] = '21',
    [13] = '33',
    [14] = '16',
    [15] = '4',
    [16] = '23',
    [17] = '35',
    [18] = '14',
    [19] = '2',
    [20] = '0',
    [21] = '28',
    [22] = '9',
    [23] = '26',
    [24] = '30',
    [25] = '11',
    [26] = '7',
    [27] = '20',
    [28] = '32',
    [29] = '17',
    [30] = '5',
    [31] = '22',
    [32] = '34',
    [33] = '15',
    [34] = '3',
    [35] = '24',
    [36] = '36',
    [37] = '13',
    [38] = '1'
}

Config.DebugMsg = function(msg)
    if Config.Debug then
        print(msg)
    end
end

RULETT_NUMBERS = {}
RULETT_NUMBERS.Pirosak = {
    ['1'] = true,
    ['3'] = true,
    ['5'] = true,
    ['7'] = true,
    ['9'] = true,
    ['12'] = true,
    ['14'] = true,
    ['16'] = true,
    ['18'] = true,
    ['19'] = true,
    ['21'] = true,
    ['23'] = true,
    ['25'] = true,
    ['27'] = true,
    ['30'] = true,
    ['32'] = true,
    ['34'] = true,
    ['36'] = true
}
RULETT_NUMBERS.Feketek = {
    ['2'] = true,
    ['4'] = true,
    ['6'] = true,
    ['8'] = true,
    ['10'] = true,
    ['11'] = true,
    ['13'] = true,
    ['15'] = true,
    ['17'] = true,
    ['20'] = true,
    ['22'] = true,
    ['24'] = true,
    ['26'] = true,
    ['28'] = true,
    ['29'] = true,
    ['31'] = true,
    ['33'] = true,
    ['35'] = true
}
RULETT_NUMBERS.Parosak = {
    ['2'] = true,
    ['4'] = true,
    ['6'] = true,
    ['8'] = true,
    ['10'] = true,
    ['12'] = true,
    ['14'] = true,
    ['16'] = true,
    ['18'] = true,
    ['20'] = true,
    ['22'] = true,
    ['24'] = true,
    ['26'] = true,
    ['28'] = true,
    ['30'] = true,
    ['32'] = true,
    ['34'] = true,
    ['36'] = true
}
RULETT_NUMBERS.Paratlanok = {
    ['1'] = true,
    ['3'] = true,
    ['5'] = true,
    ['7'] = true,
    ['9'] = true,
    ['11'] = true,
    ['13'] = true,
    ['15'] = true,
    ['17'] = true,
    ['19'] = true,
    ['21'] = true,
    ['23'] = true,
    ['25'] = true,
    ['27'] = true,
    ['29'] = true,
    ['31'] = true,
    ['33'] = true,
    ['35'] = true
}
RULETT_NUMBERS.to18 = {
    ['1'] = true,
    ['2'] = true,
    ['3'] = true,
    ['4'] = true,
    ['5'] = true,
    ['6'] = true,
    ['7'] = true,
    ['8'] = true,
    ['9'] = true,
    ['10'] = true,
    ['11'] = true,
    ['12'] = true,
    ['13'] = true,
    ['14'] = true,
    ['15'] = true,
    ['16'] = true,
    ['17'] = true,
    ['18'] = true
}
RULETT_NUMBERS.to36 = {
    ['19'] = true,
    ['20'] = true,
    ['21'] = true,
    ['22'] = true,
    ['23'] = true,
    ['24'] = true,
    ['25'] = true,
    ['26'] = true,
    ['27'] = true,
    ['28'] = true,
    ['29'] = true,
    ['30'] = true,
    ['31'] = true,
    ['32'] = true,
    ['33'] = true,
    ['34'] = true,
    ['35'] = true,
    ['36'] = true
}
RULETT_NUMBERS.st12 = {
    ['1'] = true,
    ['2'] = true,
    ['3'] = true,
    ['4'] = true,
    ['5'] = true,
    ['6'] = true,
    ['7'] = true,
    ['8'] = true,
    ['9'] = true,
    ['10'] = true,
    ['11'] = true,
    ['12'] = true
}
RULETT_NUMBERS.sn12 = {
    ['13'] = true,
    ['14'] = true,
    ['15'] = true,
    ['16'] = true,
    ['17'] = true,
    ['18'] = true,
    ['19'] = true,
    ['20'] = true,
    ['21'] = true,
    ['22'] = true,
    ['23'] = true,
    ['24'] = true
}
RULETT_NUMBERS.rd12 = {
    ['25'] = true,
    ['26'] = true,
    ['27'] = true,
    ['28'] = true,
    ['29'] = true,
    ['30'] = true,
    ['31'] = true,
    ['32'] = true,
    ['33'] = true,
    ['34'] = true,
    ['35'] = true,
    ['36'] = true
}
RULETT_NUMBERS.ket_to_1 = {
    ['1'] = true,
    ['4'] = true,
    ['7'] = true,
    ['10'] = true,
    ['13'] = true,
    ['16'] = true,
    ['19'] = true,
    ['22'] = true,
    ['25'] = true,
    ['28'] = true,
    ['31'] = true,
    ['34'] = true
}
RULETT_NUMBERS.ket_to_2 = {
    ['2'] = true,
    ['5'] = true,
    ['8'] = true,
    ['11'] = true,
    ['14'] = true,
    ['17'] = true,
    ['20'] = true,
    ['23'] = true,
    ['26'] = true,
    ['29'] = true,
    ['32'] = true,
    ['35'] = true
}
RULETT_NUMBERS.ket_to_3 = {
    ['3'] = true,
    ['6'] = true,
    ['9'] = true,
    ['12'] = true,
    ['15'] = true,
    ['18'] = true,
    ['21'] = true,
    ['24'] = true,
    ['27'] = true,
    ['30'] = true,
    ['33'] = true,
    ['36'] = true
}

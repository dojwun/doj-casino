Config = {}

Config.PlayCasinoAmbientNoise = true
Config.SetShowCarOnDisplay = true
Config.VehicleOnDisplay = `xa21`
Config.CasinoEmployeePrompt  = 'walk-up' -- 'peek' or 'walk-up' ['walk-up' = walk up to open menu] ['peek' = uses qb-target to interact with employee]


Config.SetAnimatedWalls = true
Config.AnimatedWallNormal = 'CASINO_DIA_PL'
Config.AnimatedWallWin = 'CASINO_WIN_PL'
-- WALLS
-- CASINO_DIA_PL    - Falling Diamonds
-- CASINO_HLW_PL    - Falling Skulls
-- CASINO_SNWFLK_PL - Falling Snowflakes
-- CASINO_WIN_PL    - Falling Confetti

Config.SendWelcomeMail = true -- Sends a email to players phone on entering casino
Config.WelcomeMailsender = "The Diamond Casino"
Config.WelcomeMailsubject ="Welcome!"
Config.WelcomeMailmessage = "Welcome to The Diamond Casino, We are Open 24/7 & only accept Electronic Transactions"

Config.payment = "bank" -- or "cash" -- Payment player will recieve by selling casino chips

Config.whiteChipPrice   = 1
Config.redChipPrice     = 5
Config.blueChipPrice    = 10
Config.blackChipPrice   = 50
Config.goldChipPrice    = 100


Config.CasinoShop = {
    [1] = { name = "casino_whitechip",  price = 1,   amount = 999, info = {}, type = "item", slot = 1 },
    [2] = { name = "casino_redchip",    price = 5,   amount = 999, info = {}, type = "item", slot = 2 },
    [3] = { name = "casino_bluechip",   price = 10,  amount = 999, info = {}, type = "item", slot = 3 },
    [4] = { name = "casino_blackchip",  price = 50,  amount = 999, info = {}, type = "item", slot = 4 },
    [5] = { name = "casino_goldchip",   price = 100, amount = 999, info = {}, type = "item", slot = 5 },
    [6] = { name = "casino_member",     price = 500, amount = 199, info = {}, type = "item", slot = 6 },
    [7] = { name = "casino_vip",        price = 750, amount = 199, info = {}, type = "item", slot = 7 }
}   

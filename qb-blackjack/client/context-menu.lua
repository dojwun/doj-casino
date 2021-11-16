RegisterNetEvent('casino:context:hit&stand', function() 
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "doj:client:blackjackMenu",
                args = 1
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "doj:client:blackjackMenu",
                args = 2
            }
        },
    })
end)

RegisterNetEvent('casino:context:hit&doubledown', function() 
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "doj:client:blackjackMenu",
                args = 1
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "doj:client:blackjackMenu",
                args = 2
            }
        },
        {
            header = "Double Down", 
            txt = "Double your initial bet",
            params = {
                event = "doj:client:blackjackMenu",
                args = 3
            }
        },
    })
end)

RegisterNetEvent('casino:context:hit&split', function()
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "doj:client:blackjackMenu",
                args = 1
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "doj:client:blackjackMenu",
                args = 2
            }
        },
        {
            header = "Split", 
            txt = "Split",
            params = {
                event = "doj:client:blackjackMenu",
                args = 4
            }
        },
    })
end)

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
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
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
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
        {
            header = "Double Down", 
            txt = "Double your initial bet",
            params = {
                event = "BLACKJACK:client:double",
                args = {
                    
                }
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
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
        {
            header = "Split", 
            txt = "Split",
            params = {
                event = "BLACKJACK:client:split",
                args = {
                    
                }
            }
        },
    })
end)

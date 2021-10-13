RegisterNetEvent('casino:context:hit&stand', function() 
    print("hit casino menu") 

    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Diamond Casino Blackjack",
            txt = ""
        },
        {
            id = 2,
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            id = 3,
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
    print("hit & doubledown casino menu") 

    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Diamond Casino Blackjack",
            txt = ""
        },
        {
            id = 2,
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            id = 3,
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
        {
            id = 4,
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
    print("hit & split casino menu") 
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Diamond Casino Blackjack",
            txt = ""
        },
        {
            id = 2,
            header = "Hit", 
            txt = "Draw another card",
            params = {
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            id = 3,
            header = "Stand", 
            txt = "Be a pussy",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
        {
            id = 4,
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

RegisterNetEvent('casino:context:hit&stand', function() 
    local options = {
        {
            title = 'Hit',
            description = 'Draw another card',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 1
        },
        {
            title = 'Stand',
            description = 'Be a pussy',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 2
        },
    }
    lib.registerContext({
        id = 'hit&stand',
        title = 'Diamond Casino Blackjack',
        canClose = false,
        options = options,
    })
    lib.showContext('hit&stand')
end)

RegisterNetEvent('casino:context:hit&doubledown', function() 
    local options = {
        {
            title = 'Hit',
            description = 'Draw another card',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 1
        },
        {
            title = 'Stand',
            description = 'Be a pussy',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 2
        },
        {
            title = 'Double Down',
            description = 'Double your initial bet',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 3
        },
    }
    lib.registerContext({
        id = 'hit&doubledown',
        title = 'Diamond Casino Blackjack',
        canClose = false,
        options = options,
    })
    lib.showContext('hit&doubledown')
end)

RegisterNetEvent('casino:context:hit&split', function()
    local options = {
        {
            title = 'Hit',
            description = 'Draw another card',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 1
        },
        {
            title = 'Stand',
            description = 'Be a pussy',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 2
        },
        {
            title = 'Split',
            description = 'Split',
            -- metadata = {''},
            event = 'doj:client:blackjackMenu',
            args = 4
        },
    }
    lib.registerContext({
        id = 'hit&split',
        title = 'Diamond Casino Blackjack',
        canClose = false,
        options = options,
    })
    lib.showContext('hit&split')
end)

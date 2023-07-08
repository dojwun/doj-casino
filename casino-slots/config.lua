SlotReferences = {
    [-1932041857] = {
        sound = 'dlc_vw_casino_slot_machine_ak_npc_sounds',
        texture = 'CasinoUI_Slots_Angel',
        name = 'Angel And The Knight',
        reela = `vw_prop_casino_slot_01a_reels`,
        reelb = `vw_prop_casino_slot_01b_reels`,
        scriptrt = '01a',
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500 
        }
    },
    [-1519644200] = {
        sound = 'dlc_vw_casino_slot_machine_ir_npc_sounds',
        texture = 'CasinoUI_Slots_Impotent',
        name = 'Impotent Rage',
        reela = `vw_prop_casino_slot_02a_reels`,
        reelb = `vw_prop_casino_slot_02b_reels`,
        scriptrt = '02a',
        theme = 2,
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [-430989390] = {
        sound = 'dlc_vw_casino_slot_machine_rsr_npc_sounds',
        texture = 'CasinoUI_Slots_Ranger',
        name = 'Republican Space Rangers',
        reela = `vw_prop_casino_slot_03a_reels`,
        reelb = `vw_prop_casino_slot_03b_reels`,
        scriptrt = '03a',
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [654385216] = {
        sound = 'dlc_vw_casino_slot_machine_fs_npc_sounds',
        texture = 'CasinoUI_Slots_Fame',
        name = 'Fame Or Shame',
        reela = `vw_prop_casino_slot_04a_reels`,
        reelb = `vw_prop_casino_slot_04b_reels`,
        scriptrt = '04a',
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [161343630] = {
        sound = 'dlc_vw_casino_slot_machine_ds_npc_sounds',
        texture = 'CasinoUI_Slots_Deity',
        name = 'Deity Of The Sun',
        reela = `vw_prop_casino_slot_05a_reels`,
        reelb = `vw_prop_casino_slot_05b_reels`,
        scriptrt = '05a',
        theme = 5,
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [1096374064] = {
        sound = 'dlc_vw_casino_slot_machine_kd_npc_sounds',
        texture = 'CasinoUI_Slots_Knife',
        name = 'Twilight Knife',
        reela = `vw_prop_casino_slot_06a_reels`,
        reelb = `vw_prop_casino_slot_06b_reels`,
        scriptrt = '06a',
        theme = 6,
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [207578973] = {
        sound = 'dlc_vw_casino_slot_machine_td_npc_sounds',
        texture = 'CasinoUI_Slots_Diamond',
        name = 'Diamond Miner',
        reela = `vw_prop_casino_slot_07a_reels`,
        reelb = `vw_prop_casino_slot_07b_reels`,
        scriptrt = '07a',
        theme = 7,
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
    [-487222358] = {
        sound = 'dlc_vw_casino_slot_machine_hz_npc_sounds',
        texture = 'CasinoUI_Slots_Evacuator',
        name = 'Evacuator',
        reela = `vw_prop_casino_slot_08a_reels`,
        reelb = `vw_prop_casino_slot_08b_reels`,
        scriptrt = '08a',
        theme = 8,
        misschance = math.random(10, 40),
        betamounts = {
            50,
            100,
            150,
            250,
            500
        }
    },
}

Rewards = {
    [{0, 0, 0}] = 10.0, --- Sevens
    [{0, 0, 8}] = 10.0, --- Sevens
    [{0, 8, 0}] = 10.0, --- Sevens
    [{8, 0, 0}] = 10.0, --- Sevens
    [{0, 8, 8}] = 10.0, --- Sevens
    [{8, 0, 8}] = 10.0, --- Sevens
    [{8, 8, 0}] = 10.0, --- Sevens
    [{8, 8, 8}] = 10.0, --- Sevens

    [{1, 1, 1}] = 1.5, --- Plums
    [{1, 1, 9}] = 1.5, --- Plums
    [{1, 9, 1}] = 1.5, --- Plums
    [{9, 1, 1}] = 1.5, --- Plums
    [{1, 1, 12}] = 1.5, --- Plums
    [{1, 12, 1}] = 1.5, --- Plums
    [{12, 1, 1}] = 1.5, --- Plums
    [{1, 9, 9}] = 1.5, --- Plums
    [{9, 1, 9}] = 1.5, --- Plums
    [{9, 9, 1}] = 1.5, --- Plums
    [{1, 9, 12}] = 1.5, --- Plums
    [{1, 12, 9}] = 1.5, --- Plums
    [{9, 1, 12}] = 1.5, --- Plums
    [{9, 12, 1}] = 1.5, --- Plums
    [{12, 1, 9}] = 1.5, --- Plums
    [{12, 9, 1}] = 1.5, --- Plums
    [{1, 12, 12}] = 1.5, --- Plums
    [{12, 1, 12}] = 1.5, --- Plums
    [{12, 12, 1}] = 1.5, --- Plums
    [{9, 9, 9}] = 1.5, --- Plums
    [{9, 9, 12}] = 1.5, --- Plums
    [{9, 12, 9}] = 1.5, --- Plums
    [{12, 9, 9}] = 1.5, --- Plums
    [{9, 12, 12}] = 1.5, --- Plums
    [{12, 9, 12}] = 1.5, --- Plums
    [{12, 12, 9}] = 1.5, --- Plums
    [{12, 12, 12}] = 1.5, --- Plums

    [{2, 2, 2}] = 2.5, --- Cherries
    [{2, 2, 6}] = 2.5, --- Cherries
    [{2, 6, 2}] = 2.5, --- Cherries
    [{6, 2, 2}] = 2.5, --- Cherries
    [{2, 2, 14}] = 2.5, --- Cherries
    [{2, 14, 2}] = 2.5, --- Cherries
    [{14, 2, 2}] = 2.5, --- Cherries
    [{2, 6, 6}] = 2.5, --- Cherries
    [{6, 2, 6}] = 2.5, --- Cherries
    [{6, 6, 2}] = 2.5, --- Cherries
    [{2, 6, 14}] = 2.5, --- Cherries
    [{2, 14, 6}] = 2.5, --- Cherries
    [{6, 2, 14}] = 2.5, --- Cherries
    [{6, 14, 2}] = 2.5, --- Cherries
    [{14, 2, 6}] = 2.5, --- Cherries
    [{14, 6, 2}] = 2.5, --- Cherries
    [{2, 14, 14}] = 2.5, --- Cherries
    [{14, 2, 14}] = 2.5, --- Cherries
    [{14, 14, 2}] = 2.5, --- Cherries
    [{6, 6, 6}] = 2.5, --- Cherries
    [{6, 6, 14}] = 2.5, --- Cherries
    [{6, 14, 6}] = 2.5, --- Cherries
    [{14, 6, 6}] = 2.5, --- Cherries
    [{6, 14, 14}] = 2.5, --- Cherries
    [{14, 6, 14}] = 2.5, --- Cherries
    [{14, 14, 6}] = 2.5, --- Cherries
    [{14, 14, 14}] = 2.5, --- Cherries

    [{3, 3, 3}] = 5.0, --- Melons
    [{3, 3, 10}] = 5.0, --- Melons
    [{3, 10, 3}] = 5.0, --- Melons
    [{10, 3, 3}] = 5.0, --- Melons
    [{3, 10, 10}] = 5.0, --- Melons
    [{10, 3, 10}] = 5.0, --- Melons
    [{10, 10, 3}] = 5.0, --- Melons
    [{10, 10, 10}] = 5.0, --- Melons

    [{7, 7, 7}] = 7.5, --- Bells
    [{7, 7, 13}] = 7.5, --- Bells
    [{7, 13, 7}] = 7.5, --- Bells
    [{13, 7, 7}] = 7.5, --- Bells
    [{7, 13, 13}] = 7.5, --- Bells
    [{13, 7, 13}] = 7.5, --- Bells
    [{13, 13, 7}] = 7.5, --- Bells
    [{13, 13, 13}] = 7.5, --- Bells

    [{5, 5, 5}] = 25.0, --- Jackpot
}

--- E.g. Diamond slot | Only one diamond will give 1.0x, 2 diamonds will give 3.5x, 3 will give 9.0x.
SpecialReward = {
    1.0,
    3.5,
    9.0
}

UseCash = false
UseBank = false
UseItem = true
ItemName = 'casino_goldchip'

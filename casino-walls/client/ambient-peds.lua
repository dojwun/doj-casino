CreateThread(function()
	CasinoPeds()
end)


function CasinoPeds()
    -- Employee
    model = GetHashKey("U_F_M_CasinoCash_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,950.214, 33.151, 70.839, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 57.052 )
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    -- Inside Track
    model = GetHashKey("S_M_Y_Doorman_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 955.619, 70.179, 69.433, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 190.937)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)


    -- ambient workers
    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,920.726, 45.883, 71.073, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 276.635)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 933.62, 41.631, 80.089, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  56.923)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 938.974, 27.776, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 13.513)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WINDOW_SHOP_BROWSE", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 947.994, 45.233, 70.638, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  220.199)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 969.729, 57.35, 70.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 23.352)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 998.848, 45.308, 68.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 43.086)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 978.838, 69.432, 69.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 237.674)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 973.283, 41.411, 70.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 184.428)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)


    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 996.982, 37.33, 69.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 45.32)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 984.436, 36.494, 69.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 314.327)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 994.234, 65.098, 68.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 151.299)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 989.222, 71.748, 69.233, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 161.745)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 974.901, 34.128, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 1.995)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 970.651, 65.43, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 192.896)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 920.48, 46.759, 71.073, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 277.117)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 933.011, 40.807, 80.089, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 54.913)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 929.086, 34.707, 80.089, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 328.4)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 949.615, 25.983, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 53.202)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_F_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 939.71, 47.066, 71.279, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 4164.51)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("S_M_Y_Casino_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 929.79, 37.618, 71.274, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 35.262)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("s_m_y_valet_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 925.235, 50.921, 80.106, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 55.601)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    -- ==================================================================================================================--
    -- ==================================================================================================================--locals-
    -- ==================================================================================================================--
    model = GetHashKey("a_m_m_paparazzi_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 949.985, 54.927, 70.433, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 172.611)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("a_f_y_tourist_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 943.266, 64.802, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 267.054)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)

    model = GetHashKey("a_f_y_vinewood_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 943.723, 65.612, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  173.907)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)

    model = GetHashKey("cs_tom")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 942.68, 38.882, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 154.872)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WINDOW_SHOP_BROWSE", 0, true)

    model = GetHashKey("cs_jimmyboston")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 942.057, 38.012, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,   329.05)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)

    model = GetHashKey("cs_carbuyer")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 929.239, 28.97, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  281.783)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)

    model = GetHashKey("a_m_y_clubcust_03")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 928.8, 29.857, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  283.934)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)

    model = GetHashKey("cs_gurk")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 934.337, 37.499, 71.279, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 168.193)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)

    model = GetHashKey("cs_lazlow_2")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,935.38, 37.579, 71.279, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  180.215)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_m_y_clubcust_03")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,927.904, 41.925, 71.274, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  179.576)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("a_m_y_bevhills_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 953.208, 61.601, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  339.76)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_f_y_vinewood_04")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 953.94, 61.392, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 344.716)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("a_f_y_scdressy_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 955.158, 61.174, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  356.136)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_f_y_genhot_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 965.489, 72.251, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  196.752)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_m_m_malibu_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 964.468, 71.471, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  221.392)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)

    model = GetHashKey("a_f_y_vinewood_04")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 987.52, 57.652, 68.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  204.379)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("s_m_m_hairdress_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 986.732, 57.113, 68.866, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  222.62)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)

    model = GetHashKey("ig_taostranslator")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 982.362, 46.761, 69.238, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  0.99)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("u_f_m_miranda_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 969.109, 46.507, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 82.089)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)

    model = GetHashKey("cs_carbuyer")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,  969.066, 47.366, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 83.4)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("cs_dale")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,968.666, 45.528, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,  81.227)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("ig_taostranslator")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 961.332, 52.542, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,203.484)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_m_y_hipster_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,  988.817, 49.03, 68.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 352.551)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("u_f_m_miranda_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 989.748, 49.294, 68.832, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 6.127)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("a_f_y_scdressy_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 962.446, 52.816, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 207.774)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_m_m_prolhost_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 945.779, 22.762, 70.279, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 44.244)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR", 0, true)

    model = GetHashKey("a_f_y_scdressy_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 945.09, 21.745, 70.279, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 51.433)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_DECKCHAIR_DRINK", 0, true)

    model = GetHashKey("a_f_y_bevhills_04")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 940.96, 18.807, 70.305, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 17.935)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_DECKCHAIR_DRINK", 0, true)

    model = GetHashKey("a_m_m_stlat_02")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 941.913, 19.163, 70.288, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 18.65)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR_FOOD", 0, true)

    model = GetHashKey("a_f_y_scdressy_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 932.517, 18.882, 70.313, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 7.469)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", 0, true)

    model = GetHashKey("a_f_y_bevhills_04")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 933.335, 19.048, 70.33, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 357.385)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_BENCH_DRINK_BEER", 0, true)

    model = GetHashKey("a_m_m_malibu_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 934.378, 19.097, 70.339, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 357.293)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_DECKCHAIR_DRINK", 0, true)

    model = GetHashKey("a_f_y_bevhills_04")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model ,  937.486, 29.38, 70.537, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 202.034)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_BENCH_DRINK_BEER", 0, true)

    model = GetHashKey("a_m_m_malibu_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 938.916, 29.585, 70.534, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 179.067)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_BENCH_DRINK_BEER", 0, true)

    model = GetHashKey("ig_taostranslator")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 935.392, 27.821, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 326.627)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_f_y_genhot_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 935.98, 28.242, 70.834, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped,233.585)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_STAND_IMPATIENT", 0, true)

    model = GetHashKey("a_f_y_genhot_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 962.431, 51.656, 69.833, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 29.831)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)

    model = GetHashKey("a_f_y_genhot_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 951.392, 36.326, 70.838, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 101.098)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PARTYING", 0, true)

    model = GetHashKey("a_f_y_genhot_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 950.274, 37.131, 70.838, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 201.608)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
end


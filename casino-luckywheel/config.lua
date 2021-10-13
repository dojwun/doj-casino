Config	= {}


Config.SpawnWheel = false 			-- If your map does NOT have the wheel, set it to true. if your map has already a wheel set it to false
Config.WheelPos = {x = 949.71, y = 45.1, z = 70.9, h =328.0}	-- Where the wheel prop will spawn OR where wheel prop is
Config.startingPrice = 5000




-- First it will pick a random 
-- type: weapon, money, item, car (for money it will give only in bank)
-- name: the DB name, 
-- count: 

-- probability: the script will generate a number from 1 to 1000
-- if the random number is between a and b player will win
-- random number must be bigger than a and smaller or equal to b
-- if rnd > a and rnd <= b 

-- available sounds: 'car', 'cash', 'chips', 'clothes', 'mystery', 'win'
Config.Prices = {
	[1]  = {type = 'car', 		name = 'car', 			count = 1, 		sound = 'car', 		probability = {a =   0, b =   1}},	--  0.1 %   0.1 -- VEHICLE
	[2]  = {type = 'money', 	name = 'money', 		count = 15000, 	sound = 'cash', 	probability = {a =   1, b =   5}},	--  0.4 %   0.5 -- 15.000 RP
	[3]  = {type = 'item', 		name = 'vip', 			count = 1, 		sound = 'clothes', 	probability = {a =   5, b =  10}},	--  0.5 %   1.0 -- CLOTHING
	[4]  = {type = 'item', 		name = 'blackchip', 	count = 25000, 	sound = 'chips', 	probability = {a =  10, b =  20}},	--  1.0 %   2.0 -- 25.000 chips
	[5]  = {type = 'money', 	name = 'money', 		count = 40000, 	sound = 'cash', 	probability = {a =  20, b =  40}},	--  2.0 %   4.0 -- 40.000 $
	[6]  = {type = 'money', 	name = 'money', 		count = 10000, 	sound = 'cash', 	probability = {a =  40, b =  60}},	--  2.0 %   6.0 -- 10.000 RP
	[7]  = {type = 'item', 		name = 'joint3g', 		count = 1, 		sound = 'clothes', 	probability = {a =  60, b =  80}},	--  4.0 %   8.0 -- CLOTHING
	[8]  = {type = 'item', 		name = 'vip',  			count = 1, 		sound = 'mystery', 	probability = {a =  80, b = 120}},	--  4.0 %  12.0 -- MYSTERY
	[9]  = {type = 'item', 		name = 'blackchip', 	count = 20000, 	sound = 'chips', 	probability = {a = 120, b = 170}},	--  5.0 %  17.0 -- 20.000 chips
	[10] = {type = 'money', 	name = 'money', 		count = 7500, 	sound = 'cash', 	probability = {a = 170, b = 250}},	--  5.0 %  22.0 -- 7.500 RP
	[11] = {type = 'item',		name = 'joint', 		count = 1, 		sound = 'clothes', 	probability = {a = 250, b = 300}},	--  6.0 %  28.0 -- CLOTHING
	[12] = {type = 'item', 		name = 'redchip', 		count = 15000, 	sound = 'chips', 	probability = {a = 300, b = 340}},	--  6.0 %  34.0 -- 15.000 chips
	[13] = {type = 'money', 	name = 'money', 		count = 30000, 	sound = 'cash', 	probability = {a = 340, b = 380}},	--  7.0 %  41.0 -- 30.000 $
	[14] = {type = 'money', 	name = 'money', 		count = 5000, 	sound = 'cash', 	probability = {a = 380, b = 540}},	--  7.0 %  48.0 -- 5.000 RP
	[15] = {type = 'weapon', 	name = 'weapon_pistol', count = 1, 		sound = 'mystery', 	probability = {a = 540, b = 610}},	--  8.0 %  56.0 -- DISCOUNT
	[16] = {type = 'item',		name = 'redchip', 		count = 10000, 	sound = 'chips', 	probability = {a = 610, b = 640}},	--  8.0 %  64.0 -- 10.000 chips
	[17] = {type = 'money',		name = 'money', 		count = 20000, 	sound = 'cash', 	probability = {a = 640, b = 700}},	--  8.0 %  72.0 -- 20.000 $
	[18] = {type = 'money', 	name = 'money', 		count = 2500, 	sound = 'cash', 	probability = {a = 700, b = 810}},	--  9.0 %  81.0 -- 2.500 RP
	[19] = {type = 'item', 		name = 'lean', 			count = 1, 		sound = 'clothes', 	probability = {a = 810, b = 990}},	--  9.0 %  90.0 -- CLOTHING
	[20] = {type = 'money', 	name = 'money', 		count = 50000, 	sound = 'cash', 	probability = {a = 990, b = 1000}},	-- 1.0 % -- 50.000 $ 
}
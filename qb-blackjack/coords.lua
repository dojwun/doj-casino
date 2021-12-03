
_DEBUG = false

function DebugPrint(str)
	if _DEBUG == true and str then
		return print("BLACKJACK: "..tostring(str))
	end
end

ChackCardPropAnim = true

tables = { -- Spawns Ped Only -- Setup Currently For This https://forum.cfx.re/t/cayo-perico-casino-dlc-ipl-loader/2099391
	{
		coords = vector4(996.17, 51.69, 68.45, 318.91), --Table 1
		highStakes = false
	},
	{
		coords = vector4(1000.66, 50.88, 68.45, 6.73), --Table 2
		highStakes = false
	},
	{
		coords = vector4(1004.09, 53.11, 68.45, 55.30), --Table 3
		highStakes = false
	},
	{
		coords = vector4(1002.36, 60.52, 68.45, 142.53), --Table 4
		highStakes = false
	},
	{
		coords = vector4(998.44, 60.99, 68.45, 191.77), --Table 5
		highStakes = false
	},
	{
		coords = vector4(994.89, 58.29, 68.45, 237.13), --Table 6
		highStakes = false
	},
	{
		coords = vector4(985.95, 60.56, 69.25, 187.91), --Table 7
		highStakes = true
	},
	{
		coords = vector4(982.50, 62.85, 69.25, 101.44), --Table 8
		highStakes = true
	},
	{
		coords = vector4(984.97, 66.64, 69.25, 3.39), --Table 9
		highStakes = true
	},
	{
		coords = vector4(988.45, 64.38, 69.25, 278.52), --Table 10
		highStakes = true
	},
	{
		coords = vector4(989.05, 45.69, 69.25, 22.31), --Table 11
		highStakes = true
	},
	{
		coords = vector4(987.30, 42.19, 69.25, 102.30), --Table 12
		highStakes = true
	},
	{
		coords = vector4(991.56, 40.10, 69.25, 200.84), --Table 13
		highStakes = true
	},
	{ 
		coords = vector4(993.20, 43.70, 69.25, 279.25), --Table 14
		highStakes = true
	},
}

--[[
	Table colors
	0: Green
	1: Red
	2: Blue
	3: Purple
--]]

customTables = { -- Spawns ped with table, example below
{
	coords = vector4(967.33, 32.0191, 115.1742, -122.0),
	highStakes = false,
	color = 1,
},
 	-- {
	-- 	coords = vector4(996.77, 52.43, 68.43, 318.91),
	-- 	highStakes = false,
	-- 	color = 0
	-- },
}

for i,v in pairs(customTables) do
	table.insert(tables, v)
end

resultNames = {
	["good"] = "WON",
	["bad"] = "BUST",
	["impartial"] = "Got a PUSH",
}

requestCardAnims = {
	"request_card",
	"request_card_alt1",
	"request_card_alt2",
}
declineCardAnims = {
	"decline_card_001",
	"decline_card_alt1",
	"decline_card_alt2",
}

cardOffsets = {
	[1] = {
		vector3(0.5737, 0.2376, 0.948025),
		vector3(0.562975, 0.2523, 0.94875),
		vector3(0.553875, 0.266325, 0.94955),
		vector3(0.5459, 0.282075, 0.9501),
		vector3(0.536125, 0.29645, 0.95085),
		vector3(0.524975, 0.30975, 0.9516),
		vector3(0.515775, 0.325325, 0.95235),
	},
	
	[2] = {
		vector3(0.2325, -0.1082, 0.94805),
		vector3(0.23645, -0.0918, 0.949),
		vector3(0.2401, -0.074475, 0.950225),
		vector3(0.244625, -0.057675, 0.951125),
		vector3(0.249675, -0.041475, 0.95205),
		vector3(0.257575, -0.0256, 0.9532),
		vector3(0.2601, -0.008175, 0.954375),
	},
	
	[3] = {
		vector3(-0.2359, -0.1091, 0.9483),
		vector3(-0.221025, -0.100675, 0.949),
		vector3(-0.20625, -0.092875, 0.949725),
		vector3(-0.193225, -0.07985, 0.950325),
		vector3(-0.1776, -0.072, 0.951025),
		vector3(-0.165, -0.060025, 0.951825),
		vector3(-0.14895, -0.05155, 0.95255),
	},
	
	[4] = {
		vector3(-0.5765, 0.2229, 0.9482),
		vector3(-0.558925, 0.2197, 0.949175),
		vector3(-0.5425, 0.213025, 0.9499),
		vector3(-0.525925, 0.21105, 0.95095),
		vector3(-0.509475, 0.20535, 0.9519),
		vector3(-0.491775, 0.204075, 0.952825),
		vector3(-0.4752, 0.197525, 0.9543),
	}
}

cardRotationOffsets = {
	[1] = {
		69.12,
		67.8,
		66.6,
		70.44,
		70.84,
		67.88,
		69.56,
	},
	
	[2] = {
		22.11,
		22.32,
		20.8,
		19.8,
		19.44,
		26.28,
		22.68,
	},
	
	[3] = {
		-21.43,
		-20.16,
		-16.92,
		-23.4,
		-21.24,
		-23.76,
		-19.44,
	},
	
	[4] = {
		-67.03,
		-69.12,
		-64.44,
		-67.68,
		-63.72,
		-68.4,
		-64.44,
	},
}

cardSplitOffsets = {

	[1] = {
		vector3(0.6083, 0.3523, 0.94795),
		vector3(0.598475, 0.366475, 0.948925),
		vector3(0.589525, 0.3807, 0.94975),
		vector3(0.58045, 0.39435, 0.950375),
		vector3(0.571975, 0.4092, 0.951075),
		vector3(0.5614, 0.4237, 0.951775),
		vector3(0.554325, 0.4402, 0.952525),
	},
	
	[2] = {
		vector3(0.3431, -0.0527, 0.94855),
		vector3(0.348575, -0.0348, 0.949425),
		vector3(0.35465, -0.018825, 0.9502),
		vector3(0.3581, -0.001625, 0.95115),
		vector3(0.36515, 0.015275, 0.952075),
		vector3(0.368525, 0.032475, 0.95335),
		vector3(0.373275, 0.0506, 0.9543),
	},
	
	[3] = {
		vector3(-0.116, -0.1501, 0.947875),
		vector3(-0.102725, -0.13795, 0.948525),
		vector3(-0.08975, -0.12665, 0.949175),
		vector3(-0.075025, -0.1159, 0.949875),
		vector3(-0.0614, -0.104775, 0.9507),
		vector3(-0.046275, -0.095025, 0.9516),
		vector3(-0.031425, -0.0846, 0.952675),
	},
	
	[4] = {
		vector3(-0.5205, 0.1122, 0.9478),
		vector3(-0.503175, 0.108525, 0.94865),
		vector3(-0.485125, 0.10475, 0.949175),
		vector3(-0.468275, 0.099175, 0.94995),
		vector3(-0.45155, 0.09435, 0.95085),
		vector3(-0.434475, 0.089725, 0.95145),
		vector3(-0.415875, 0.0846, 0.9523),
	}
}

cardSplitRotationOffsets = {
	[1] = {
	 	68.57,
	 	67.52,
	 	67.76,
	 	67.04,
	 	68.84,
	 	65.96,
	 	67.76,
	},
	
	[2] = {
		22.11,
		22.0,
		24.44,
		21.08,
		25.96,
		26.16,
		28.76,
	},
	
	[3] = {
		-14.04,
		-15.48,
		-16.56,
		-15.84,
		-16.92,
		-14.4,
		-14.28,
	},
	
	[4] = {
		-67.03,
		-67.6,
		-69.4,
		-69.04,
		-68.68,
		-66.16,
		-63.28,
	},
}

cardOffsetsDealer = {
	vector3(0.0436, 0.21205, 0.948875),
	vector3(-0.0636, 0.213825, 0.9496),
	vector3(-0.0806, 0.2137, 0.950225),
	vector3(-0.1006, 0.21125, 0.950875),
	vector3(-0.1256, 0.21505, 0.951875),
	vector3(-0.1416, 0.21305, 0.953),
	vector3(-0.1656, 0.21205, 0.954025),
	vector3(-0.1836, 0.21255, 0.95495),
	vector3(-0.2076, 0.21105, 0.956025),
	vector3(-0.2246, 0.21305, 0.957),
}

cardRotationOffsetsDealer = { -- doesnt have to be vector3
	vector3(0.0, 0.0, 178.92),
	vector3(0.0, 0.0, -180.0),
	vector3(0.0, 0.0, -178.92),
	vector3(0.0, 0.0, -177.12),
	vector3(0.0, 0.0, 180.0),
	vector3(0.0, 0.0, 178.56),
	vector3(0.0, 0.0, 180.0),
	vector3(0.0, 0.0, 178.2),
	vector3(0.0, 0.0, -177.12),
	vector3(0.0, 0.0, 180.0),
	vector3(0.0, 0.0, 178.56),
}

chipSplitOffsets = {
	[1] = {
		vector3(0.6931, 0.1952, 0.0),
		vector3(0.724925, 0.26955, 0.0),
		vector3(0.7374, 0.349625, 0.0),
		vector3(0.76415, 0.419225, 0.0),
	},
	
	[2] = {
		vector3(0.2827, -0.227825, 0.0),
		vector3(0.3605, -0.1898, 0.0),
		vector3(0.4309, -0.16365, 0.0),
		vector3(0.49275, -0.111575, 0.0),
	},
	
	[3] = {
		vector3(-0.279425, -0.2238, 0.0),
		vector3(-0.200775, -0.25855, 0.0),
		vector3(-0.125775, -0.26815, 0.0),
		vector3(-0.05615, -0.29435, 0.0),
	},
	
	[4] = {
		vector3(-0.685925, 0.173275, 0.0),
		vector3(-0.6568, 0.092525, 0.0),
		vector3(-0.612875, 0.033025, 0.0),
		vector3(-0.58465, -0.0374, 0.0),
	}
}


chipSplitRotationOffsets = { -- doesnt have to be vector3
	[1] = {
		vector3(0, 0, -16.56),
		vector3(0, 0, -22.32),
		vector3(0, 0, -10.8),
		vector3(0, 0, -9.72),
	},
	
	[2] = {
		vector3(0, 0, -69.12),
		vector3(0, 0, -64.8),
		vector3(0, 0, -58.68),
		vector3(0, 0, -51.12),
	},
	
	[3] = {
		vector3(0, 0, -112.32),
		vector3(0, 0, -108.36),
		vector3(0, 0, -99.72),
		vector3(0, 0, -102.6),
	},
	
	[4] = {
		vector3(0, 0, -155.88),
		vector3(0, 0, -151.92),
		vector3(0, 0, -147.24),
		vector3(0, 0, -146.52),
	}
}

chipOffsets = {
	[1] = {
		vector3(0.712625, 0.170625, 0.0),
		vector3(0.6658, 0.218375, 0.0),
		vector3(0.756775, 0.292775, 0.0),
		vector3(0.701875, 0.3439, 0.0),
	},
	
	[2] = {
		vector3(0.278125, -0.2571, 0.0),
		vector3(0.280375, -0.190375, 0.0),
		vector3(0.397775, -0.208525, 0.0),
		vector3(0.39715, -0.1354, 0.0),
	},
	
	[3] = {
		vector3(-0.30305, -0.2464, 0.0),
		vector3(-0.257975, -0.19715, 0.0),
		vector3(-0.186575, -0.2861, 0.0),
		vector3(-0.141675, -0.237925, 0.0),
	},
	
	[4] = {
		vector3(-0.72855, 0.17345, 0.0),
		vector3(-0.652825, 0.177525, 0.0),
		vector3(-0.6783, 0.0744, 0.0),
		vector3(-0.604425, 0.082575, 0.0),
	}
}

pileOffsets = {
	[1] = {
		vector3(0.61, -0.02, 0.0),
		vector3(0.73, 0.47, 0.0),
		vector3(0.756775, 0.292775, 0.0),
		vector3(0.701875, 0.3439, 0.0),
	},
	
	[2] = {
		vector3(0.03, -0.29, 0.0),
		vector3(0.05, -0.06, 0.0),
		vector3(0.397775, -0.208525, 0.0),
		vector3(0.39715, -0.1354, 0.0),
	},
	
	[3] = {
		vector3(-0.48, -0.13, 0.0),
		vector3(-0.35, 0.07, 0.0),
		vector3(-0.186575, -0.2861, 0.0),
		vector3(-0.141675, -0.237925, 0.0),
	},
	
	[4] = {
		vector3(-0.7, 0.32, 0.0),
		vector3(-0.7, 0.53, 0.0),
		vector3(-0.6783, 0.0744, 0.0),
		vector3(-0.604425, 0.082575, 0.0),
	}
}

chipRotationOffsets = { -- doesnt have to be vector3
	[1] = {
		vector3(0, 0, 72.0),
		vector3(0, 0, 64.8),
		vector3(0, 0, 74.52),
		vector3(0, 0, 72.0),
	},
	
	[2] = {
		vector3(0, 0, 12.96),
		vector3(0, 0, 29.16),
		vector3(0, 0, 32.04),
		vector3(0, 0, 32.04),
	},
	
	[3] = {
		vector3(0, 0, -18.36),
		vector3(0, 0, -18.72),
		vector3(0, 0, -15.48),
		vector3(0, 0, -18.0),
	},
	
	[4] = {
		vector3(0, 0, -79.2),
		vector3(0, 0, -68.76),
		vector3(0, 0, -57.6),
		vector3(0, 0, -64.8),
	}
}

pileRotationOffsets = { -- doesnt have to be vector3
	[1] = {
		vector3(0, 0, 8.1),
		vector3(0, 0, 229.49),
		vector3(0, 0, 74.52),
		vector3(0, 0, 72.0),
	},
	
	[2] = {
		vector3(0, 0, 78.7),
		vector3(0, 0, 4.6),
		vector3(0, 0, 32.04),
		vector3(0, 0, 32.04),
	},
	
	[3] = {
		vector3(0, 0, 44.89),
		vector3(0, 0, 144.49),
		vector3(0, 0, -15.48),
		vector3(0, 0, -18.0),
	},
	
	[4] = {
		vector3(0, 0, 15.6),
		vector3(0, 0, 15.6),
		vector3(0, 0, -57.6),
		vector3(0, 0, -64.8),
	}
}

lowTableLimit = 40
bettingNums = {
	10,
	20,
	30,
	40,
	50,
	60,
	70,
	80,
	90,
	100,
	150,
	200,
	250,
	300,
	350,
	400,
	450,
	500,
	1000,
	1500,
	2000,
	2500,
	3000,
	3500,
	4000,
	4500,
	5000,
	6000,
	7000,
	8000,
	9000,
	10000,
	15000,
	20000,
	25000,
	30000,
	35000,
	40000,
	45000,
	50000, -- 40 Low table limit, betting numbers added after this will be high stakes only
	55000,
	60000,
	65000,
	70000,
	75000,
	80000,
	85000,
	90000,
	95000,
	100000,
	150000,
	200000,
	250000,
	300000,
	350000,
	400000,
	450000,
	500000,
	550000,
	600000,
	650000,
	700000,
	750000,
	800000,
	850000,
	900000,
	950000,
	1000000,
	1500000,
	2000000,
	2500000,
	3000000,
	3500000,
	4000000,
	4500000,
	5000000,
	5500000,
	6000000,
	6500000,
	7000000,
	7500000,
	8000000,
	8500000,
	9000000,
	9500000,
	10000000,
}

bettingTime = 50
moveTime = 30
--[[
	case 10:
		return joaat("vw_prop_chip_10dollar_x1");
	case 50:
		return joaat("vw_prop_chip_50dollar_x1");
	case 100:
		return joaat("vw_prop_chip_100dollar_x1");
	case 500:
		return joaat("vw_prop_chip_500dollar_x1");
	case 1000:
		return joaat("vw_prop_chip_1kdollar_x1");
	case 5000:
		return joaat("vw_prop_plaq_5kdollar_x1");
	case 10000:
		return joaat("vw_prop_plaq_10kdollar_x1");

		vw_prop_chip_10kdollar_x1.ydr
		vw_prop_chip_5kdollar_x1.ydr
		vw_prop_chip_10kdollar_st.ydr -- $120,000
		vw_prop_chip_5kdollar_st.ydr -- $60,000
		vw_prop_vw_chips_pile_01a.ydr -- $511,000
		vw_prop_vw_chips_pile_02a.ydr -- $3,250,000
		vw_prop_vw_chips_pile_03a.ydr -- $1,990,000

--]]

chipModels = {
	[10] = "vw_prop_chip_10dollar_x1",
	[50] = "vw_prop_chip_50dollar_x1",
	[100] = "vw_prop_chip_100dollar_x1",
	[120] = "vw_prop_chip_10dollar_st",
	[500] = "vw_prop_chip_500dollar_x1",
	[600] = "vw_prop_chip_50dollar_st",
	[1000] = "vw_prop_chip_1kdollar_x1",
	[1200] = "vw_prop_chip_100dollar_st",
	[5000] = "vw_prop_chip_5kdollar_x1",
	[6000] = "vw_prop_chip_500dollar_st",
	[10000] = "vw_prop_chip_10kdollar_x1",
	[60000] = "vw_prop_chip_5kdollar_st",
	[120000] = "vw_prop_chip_10kdollar_st",
}

chipValues = {
	10,
	50,
	100,
	120,
	500,
	600,
	1000,
	1200,
	5000,
	6000,
	10000,
	60000,
	120000,
}

chipThickness = {
	[`vw_prop_chip_10dollar_x1`] = 0.0054170000366867,
	[`vw_prop_chip_50dollar_x1`] = 0.0056730001233518,
	[`vw_prop_chip_100dollar_x1`] = 0.0056900000199676,
	[`vw_prop_chip_10dollar_st`] = 0.061421997845173,
	[`vw_prop_chip_500dollar_x1`] = 0.0057030003517866,
	[`vw_prop_chip_50dollar_st`] = 0.061151999980211,
	[`vw_prop_chip_1kdollar_x1`] = 0.0056910002604127,
	[`vw_prop_chip_100dollar_st`] = 0.060908999294043,
	[`vw_prop_chip_500dollar_st`] = 0.060989998281002,

	[`vw_prop_chip_5kdollar_x1`] = 0.005538,
	[`vw_prop_chip_10kdollar_x1`] = 0.005562,
	[`vw_prop_chip_5kdollar_st`] = 0.061049,
	[`vw_prop_chip_10kdollar_st`] = 0.06095,	
	[`vw_prop_plaq_5kdollar_x1`] = 0.006891000084579,
	[`vw_prop_plaq_10kdollar_x1`] = 0.0057889996096492,
	[`vw_prop_plaq_5kdollar_st`] = 0.060949999839067,
	[`vw_prop_plaq_10kdollar_st`] = 0.060749001801014,
}

chipHeights = { -- whatever the fuck this even means
	0.95,
	0.896,
	0.901,
	0.907,
	0.95,
	0.917,
	0.922,
	0.927,
	0.932,
	0.95,
	0.904,
	0.899,
	0.914,
	0.904,
	0.924,
	0.91,
	0.935,
	0.95,
	0.95,
	0.904,
	0.899,
	0.915,
	0.904,
	0.925,
	0.91,
	0.935,
	0.95,
	0.919,
	0.924,
	0.93,
	0.935,
	0.95,
	0.902,
	0.897,
	0.912,
	0.902,
	0.922,
	0.907,
	0.932,
	0.912,
}

function SetDealerOutfit(ped, outfit)
	local outfit = (outfit % 13) or math.random(0, 13)

	SetPedDefaultComponentVariation(ped)

	if outfit == 0 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 1 then
		SetPedComponentVariation(ped, 0, 2, 2, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 2 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 3 then
		SetPedComponentVariation(ped, 0, 2, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 4 then
		SetPedComponentVariation(ped, 0, 4, 2, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 5 then
		SetPedComponentVariation(ped, 0, 4, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 0, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 6 then
		SetPedComponentVariation(ped, 0, 4, 1, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 7 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 8 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 9 then
		SetPedComponentVariation(ped, 0, 2, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 10 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 1, 0)
		SetPedComponentVariation(ped, 3, 3, 3, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 11 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
		return
	elseif outfit == 12 then
		SetPedComponentVariation(ped, 0, 3, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 13 then
		SetPedComponentVariation(ped, 0, 4, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
		return
	end
end

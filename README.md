
# Framework
**[Qbox](https://github.com/Qbox-project)** 

# Dependencies
**[ox_lib](https://github.com/overextended/ox_lib)** 

**[ox_inventory](https://github.com/overextended/ox_inventory)**

**[envi-interact](https://github.com/Envi-Scripts/envi-interact)** 

**[casinoUi](https://github.com/dojwun/casinoUi)**

# About
- Mostly converted to qbx / ox
> Still using a few qb-core callbacks (removing)

- New casino interactions
> envi-interact
> 
- Lots of configs/additions to casino-walls

- Added secret gumball item

- Customize luckywheel vehicle

- Might be missing a few things but will try to fix or add if requested. ENJOY!

# Images
![casino_goldchip](https://i.imgur.com/7NPjx6H.png)
![casino_member](https://i.imgur.com/SOxFphs.png)
![casino_vip](https://i.imgur.com/nBvSini.png)


# qbx_core/shared/items.lua info 
```
	['casino_gumball']  = {
		['name'] = 'casino_gumball',
		['label'] = 'Gumball',
		['weight'] = 100,
		['type'] = 'item',
		['image'] = 'casino_gumball.png',
		['unique'] = false, 	
		['useable'] = true,
		['shouldClose'] = true,
		['combinable'] = nil,  
		['description'] = 'A shiny gumball'
	},
	['casino_member']  = {
		['name'] = 'casino_member',
		['label'] = 'Casino Member', 
		['weight'] = 0, 	
		['type'] = 'item', 	
		['image'] = 'casino_member.png', 	
		['unique'] = false, 	
		['useable'] = false, 
		['shouldClose'] = false, 
		['combinable'] = nil,  
		['description'] = 'Casino Membership'
	},
	['casino_vip']  = {
		['name'] = 'casino_vip',
		['label'] = 'Casino V.I.P', 
		['weight'] = 0, 	
		['type'] = 'item', 	
		['image'] = 'casino_vip.png', 	
		['unique'] = false, 	
		['useable'] = false, 
		['shouldClose'] = false, 
		['combinable'] = nil,  
		['description'] = 'V.I.P Membership'
	},
```



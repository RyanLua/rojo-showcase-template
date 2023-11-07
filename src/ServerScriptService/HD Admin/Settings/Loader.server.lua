--[[
	This loads HD Admin into your game.
	
	Require the 'HD Admin MainModule' by the HD Admin group for automatic updates.
	
	You can view the HD Admin Main Module here:
	https://www.roblox.com/library/3239236979/HD
	
--]]

local loaderFolder = script.Parent.Parent
local mainModule = require(3239236979)
mainModule:Initialize(loaderFolder)
loaderFolder:Destroy()

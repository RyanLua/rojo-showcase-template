--!strict

--[[
	Add VRService tweaks to VR.
	AutomaticScaling for improved perspective based on the user's avatar.
	AvatarGestures so hands and head are animated based on controllers and headset.

	https://create.roblox.com/docs/reference/engine/classes/VRService
	https://devforum.roblox.com/t/2954399
]]

local VRService = game:GetService("VRService")
VRService.AutomaticScaling = Enum.VRScaling.World
VRService.AvatarGestures = true

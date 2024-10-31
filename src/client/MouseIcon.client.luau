--!strict

--[[
	Changes the mouse icon to a custom image.
	You can modify the image by changing the Icon attribute of this script.

	https://create.roblox.com/docs/reference/engine/classes/UserInputService#MouseIcon
]]

local mouseIcon: string = script:GetAttribute("Icon") :: string or "rbxasset://textures/Cursors/Gamepad/Pointer.png"

local UserInputService = game:GetService("UserInputService")
UserInputService.MouseIcon = mouseIcon

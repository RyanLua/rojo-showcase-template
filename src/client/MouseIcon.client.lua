--!strict

--[[
    Changes the mouse icon to a custom image.
	You can modify the image by changing the Icon attribute of this script.

    https://create.roblox.com/docs/reference/engine/classes/UserInputService#MouseIcon
]]

local UserInputService = game:GetService("UserInputService")
UserInputService.MouseIcon = script:GetAttribute("Icon") or "rbxasset://textures/Cursors/Gamepad/Pointer.png"

--!strict

--[[
	Enables the AvatarContextMenu for the player.
	When the ACM is enabled in your experience, a user can walk up to another user's character
	and click on them to open a small menu with several default options.

	https://create.roblox.com/docs/players/avatar-context-menu
]]

local StarterGui = game:GetService("StarterGui")
task.wait(3) -- Wait for CoreScripts to register SetCore: AvatarContextMenuEnabled
StarterGui:SetCore("AvatarContextMenuEnabled", true)

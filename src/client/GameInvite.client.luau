--!strict

--[[
	Shows how to use the SocialService to send game invites to friends.
	An icon will appear on the topbar to send game invites when clicked.

	https://create.roblox.com/docs/production/promotion/invite-prompts
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local Players = game:GetService("Players")

local Icon = require(ReplicatedStorage.Icon)
local player = Players.LocalPlayer

-- Function to check whether the player can send an invite
local function canSendGameInvite(sendingPlayer: Player): boolean
	local success: boolean, canSend: boolean = pcall(function(): boolean
		return SocialService:CanSendGameInviteAsync(sendingPlayer)
	end)
	return success and canSend
end

local canInvite: boolean = canSendGameInvite(player)
if canInvite then
	local icon = Icon.new()
	icon:setImage("rbxasset://textures/ui/PlayerList/FriendIcon@3x.png")
	icon:setCaption("Invite Friends")
	icon:setImageScale(0.7)

	icon.selected:Connect(function(): ()
		SocialService:PromptGameInvite(player)
	end)

	SocialService.GameInvitePromptClosed:Connect(function(): ()
        icon:deselect()
    end)
else
	script.Enabled = false

	return
end

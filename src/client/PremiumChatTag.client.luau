--!strict

--[[
	Demonstrates how to add a chat tag to premium members in the game.
	Premium members will have a [Premium] tag in front of their chat messages.

	https://create.roblox.com/docs/production/monetization/engagement-based-payouts#checking-membership
	https://create.roblox.com/docs/chat/customizing-in-experience-text-chat#adding-chat-tags
]]

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

-- Disable the script if the game is not using TextChatService
if TextChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
	script.Enabled = false

	return
end

-- Listen for incoming messages and add a [Premium] tag to premium members
TextChatService.OnIncomingMessage = function(message: TextChatMessage): TextChatMessageProperties
	local properties: TextChatMessageProperties = Instance.new("TextChatMessageProperties")

	-- Check if the message has a source
	if message.TextSource then
		-- Get the player who sent the message
		local player = Players:GetPlayerByUserId(message.TextSource.UserId) :: Player

		-- Check if the player is a premium member
		if player.MembershipType == Enum.MembershipType.Premium then
			-- Add the [Premium] tag to the message
			properties.PrefixText = "<font color='#F5CD30'>[Premium]</font> " .. message.PrefixText
		end
	end

	return properties
end

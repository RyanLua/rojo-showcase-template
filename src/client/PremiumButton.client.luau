--!strict

--[[
	Creates a topbar icon to prompt the player to purchase Roblox Premium.

	https://create.roblox.com/docs/reference/engine/classes/MarketplaceService
]]

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Icon = require(ReplicatedStorage.Packages.topbarplus)

local player = Players.LocalPlayer

local iconImage: string = script:GetAttribute("IconImage") :: string
	or "rbxasset://textures/ui/PlayerList/PremiumIcon@3x.png"
local iconCaption: string = script:GetAttribute("IconCaption") :: string or "Premium"

-- Check if the player is not a premium member
if player.MembershipType ~= Enum.MembershipType.Premium then
	local icon = Icon.new()
	icon:setImage(iconImage)
	icon:setCaption(iconCaption)
	icon:setImageScale(0.6)
	icon:align("Right")

	-- Prompt Roblox Premium purchase when the icon is selected
	icon.selected:Connect(function(): ()
		MarketplaceService:PromptPremiumPurchase(player)
		icon:lock()
	end)

	-- Handle the player's membership change
	Players.PlayerMembershipChanged:Connect(function(): ()
		-- Remove icon if membership type is Premium
		if player.MembershipType == Enum.MembershipType.Premium then
			icon:destroy()
		end
	end)

	-- Unlock the icon when the prompt is closed
	MarketplaceService.PromptPremiumPurchaseFinished:Connect(function(): ()
		icon:deselect()
		icon:unlock()
	end)
end

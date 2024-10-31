--!strict

--[[
	Shows how to use the SocialService to send game invites to friends.
	An icon will appear on the topbar to send game invites when clicked.

	https://create.roblox.com/docs/production/promotion/invite-prompts
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local Players = game:GetService("Players")

local TranslationHelper = require(ReplicatedStorage.TranslationHelper)
local Icon = require(ReplicatedStorage.Packages.topbarplus)
local player = Players.LocalPlayer

local invitePromptMessage: string = script:GetAttribute("InvitePromptMessage") :: string or "Invite friends to join you"
local iconImage: string = script:GetAttribute("IconImage") :: string
	or "rbxasset://textures/ui/PlayerList/FriendIcon@3x.png"
local iconCaption: string = script:GetAttribute("IconCaption") :: string or "Invite Friends"

-- Function to check whether the player can send an invite
local function canSendGameInvite(sendingPlayer: Player): boolean
	local success: boolean, canSend: boolean = pcall(function(): boolean
		return SocialService:CanSendGameInviteAsync(sendingPlayer)
	end)
	return success and canSend
end

-- Check if the player can send a game invite
local canInvite: boolean = canSendGameInvite(player)
if canInvite then
	local inviteOptions: ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")
	inviteOptions.PromptMessage = TranslationHelper.translate(invitePromptMessage, script)

	-- Create the topbar icon
	local icon = Icon.new()
	icon:setImage(iconImage)
	icon:setCaption(TranslationHelper.translate(iconCaption, script))
	icon:setImageScale(0.7)

	-- Handle locale changes
	local onLocaleIdChangedSignal: RBXScriptSignal | false = TranslationHelper.onLocaleIdChanged()

	if onLocaleIdChangedSignal ~= false then
		onLocaleIdChangedSignal:Connect(function(): ()
			inviteOptions.PromptMessage = TranslationHelper.translate(invitePromptMessage, script)
			icon:setCaption(TranslationHelper.translate(iconCaption, script))
		end)
	end

	-- Prompt the game invite when the icon is selected
	icon.selected:Connect(function(): ()
		SocialService:PromptGameInvite(player, inviteOptions)
		icon:lock()
	end)

	-- Deselect the icon when the game invite prompt is closed
	SocialService.GameInvitePromptClosed:Connect(function(): ()
		icon:deselect()
		icon:unlock()
	end)
else
	-- Disable the script if the player cannot send a game invite
	script.Enabled = false

	return
end

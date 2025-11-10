--!strict

--[[
	Creates a topbar icon to open a feedback submission dialog.

	https://create.roblox.com/docs/en-us/reference/engine/classes/SocialService#PromptFeedbackSubmissionAsync
]]

local SocialService = game:GetService("SocialService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Icon = require(ReplicatedStorage.Packages.topbarplus)

local iconImage: string = script:GetAttribute("IconImage") :: string or "rbxasset://textures/ui/Emotes/ErrorIcon.png"
local iconCaption: string = script:GetAttribute("IconCaption") :: string or "Feedback"

local icon = Icon.new()
icon:setImage(iconImage)
icon:setCaption(iconCaption)
icon:setImageScale(1)
icon:oneClick(true)

-- Prompt for feedback when the icon is selected
icon.selected:Connect(function(): ()
	SocialService:PromptFeedbackSubmissionAsync()
end)

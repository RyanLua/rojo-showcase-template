--!strict

--[[
	Demonstrates how to use the ScreenshotHud to capture a screenshot of the game.
	The ScreenshotHud is a 2D user interface that allows users to capture and save screenshots to their local device.
	An icon will appear on the topbar to open the ScreenshotHud when clicked.

	https://create.roblox.com/docs/en-us/reference/engine/classes/ScreenshotHud
]]

local GuiService = game:GetService("GuiService")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local TranslationHelper = require(ReplicatedStorage.TranslationHelper)
local Icon = require(ReplicatedStorage.Packages.topbarplus)
local player = Players.LocalPlayer

local iconImage: string = script:GetAttribute("IconImage") or "rbxasset://textures/ui/ScreenshotHud/Camera@3x.png"
local iconCaption: string = script:GetAttribute("IconCaption") or "Capture"
local closeWhenScreenshotTaken: boolean = script:GetAttribute("CloseWhenScreenshotTaken") or true
local hideCoreGui: boolean = script:GetAttribute("HideCoreGui") or true
local hidePlayerGui: boolean = script:GetAttribute("HidePlayerGui") or true

-- Get the ScreenshotHud
local screenshotHud = GuiService:WaitForChild("ScreenshotHud") :: ScreenshotHud
screenshotHud.CloseWhenScreenshotTaken = closeWhenScreenshotTaken
screenshotHud.HideCoreGuiForCaptures = hideCoreGui
screenshotHud.HidePlayerGuiForCaptures = hidePlayerGui

-- Check if the player is subject to China policies
local success, result = pcall(function()
	return PolicyService:GetPolicyInfoForPlayerAsync(player)
end)

if not success then
	warn("PolicyService error: " .. result)
elseif result.IsSubjectToChinaPolicies then
	script.Enabled = false

	return
end

-- Create the topbar icon
local translatedIconCaption: string = TranslationHelper.translate(iconCaption)
local icon = Icon.new()
icon:setImage(iconImage)
icon:setCaption(translatedIconCaption)
icon:setImageScale(0.7)

-- Change the ScreenshotHud and CoreGuiEnabled when icon is toggled
icon.toggled:Connect(function(isSelected: boolean): ()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, not isSelected)
	Icon.setTopbarEnabled(not isSelected)
	screenshotHud.Visible = isSelected
end)

-- Close the ScreenshotHud when the Roblox coregui escape menu is opened
GuiService.MenuOpened:Connect(function(): ()
	icon:deselect()
end)

-- Deselect the icon if ScreenshotHud is closed or opened
screenshotHud:GetPropertyChangedSignal("Visible"):Connect(function(): ()
	if screenshotHud.Visible == false then
		icon:deselect()
	elseif screenshotHud.Visible == true then
		icon:select()
	end
end)

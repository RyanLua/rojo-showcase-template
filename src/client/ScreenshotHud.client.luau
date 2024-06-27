--!strict

--[[
	Demonstrates how to use the ScreenshotHud to capture a screenshot of the game.
	The ScreenshotHud is a 2D user interface that allows users to capture and save screenshots to their local device.
	An icon will appear on the topbar to open the ScreenshotHud when clicked.

	https://create.roblox.com/docs/en-us/reference/engine/classes/ScreenshotHud
]]

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Icon = require(ReplicatedStorage.Packages.topbarplus)

local iconImage: string = script:GetAttribute("IconImage") or "rbxasset://textures/ui/ScreenshotHud/Camera@3x.png"
local iconCaption: string = script:GetAttribute("IconCaption") or "Capture"
local closeWhenScreenshotTaken: boolean = script:GetAttribute("CloseWhenScreenshotTaken") or true
local nameOverlay: boolean = script:GetAttribute("NameOverlay") or true
local hideCoreGui: boolean = script:GetAttribute("HideCoreGui") or true
local hidePlayerGui: boolean = script:GetAttribute("HidePlayerGui") or true
local overlayFont: Enum.Font = script:GetAttribute("OverlayFont") or Enum.Font.BuilderSansMedium

-- Get the ScreenshotHud
local screenshotHud = GuiService:WaitForChild("ScreenshotHud") :: ScreenshotHud
screenshotHud.CloseWhenScreenshotTaken = closeWhenScreenshotTaken
screenshotHud.ExperienceNameOverlayEnabled = nameOverlay
screenshotHud.HideCoreGuiForCaptures = hideCoreGui
screenshotHud.HidePlayerGuiForCaptures = hidePlayerGui
screenshotHud.OverlayFont = overlayFont

-- Create the topbar icon
local icon = Icon.new()
icon:setImage(iconImage)
icon:setCaption(iconCaption)
icon:setImageScale(0.7)

-- Change the ScreenshotHud and CoreGuiEnabled when icon is toggled
icon.toggled:Connect(function(isSelected: boolean): ()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, not isSelected)
	Icon.setTopbarEnabled(not isSelected)
	GuiService.TouchControlsEnabled = not isSelected
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

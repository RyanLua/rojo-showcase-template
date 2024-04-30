--!strict

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Icon = require(ReplicatedStorage.Icon)

local screenshotHud = GuiService:WaitForChild("ScreenshotHud") :: ScreenshotHud
screenshotHud.ExperienceNameOverlayEnabled = true
screenshotHud.HideCoreGuiForCaptures = true
screenshotHud.HidePlayerGuiForCaptures = true
screenshotHud.OverlayFont = Enum.Font.GothamMedium

-- Create the topbar icon
local icon = Icon.new()
icon:setImage("rbxasset://textures/ui/ScreenshotHud/Camera@3x.png")
icon:setCaption("Capture")
icon:setImageScale(0.7)

-- Change the ScreenshotHud and CoreGuiEnabled when icon is toggled
icon.toggled:Connect(function(isSelected: boolean): ()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, not isSelected)
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

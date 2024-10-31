--!strict

--[[
	Demonstrates how to increase a player's speed when specific inputs are pressed.
	This sample implements left shift to run on keyboard, X to run on gamepad, and a touch button for mobile.
	The input buttons can be modified to any input desired.

	https://create.roblox.com/docs/reference/engine/classes/ContextActionService
	https://create.roblox.com/store/asset/13595087289/Sprint-With-Button
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")

local TranslationHelper = require(ReplicatedStorage.TranslationHelper)

-- Get the player's humanoid
local player = Players.LocalPlayer
local character: Model = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid") :: Humanoid

local SPRINT_ACTION: string = "SprintAction"
local SPRINT_ACTION_TITLE: string = script:GetAttribute("Title") :: string or "Sprint"
local SPRINT_ACTION_DESCRIPTION: string = "Start sprinting."

-- Keep track of the original walkspeed and a multiplier to use for sprinting
local WALK_SPEED: number = humanoid.WalkSpeed
local SPRINT_SPEED_MULTIPLIER: number = script:GetAttribute("WalkSpeedMultiplier") :: number or 2

-- Define buttons to use for sprinting on both keyboard and gamepad
local SPRINT_BUTTON_KEYBOARD: Enum.KeyCode = Enum.KeyCode.LeftShift
local SPRINT_BUTTON_GAMEPAD: Enum.KeyCode = Enum.KeyCode.ButtonX

-- When the player respawns, we need to get new reference to their humanoid
local function onCharacterAdded(newCharacter: any): ()
	humanoid = newCharacter:WaitForChild("Humanoid")
	character = newCharacter
end

local function handleAction(actionName: string, inputState: Enum.UserInputState): ()
	-- Make sure that the SPRINT_ACTION is being handled
	if actionName == SPRINT_ACTION then
		if inputState == Enum.UserInputState.Begin then
			-- If the input is beginning, set the humanoid's WalkSpeed based on SPRINT_SPEED_MULTIPLIER
			humanoid.WalkSpeed = WALK_SPEED * SPRINT_SPEED_MULTIPLIER
		elseif inputState == Enum.UserInputState.End then
			-- If the input is ending, set the humanoid's WalkSpeed back to its default
			humanoid.WalkSpeed = WALK_SPEED
		end
	end
end

-- If the player respawns, we need to handle their new character
player.CharacterAdded:Connect(onCharacterAdded)

-- Bind the keyboard and gamepad buttons to our handleAction function
-- BindAction automatically creates a mobile button to activate this action
ContextActionService:BindAction(SPRINT_ACTION, handleAction, true, SPRINT_BUTTON_KEYBOARD, SPRINT_BUTTON_GAMEPAD)
-- Set the position of the mobile button
ContextActionService:SetPosition(SPRINT_ACTION, UDim2.new(1, -70, 0, 10))
-- Set the title of the mobile button
ContextActionService:SetTitle(SPRINT_ACTION, TranslationHelper.translate(SPRINT_ACTION_TITLE, script))
-- Set the description of the mobile button
ContextActionService:SetDescription(SPRINT_ACTION, SPRINT_ACTION_DESCRIPTION)

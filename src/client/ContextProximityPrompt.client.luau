--!strict

--[[
	Automatically creates a context button for triggering a ProximityPrompt on mobile.

	https://create.roblox.com/docs/input/mobile#context-dependent-inputs
]]

local ContextActionService = game:GetService("ContextActionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")

-- Create the action when the prompt is shown (mobile button)
ProximityPromptService.PromptShown:Connect(function(prompt: ProximityPrompt): ()
	local promptActionName: string = prompt.Name

	-- Don't create a button if the user is not on mobile
	if UserInputService:GetLastInputType() ~= Enum.UserInputType.Touch then
		return
	end

	-- Create the action
	local function handleAction(actionName: string, inputState: Enum.UserInputState): ()
		if actionName == promptActionName then
			if inputState == Enum.UserInputState.Begin then
				prompt:InputHoldBegin()
			else
				prompt:InputHoldEnd()
			end
		end
	end

	-- Bind the action
	ContextActionService:BindAction(promptActionName, handleAction, true)
	ContextActionService:SetPosition(promptActionName, UDim2.new(1, -70, 0, 10))
	ContextActionService:SetImage(promptActionName, "rbxasset://textures/ui/Controls/TouchTapIcon.png")
end)

-- Remove the action when the prompt is hidden
ProximityPromptService.PromptHidden:Connect(function(prompt: ProximityPrompt): ()
	local promptActionName: string = prompt.Name
	ContextActionService:UnbindAction(promptActionName)
end)

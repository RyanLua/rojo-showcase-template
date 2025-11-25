--!strict

--[[
	Automatically creates a ProximityPrompt for each Seat in the workspace.
	When the prompt is triggered, the player will sit in the seat.

	https://create.roblox.com/docs/reference/engine/classes/ProximityPrompt
]]

local CollectionService = game:GetService("CollectionService")

local tag: string = script:GetAttribute("SeatTagName") :: string or "Seat"
local objectText: string = script:GetAttribute("ObjectText") :: string or "Seat"
local actionText: string = script:GetAttribute("ActionText") :: string or "Sit"
local maxActivationDistance: number = script:GetAttribute("MaxActivationDistance") :: number or 5
local maxIndicatorDistance: number = script:GetAttribute("MaxIndicatorDistance") :: number or 10
local holdDuration: number = script:GetAttribute("HoldDuration") :: number or 0
local requiresLineOfSight: boolean = script:GetAttribute("RequiresLineOfSight") :: boolean or false
local disableSeatTouch: boolean = script:GetAttribute("DisableSeatTouch") :: boolean or true

local function onInstanceAdded(object: Instance): ()
	-- Remember that any tag can be applied to any object, so there's no
	-- guarantee that the object with this tag is a BasePart.
	if object:IsA("Seat") and not object.Disabled then
		-- Disable the seat's touch event if specified
		if disableSeatTouch then
			object.CanTouch = false
		end

		-- Create a proximity prompt for the seat
		local seatPrompt: ProximityPrompt = Instance.new("ProximityPrompt")
		seatPrompt.Name = "SeatProximityPrompt"
		seatPrompt.ObjectText = objectText
		seatPrompt.ActionText = actionText
		seatPrompt.MaxActivationDistance = maxActivationDistance
		seatPrompt.MaxIndicatorDistance = maxIndicatorDistance
		seatPrompt.HoldDuration = holdDuration
		seatPrompt.RequiresLineOfSight = requiresLineOfSight
		seatPrompt.Parent = object

		-- Hide the prompt when the seat is occupied
		object:GetPropertyChangedSignal("Occupant"):Connect(function(): ()
			if object.Occupant then
				seatPrompt.Enabled = false
			else
				seatPrompt.Enabled = true
			end
		end)

		-- Sit the player when the prompt is triggered
		seatPrompt.Triggered:Connect(function(player: Player): ()
			local character: Model = player.Character :: Model
			local humanoid: Humanoid = character:WaitForChild("Humanoid") :: Humanoid
			object:Sit(humanoid)
		end)
	end
end

local function onInstanceRemoved(object: Instance): ()
	-- If we made a connection on this object, disconnect it (prevent memory leaks)
	local seatPrompt: ProximityPrompt = object:FindFirstChild("SeatProximityPrompt") :: ProximityPrompt
	if seatPrompt then
		seatPrompt:Destroy()
	end
end

-- Listen for this tag being applied to objects
CollectionService:GetInstanceAddedSignal(tag):Connect(onInstanceAdded)
CollectionService:GetInstanceRemovedSignal(tag):Connect(onInstanceRemoved)

-- Also detect any objects that already have the tag
for _, object: Instance in pairs(CollectionService:GetTagged(tag)) do
	onInstanceAdded(object)
end

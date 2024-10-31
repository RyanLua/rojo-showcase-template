--!strict

--[[
	Disable collisions between Roblox player characters.
	Examples include characters jumping on top of each other to reach specific areas.

	https://create.roblox.com/docs/workspace/collisions#disabling-character-collisions
]]

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

PhysicsService:RegisterCollisionGroup("Characters")
PhysicsService:CollisionGroupSetCollidable("Characters", "Characters", false)

local function onDescendantAdded(descendant: Instance): ()
	-- Set collision group for any part descendant
	if descendant:IsA("BasePart") then
		descendant.CollisionGroup = "Characters"
	end
end

local function onCharacterAdded(character: Model): ()
	-- Process existing and new descendants for physics setup
	for _, descendant: Instance in character:GetDescendants() do
		onDescendantAdded(descendant)
	end
	character.DescendantAdded:Connect(onDescendantAdded)
end

Players.PlayerAdded:Connect(function(player: Player): ()
	-- Detect when the player's character is added
	player.CharacterAdded:Connect(onCharacterAdded)
end)

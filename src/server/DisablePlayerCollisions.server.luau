--!strict

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

PhysicsService:RegisterCollisionGroup("Characters")
PhysicsService:CollisionGroupSetCollidable("Characters", "Characters", false)

local function onDescendantAdded(descendant)
	-- Set collision group for any part descendant
	if descendant:IsA("BasePart") then
		descendant.CollisionGroup = "Characters"
	end
end

local function onCharacterAdded(character)
	-- Process existing and new descendants for physics setup
	for _, descendant in character:GetDescendants() do
		onDescendantAdded(descendant)
	end
	character.DescendantAdded:Connect(onDescendantAdded)
end

Players.PlayerAdded:Connect(function(player)
	-- Detect when the player's character is added
	player.CharacterAdded:Connect(onCharacterAdded)
end)

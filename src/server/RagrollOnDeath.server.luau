--!strict

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player: Player): ()
	player.CharacterAdded:Connect(function(character: Model): ()
		local humanoid = character:FindFirstChild("Humanoid") :: Humanoid

		humanoid.BreakJointsOnDeath = false

		humanoid.Died:Connect(function(): ()
			for _, joint in character:GetDescendants() do
				if joint:IsA("AnimationConstraint") then
					joint.Enabled = false
				elseif joint:IsA("BallSocketConstraint") then
					joint.MaxFrictionTorque = 10
				end
			end
		end)
	end)
end)

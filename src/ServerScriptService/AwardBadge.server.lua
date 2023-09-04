local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local BADGE_ID = script:GetAttribute("BadgeId") or 0

local function awardBadge(player, badgeId)
	-- Fetch badge information
	local infoSuccess, badgeInfo = pcall(function()
		return BadgeService:GetBadgeInfoAsync(badgeId)
	end)

	-- Check if the player has the badge
	local userSuccess, hasBadge = pcall(function()
		return BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
	end)

	if hasBadge then
		-- Handle player's badge ownership as needed
		print("User already has badge", badgeId)
		return
	end

	if infoSuccess and userSuccess then
		-- Confirm that badge can be awarded
		if badgeInfo.IsEnabled then
			-- Award badge
			local awardSuccess, result = pcall(function()
				return BadgeService:AwardBadge(player.UserId, badgeId)
			end)

			if not awardSuccess then
				-- the AwardBadge function threw an error
				warn("Error while awarding badge:", result)
			elseif not result then
				-- the AwardBadge function did not award a badge
				warn("Failed to award badge", badgeId)
			end
		end
	else
		warn("Error while fetching badge info: ", badgeInfo)
	end
end

local function onPlayerAdded(player)
	awardBadge(player, BADGE_ID)
end

Players.PlayerAdded:Connect(onPlayerAdded)

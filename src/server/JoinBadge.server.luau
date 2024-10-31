--!strict

--[[
	A script that awards a badge to a player when they join the game.
	To use this script, set the BadgeId attribute to the ID of the badge you want to award.
	This script will disable itself if no badge ID is set and won't error.

	https://create.roblox.com/docs/production/publishing/badges#awarding-badges
]]

local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local BADGE_ID: number = script:GetAttribute("BadgeId") :: number or 0

-- If no badge ID is set then don't do anything
if BADGE_ID == 0 then
	script.Enabled = false
	return
end

local function awardBadge(player: Player, badgeId: number): ()
	-- Fetch badge information
	local infoSuccess: boolean, badgeInfo: any = pcall(function(): any
		return BadgeService:GetBadgeInfoAsync(badgeId)
	end)

	-- Check if the player has the badge
	local userSuccess: boolean, hasBadge: boolean = pcall(function(): boolean
		return BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
	end)

	if hasBadge then
		-- Handle player's badge ownership as needed
		-- print("User already has badge", badgeId)
		return
	end

	if infoSuccess and userSuccess then
		-- Confirm that badge can be awarded
		if badgeInfo.IsEnabled then
			-- Award badge
			local awardSuccess: boolean, result: boolean = pcall(function(): boolean
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

local function onPlayerAdded(player: Player): ()
	awardBadge(player, BADGE_ID)
end

Players.PlayerAdded:Connect(onPlayerAdded)

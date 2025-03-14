--!strict

--[[
	A callback to process when a call is placed from the phone book.

	https://create.roblox.com/docs/reference/engine/classes/SocialService
	https://create.roblox.com/docs/reference/engine/classes/TeleportService
]]

local SocialService = game:GetService("SocialService")
local TeleportService = game:GetService("TeleportService")

SocialService.OnCallInviteInvoke = function(): any
	local placeId: number = game.PlaceId -- This is the place ID of the desired place to drop call participants into
	local accessCode: string = TeleportService:ReserveServer(placeId)

	return { ReservedServerAccessCode = accessCode, PlaceId = placeId }
end

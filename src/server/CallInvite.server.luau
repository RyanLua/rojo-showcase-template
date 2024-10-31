local SocialService = game:GetService("SocialService")
local TeleportService = game:GetService("TeleportService")

SocialService.OnCallInviteInvoked = function()
	local placeId: number = 5813911804 -- This is the place ID of the desired place to drop call participants into
	local accessCode: string = TeleportService:ReserveServer(placeId)

	return { ReservedServerAccessCode = accessCode, PlaceId = placeId }
end

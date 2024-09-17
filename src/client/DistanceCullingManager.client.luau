--!strict

--[[
	A very simple distance culling system
	This simplified code only handles static geometry with no animation effects
	It also smears the update over a few frames, only doing 50 distance checks a frame max, and only after the camera has moved a bit
	It expects to work with models that have primary parts set up

	https://devforum.roblox.com/t/3127146
]]

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local details = {}
local lastCell = nil
local pendingUpdate: boolean = true
local updating: boolean = false

local cullTag: string = "DistanceCullable"

function AddDetail(instance)
	task.spawn(function(): ()
		local record = {}

		record.cullDistance = script:GetAttribute("CullingDistance") or 250
		record.instance = instance
		record.primaryPart = instance
		record.visible = true
		record.parent = instance.Parent

		if instance:IsA("Folder") then
			--Because of replication, we might have to wait around here for a part to spawn in
			while true do
				record.primaryPart = instance:FindFirstChildWhichIsA("BasePart", true)
				if record.primaryPart == nil then
					wait()
				else
					break
				end
			end
		end

		if instance:IsA("Model") then
			while true do
				record.primaryPart = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
				if record.primaryPart == nil then
					wait()
				else
					break
				end
			end
		end

		if record.primaryPart == nil then
			warn("Couldnt find a way to track " .. instance.Name)
			return
		end

		local dist = record.instance:GetAttribute("distance")
		if dist ~= nil then
			record.cullDistance = dist
		end

		details[instance] = record
	end)
end

function Setup(): ()
	CollectionService:GetInstanceAddedSignal(cullTag):Connect(function(instance): ()
		AddDetail(instance)
	end)
	for _, instance in CollectionService:GetTagged(cullTag) do
		AddDetail(instance)
	end
end
Setup()

RunService.Heartbeat:Connect(function(): ()
	--See if we have a player and a distance check
	local player = game.Players.LocalPlayer

	local character = player.Character

	if character == nil or character.PrimaryPart == nil then
		return
	end

	local position = character.PrimaryPart.Position

	local cellSize = 4
	local cell = position // cellSize
	if cell ~= lastCell then
		lastCell = cell

		pendingUpdate = true
	end

	if pendingUpdate == true and updating == false then
		updating = true
		pendingUpdate = false
		task.spawn(function()
			local counter = 0
			for _, record in details do
				local vector = record.primaryPart.Position - position
				local magnitude = vector.Magnitude

				if magnitude < record.cullDistance and record.visible == false then
					record.instance.Parent = record.parent
					record.visible = true
					continue
				end
				if magnitude >= record.cullDistance and record.visible == true then
					record.instance.Parent = nil
					record.visible = false
				end

				--smear the update over multiple frames
				counter += 1
				if counter > 50 then
					wait()
					counter = 0
				end
			end
			updating = false
		end)
	end
end)

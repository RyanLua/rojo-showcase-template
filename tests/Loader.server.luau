--!strict

--[[
    Loader to properly load the client and server scripts.
    This script will move the scripts to the correct location in the game.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts")

local folder = script.Parent
local shared = folder:WaitForChild("ReplicatedStorage")
local client = folder:WaitForChild("StarterPlayerScripts")
local server = folder:WaitForChild("ServerScriptService")

for _, script in ipairs(shared:GetChildren()) do
    script.Parent = ReplicatedStorage
end

for _, script in ipairs(client:GetChildren()) do
    script.Parent = StarterPlayerScripts
end

for _, script in ipairs(server:GetChildren()) do
    script.Parent = ServerScriptService
end

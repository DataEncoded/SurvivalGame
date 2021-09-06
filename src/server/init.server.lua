print("Hello world, from server!")

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Player = require(ReplicatedStorage.Common.Player);
local Weapon = require(ReplicatedStorage.Common.Weapon);

--Logic for when a new player joins
local players = {};

local playerJoinedConnection = Players.PlayerAdded:Connect(function(p)
    local player = Player.new(p);

    players[p] = player;

end);

local playerLeftConnection = Players.PlayerRemoving:Connect(function(p)
    players[p]:Destroy();
    players[p] = nil;
end)


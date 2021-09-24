print("Hello world, from server!")

local Players = game:GetService("Players");
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Player = require(script.Player);
local Weapon = require(script.Weapon);
local Pistol = require(script.Weapon.Pistol);

--Logic for when a new player joins
local players = {};

local playerJoinedConnection = Players.PlayerAdded:Connect(function(p)
    local player = Player.new(p);

    players[p] = player;

    --task.wait(3);
    --local pistol  = Pistol.new();

    --player:addItem(pistol);
    --player:equipItem(pistol);

end);

local playerLeftConnection = Players.PlayerRemoving:Connect(function(p)
    players[p]:Destroy();
    players[p] = nil;
end)


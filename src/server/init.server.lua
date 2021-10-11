print("Hello world, from server!")

local Players = game:GetService("Players");
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local remotes = ReplicatedStorage.Remotes;
local getAmmo = remotes.GetAmmo;
local shoot = remotes.Shoot
local Player = require(script.Player);
local Weapon = require(script.Weapon);
local serverItem = require(script.ServerItem);
local Pistol = require(script.Weapon.Pistol);

--Logic for when a new player joins
local players = {};

local function getAmmoInvoke(player, GUID)
    if player and GUID and serverItem.getItemFromGUID(GUID) and table.find(players[player]["inventory"], serverItem.getItemFromGUID(GUID)) and serverItem.getItemFromGUID(GUID)["ammo"] then
        return serverItem.getItemFromGUID(GUID)["ammo"];
    else
        return nil;
    end
end

getAmmo.OnServerInvoke = getAmmoInvoke;

local playerJoinedConnection = Players.PlayerAdded:Connect(function(p)
    local player = Player.new(p);

    players[p] = player;

    task.wait(3);
    local pistol  = Pistol.new();

    player:addItem(pistol);
    player:equipItem(pistol);

end);

local playerLeftConnection = Players.PlayerRemoving:Connect(function(p)
    players[p]:Destroy();
    players[p] = nil;
end)

local shootConnection = shoot.OnServerEvent:Connect(function(player, hitPos)
    if player and players[player] and players[player]["currentItem"] and hitPos and typeof(hitPos) == "Vector3" then

        players[player]:playerClicked(hitPos);

    end
end)
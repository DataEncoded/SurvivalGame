-- A player module for holding player's for pseudo-tools and other states
local playerModule = {};
playerModule.__index = playerModule;

local fastCast = require(script.Parent.FastCastRedux);
local weaponModule = require(script.Parent.Weapon);

function playerModule.new(player)

    assert(player and player.Name and game.Players:FindFirstChild(player.Name) == player, "[Player Class] Player has to be passed as an argument.")
    
    local self = {};
    setmetatable(self, playerModule);

    self.player = player;

    --Define logic for first time character set up, and then a connection for when a newcharacter is loaded for the player.
    if player.Character then
        self.character = player.Character;
    end

    self.characterConnection = self.player.CharacterAdded:Connect(function(c)
        self.character = c;
    end)

    --Logic for the weapon system
    self.caster = fastCast.new();
    self.weapon = nil;
    self.inventory = {};

    return self;
end

function playerModule:playerClicked(hit) 
    if self.weapon then
        local newHitPosition = Vector3.new(hit.p.X, self.weapon.fireAttachment.WorldPosition.Y, hit.p.Z);

        self.weapon:fire(newHitPosition, self.caster);
    end
end

return playerModule;
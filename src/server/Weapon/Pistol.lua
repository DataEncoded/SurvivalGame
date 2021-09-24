local constructor = {}

local Weapon = require(script.Parent);
local ServerStorage = game:GetService("ServerStorage")
local WeaponModels = ServerStorage.Weapons;

function constructor.new()
    return Weapon.new("Pistol", 15, 10, 0.1, 1, WeaponModels.Pistol, 100, 1)
end

return constructor;
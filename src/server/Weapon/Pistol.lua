local constructor = {}

local Weapon = require(script.Parent);
local ServerStorage = game:GetService("ServerStorage")
local WeaponModels = ServerStorage.Weapons;

function constructor.new()
    --weaponName, damage, ammo, debounceTime, reloadTime, model, maximumDistance, bulletSpeed
    return Weapon.new("Pistol", 15, 10, 0.1, 1, WeaponModels.Pistol, 100, 300)
end

return constructor;
local ClientWeapon = {};
ClientWeapon.__index = ClientWeapon;

local InventoryButtonClass = require(script.Parent.InventoryButtonClass)

function ClientWeapon.new(name, UUID, ammo, maxAmmo, slot, imageId)
    local self = {};
    setmetatable(self, ClientWeapon);

    self.frame = InventoryButtonClass.new(slot, imageId);
    self.name = name;
    self.UUID = UUID;
    self.ammo = ammo;
    self.maxAmmo = maxAmmo;

    return self;
end

return ClientWeapon;
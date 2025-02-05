-- A weapon weapon with the purpose of being a superclass for pseudo tools
local weapon = {};
weapon.__index = weapon;

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fastCast = require(ReplicatedStorage.Common.FastCastRedux);
fastCast.VisualizeCasts = true;
local item = require(script.Parent.ServerItem);

local function fireAttachmentExists(accessory)
    local parts = accessory:GetDescendants();

    for _, part in ipairs(parts) do
        if part:IsA("Attachment") and part.Name == "FireAttachment" then
            return part;
        end
    end
    return false;
end

--Create new weapon
function weapon.new(weaponName, damage, ammo, debounceTime, reloadTime, model, maximumDistance, bulletSpeed)
    assert(fireAttachmentExists(model), "[Weapon Class] Model doesn't have FireAttachment.")

    local self = item.new(weaponName, model, 1);
    setmetatable(self, weapon);

    --Assign attributes
    self.itemType = "Weapon";
    self.damage = damage;
    self.maxAmmo = ammo;
    self.ammo = ammo;
    self._debounce = false;
    self.cooldown = debounceTime;
    self.reloading = false;
    self.reloadTime = reloadTime;
    self.fireAttachment = fireAttachmentExists(self.model);

    self._castBehavior = fastCast.newBehavior();
    self._castBehavior.Acceleration = Vector3.new();
    self._castBehavior.AutoIgnoreContainer = true;
    self._castBehavior.MaxDistance = maximumDistance;
    self.speed = bulletSpeed;

    return self;
end

function weapon:equip(humanoid)
    humanoid:AddAccessory(self.model);
end

function weapon:unequip()
    self.reloading = false;
    self.model.Parent = nil;
end

function weapon:reload()
    coroutine.wrap(function() --Create and run coroutine
        if not self.reloading then
            self.reloading = true;

            for _ = 1, self.reloadingTime * 50 do
                if self.reloading then
                    task.wait(0.05); --Run 50 times every second to determine if reloading has stopped. 
                else
                    return;
                end
            end

            --Reloading completed.
            self.ammo = self.maxAmmo;
            self.reloading = false;

        end
    end)();
end




function weapon:fire(firePosition, caster)
    if not self.reloading and not self._debounce and self.ammo > 0 then
        --Figure out the angle and start of the raycast.
        local fireAttachment = self.fireAttachment.WorldPosition;
        local direction = (firePosition - fireAttachment).Unit;
        --Use fast cast to cast.
        caster:Fire(fireAttachment, direction, self.speed, self._castBehavior); --Multiply the direction here? Unsure since fastcast has maximumDistance parameter in castbehavior
        --Post gun fire logic
        self.ammo -= 1;
        self:fireDebounce();
    end;

end

local function cooldown(self) --Create a local function in order to not create a new anonymous function every time with fire debounce.
    self._debounce = true;
    wait(self.cooldown);
    self._debounce = false;
end

function weapon:fireDebounce()
    coroutine.wrap(cooldown)(self); --Use a seperate function to not create needless anonymous functions.
end

function weapon:Destroy()
    item.Destroy(self);

    --Clear other attributes
    self.damage = nil;
    self.maxAmmo = nil;
    self.ammo = nil;
    self._debounce = nil;
    self.cooldown = nil;
    self.reloading = nil;
    self.reloadTime = nil;
    self.reloadingRoute = nil;
    self._castBehavior = nil;
    self.speed = nil;
    self.fireAttachment:Destroy();
    self.fireAttachment = nil;


    --Unset metatable
    setmetatable(self, nil);

end

return weapon;
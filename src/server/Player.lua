-- A player module for holding player's for pseudo-tools and other states
local playerModule = {};
playerModule.__index = playerModule;

local fastCast = require(script.Parent.FastCastRedux);
local weaponModule = require(script.Parent.Weapon);
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function playerModule.new(player)

    assert(player and player.Name and game.Players:FindFirstChild(player.Name) == player, "[Player Class] Player has to be passed as an argument.")
    
    local self = {};
    setmetatable(self, playerModule);

    self.player = player;

    --Define logic for first time character set up, and then a connection for when a newcharacter is loaded for the player.
    if player.Character then
        self.character = player.Character;
    end

    --logic for item system
    self.raycastParms = RaycastParams.new();
    self.raycastParms.FilterType = Enum.RaycastFilterType.Blacklist;
    self.raycastParms.FilterDescendantsInstances = {self.character}

    self.characterConnection = self.player.CharacterAdded:Connect(function(c) --Character connection for when player resets
        self.character = c;
        self.raycastParms.FilterDescendantsInstances = {self.character}
    end)


    --Logic for the weapon system
    self.caster = fastCast.new();
    self.currentItem = nil;
    self.inventory = {};

    return self;
end

function playerModule:equipItem(item)
    assert(item and item.type == "item", "[Player Class] Equip item function must have an actual item given.")
    local humanoid =  self.character:FindFirstChild("Humanoid");

    assert(humanoid, "[Player Class] Player must have a humanoid to equip an item.");

    for _, v in ipairs(self.inventory) do
        if v == item then
            --Item found, equip
            v:equip(humanoid);
            self.currentItem = v;
        end
    end

end

function playerModule:addItem(item) --Wrapper add and delete function for adding items to inventory
    assert(item and item.type == "item", "[Player Class] Add item function must have an actual item given.")

    if #self.inventory < 5 then
        item.model.Parent = ReplicatedStorage;

        table.insert(self.inventory, 1, item);
    end

end

function playerModule:dropItem(item)
    assert(item and item.type == "item", "[Player Class] Drop item function must have an actual item given.")

    for i, v in ipairs(self.inventory) do
        if v == item then
            --Item match
            --Logic for placing item on the ground
            if not self.Character.HumanoidRootPart then
                item:Destroy();
                error("[PlayerModule] Player attempted to drop an item without a HumanoidRootPart, escaping.")
            end
            --Raycast below player to see where to drop
            local rayResult = workspace:Raycast(self.Character.HumanoidRootPart.Position, (self.Character.HumanoidRootPart.Position - Vector3(0,1,0)).Unit);

            local dropPosition;

            if rayResult then
                dropPosition = rayResult.Position;
            else
                dropPosition = self.Character.HumanoidRootPart.Position;
            end

            item.model:SetPrimaryPartCFrame(CFrame.new(dropPosition, self.Character.HumanoidRootPart.Position));

            item.model.Parent = workspace;

            table.remove(self.inventory, i);

        end
    end


end

function playerModule:playerClicked(hit) --Custom click logic for psuedotool. Hit is a CFrame
    if self.weapon then
        local newHitPosition = Vector3.new(hit.p.X, self.weapon.fireAttachment.WorldPosition.Y, hit.p.Z);

        self.weapon:fire(newHitPosition, self.caster, self.raycastParms);
    end
end

function playerModule:Destroy()
    
    self.player = nil;
    self.character = nil;
    self.raycastParams = nil;

    self.characterConnection:Disconnect();
    self.characterConnection = nil;

    self.caster = nil; --Apparently this should be garbage collected according to eti

    self.raycastParms = nil;

    self.currentItem = nil;

    for i, v in ipairs(self.inventory) do
       v:Destroy();
       self.inventory[i] = nil; 
    end

    self.inventory = nil;

    setmetatable(self, nil);

end

return playerModule;
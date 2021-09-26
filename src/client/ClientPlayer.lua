local ClientPlayer = {};
ClientPlayer.__index = ClientPlayer;

local player = game.Player.LocalPlayer
local playerGui = player.PlayerGui

local HUD = playerGui.HUD
local inventorySlots = HUD.Main.InventorySlots

local ClientWeapon = require(script.Parent.ClientWeapon)
local ItemDatabase = require(script.Parent.ItemDatabase)

local getAmmo = game:GetService("ReplicatedStorage").Remotes.GetAmmo

local function getFrames()
    local frames = {};

    for _, frame in ipairs(playerGui.HUD.Main.InventorySlots:GetChildren()) do
        if frame:IsA("Frame") then
            table.insert(frames, frame)
        end
    end

    return frames;
end

function ClientPlayer.new()
    local self = {};
    setmetatable(self, ClientPlayer);

    self.inventory = {};
    self.inventoryFrames = getFrames();
    self.activeWeapon = nil;

    return self;
end

function ClientPlayer:NewWeapon(name, UUID)

    if #self.inventory < 5 then
        local ammo = getAmmo:InvokeServer(UUID);
        if ammo then 
            local slot 
            for _, v in ipairs(inventorySlots:GetChildren()) do
                if v:IsA("Frame") and v.SlotText.Text == "Empty" then
                    slot = v
                end
            end

            local weapon = ClientWeapon.new(name, UUID, getAmmo:InvokeServer(UUID), ItemDatabase[name].maxAmmo, slot, ItemDatabase[name].imageId)
            if weapon then
                table.insert(self.inventory, weapon)
            end
        end
    end

end

function ClientPlayer:EquipWeapon(slot)

    local equipping = inventorySlots:FindFirstChild(slot)
    for _, v in ipairs(self.inventory) do
        if v.frame.slotFrame == equipping then

        end
    end

end

return ClientPlayer;
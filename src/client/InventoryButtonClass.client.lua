local InventoryButtonClass = {};
InventoryButtonClass.__index = InventoryButtonClass;

function InventoryButtonClass.new(slotFrame, slotImageId)
    local self = {};
    setmetatable(self, InventoryButtonClass);

    self.slotFrame = slotFrame;
    self.slotFrame.slotImage.Image = slotImageId;
    --self.slotFrame.slotText.Text = ammoCount;

    return self;
end

function InventoryButtonClass:Equip()
    self.slotFrame.BackgroundColor3 = Color3.new(255, 255, 0)
end

function InventoryButtonClass:UnEquip()
    self.slotFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end

return InventoryButtonClass;
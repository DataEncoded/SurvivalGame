local item = {};
item.__index = item;

function item.new(itemName, model, maxStackSize)
    local self = {};
    setmetatable(self, item);

    self.Name = itemName;
    self.type = 'item';
    self.model = model:Clone();
    self.maxStackSize = maxStackSize;
    self.stackSize = 0;

    return self;
end

function item:Destroy()
    --Clear attributes and then clear metatable.
    self.Name = nil;
    self.type = nil;
    self.maxStackSize = nil;
    self.stackSize = nil;

    --Clear model
    self.model:Destroy();
    self.model = nil;

    setmetatable(self, nil);
end

return item;
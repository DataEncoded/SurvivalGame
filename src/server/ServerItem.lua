local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local common = ReplicatedStorage.Common;
local item = require(common.Item);
local HttpService = game:GetService("HttpService");

--A table with the purpose of holding GUID's with serverItem given
local itemTable = setmetatable({}, {__mode = "k"});

local server = {};
server.__index = server;

setmetatable(server, item);

function server.new(itemName, model, maxStackSize)
    local self = item.new(itemName, model, maxStackSize)
    setmetatable(self, server);

    local GUID;

    while not GUID or itemTable[GUID] do
        GUID = HttpService:GenerateGUID(false);
    end

    self.GUID = GUID;

    itemTable[GUID] = self;

    return self;
end

--Create static getter function to protect itemTable, alternative is proxy metatable but ehhh.
function server.getItemFromGUID(GUID)
    return itemTable[GUID];
end

function server:Destroy()
    self.GUID = nil;

    item.Destroy(self);

    setmetatable(self, nil);

end



return server;
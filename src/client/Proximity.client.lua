local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")

ProximityPromptService.PromptTriggered:Connect(function (prompt)

    if prompt.Name == "PickUp" then
        -- Send event to server to pick up
    end

end)
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes

local Shoot = Remotes:WaitForChild("Shoot")
local Reload = Remotes:WaitForChild("Reload")
local NewWeapon = Remotes:WaitForChild("NewWeapon")

UserInputService.InputBegan:Connect(function (input, gpe)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        
    end
end)

UserInputService.InputEnded:Connect(function (input, gpe)

end)
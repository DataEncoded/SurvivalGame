local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local Shoot = Remotes:WaitForChild("Shoot")
local Reload = Remotes:WaitForChild("Reload")
local NewWeapon = Remotes:WaitForChild("NewWeapon")

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local held = false

UserInputService.InputBegan:Connect(function (input, gpe)

    

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        


        local mouseLocation = UserInputService:GetMouseLocation()
        local ray = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
        local raycast = workspace:Raycast(ray.Origin, ray.Direction * 100)

        --[[if raycast then
            local part = Instance.new("Part")
            part.Anchored = true
            part.Position = raycast.Position
            part.Parent = workspace
        end]]

        if raycast then
            Shoot:FireServer(raycast.Position)
        end

    end

end)

UserInputService.InputEnded:Connect(function (input, gpe)

end)
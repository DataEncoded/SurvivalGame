--Cleaned up :) -WithinCode

local run = game:GetService("RunService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

--Create a bunch of variables to be changed later on
local character = nil;
local align, attachment0, attachment1;
local humanoidRootPart;

local characterConnection = player.CharacterAdded:Connect(function(c)
	--Create attachment when new player added
	character = c;
	
	align = Instance.new("AlignOrientation", player:FindFirstChild("HumanoidRootPart"))
	align.MaxTorque = 10000000
	align.Responsiveness = 200
	align.PrimaryAxisOnly = true

	attachment0 = Instance.new("Attachment")

	attachment1 = Instance.new("Attachment")

	align.Attachment0 = attachment0
	align.Attachment1 = attachment1


	humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	--Create attachment parents to where stuff will be moved
	attachment0.Parent = humanoidRootPart
	attachment1.Parent = workspace.Terrain
	align.Parent = humanoidRootPart



end)

run.RenderStepped:Connect(function()

	if player and humanoidRootPart and mouse.Hit then

		--Do calculations for where they are

		local mousePos = mouse.Hit.Position

		local finalAngle = CFrame.new(humanoidRootPart.Position, Vector3.new(mousePos.X, humanoidRootPart.Position.Y, mousePos.Z))

		--Update attachment position

		attachment1.CFrame = finalAngle
	end
end)
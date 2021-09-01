--Whole thing really messes, should be cleaned up but im too lazy at this point.

local run = game:GetService("RunService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

run.RenderStepped:Connect(function()
	local player = game.Players.LocalPlayer.Character

	if player then
		local align = player:FindFirstChild("HumanoidRootPart"):FindFirstChild("AlignOrientation")
		local attachment0 = player:FindFirstChild("HumanoidRootPart"):FindFirstChild("Attachment")
		local attachment1 = workspace.Terrain:FindFirstChild("Attachment")

		if not align then
			align = Instance.new("AlignOrientation", player:FindFirstChild("HumanoidRootPart"))
			align.MaxTorque = 10000000
			align.Responsiveness = 200
			align.PrimaryAxisOnly = true
		end

		if not attachment0 then
			attachment0 = Instance.new("Attachment", player:FindFirstChild("HumanoidRootPart"))
		end

		if not attachment1 then
			attachment1 = Instance.new("Attachment", workspace.Terrain)
		end			


		if align.Attachment0 ~= attachment0 then
			align.Attachment0 = attachment0
		end
		if align.Attachment1 ~= attachment1 then
			align.Attachment1 = attachment1
		end

		local mouse = game.Players.LocalPlayer:GetMouse()	

		local mousePos = mouse.Hit.Position			

		local finalAngle = CFrame.new(player.HumanoidRootPart.Position, Vector3.new(mousePos.X, player.HumanoidRootPart.Position.Y, mousePos.Z))

		attachment0.WorldCFrame = player:FindFirstChild("HumanoidRootPart").CFrame
		attachment1.CFrame = finalAngle
		attachment1.WorldOrientation = Vector3.new(attachment1.WorldOrientation.X, attachment1.WorldOrientation.Y, attachment1.WorldOrientation.Z)
	end
end)
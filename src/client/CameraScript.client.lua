-- Creates a top-down view of the player using the Camera

local RunService = game:GetService("RunService")

local camera = workspace.CurrentCamera -- Camera object
local player = game.Players.LocalPlayer -- Player objects

local CAMERA_OFFSET = Vector3.new(-1, 90, 0) -- Constant used to set offset of the camera from the player

while camera.CameraSubject == nil do
	wait()
end

camera.CameraType = Enum.CameraType.Scriptable

local function onRenderStep()
    if player.Character then
		local playerPosition = player.Character.HumanoidRootPart.Position
		local cameraPosition = playerPosition + CAMERA_OFFSET
		
		camera.CFrame = CFrame.new(cameraPosition, playerPosition)	-- Makes the camera follow the player
	end
end

RunService:BindToRenderStep("Camera", Enum.RenderPriority.Camera.Value, onRenderStep)
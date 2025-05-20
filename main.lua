local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local bv

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        flying = not flying
        if flying then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(0,0,0)
            bv.Parent = hrp
        else
            if bv then
                bv:Destroy()
                bv = nil
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if flying and bv then
        local direction = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        direction = Vector3.new(direction.X, 0, direction.Z).Unit * speed
        bv.Velocity = Vector3.new(direction.X, 0, direction.Z)
    end
end)

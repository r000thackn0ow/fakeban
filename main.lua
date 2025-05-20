local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 50

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local bodyVelocity

function startFly()
    if flying then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent = character.HumanoidRootPart
end

function stopFly()
    if not flying then return end
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

local direction = Vector3.new(0, 0, 0)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.T then -- Tekan T untuk toggle terbang
        if flying then
            stopFly()
            humanoid.PlatformStand = false
        else
            humanoid.PlatformStand = true
            startFly()
        end
    end
end)

userInputService.InputChanged:Connect(function(input, gameProcessed)
    if not flying then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local camCFrame = workspace.CurrentCamera.CFrame
        local lookVector = camCFrame.LookVector
        direction = Vector3.new(0,0,0)
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            local left = camCFrame.RightVector:Cross(Vector3.new(0,1,0))
            direction = direction - Vector3.new(left.X, 0, left.Z).Unit
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            local right = workspace.CurrentCamera.CFrame.RightVector
            direction = direction + Vector3.new(right.X, 0, right.Z).Unit
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0,1,0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0,1,0)
        end
    end
end)

runService.RenderStepped:Connect(function()
    if flying and bodyVelocity then
        if direction.Magnitude > 0 then
            bodyVelocity.Velocity = direction.Unit * speed
        else
            bodyVelocity.Velocity = Vector3.new(0,0,0)
        end
    end
end)

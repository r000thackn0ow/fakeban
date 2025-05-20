local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", gui)
screenGui.Name = "FakeBanGui"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 0, 0)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.Code
textLabel.Text = "⚠️ You have been permanently banned for exploiting."
textLabel.Parent = frame

local sound = Instance.new("Sound", screenGui)
sound.SoundId = "rbxassetid://9118823106"
sound.Volume = 2
sound:Play()

wait(4)
textLabel.TextColor3 = Color3.new(0, 1, 0)
textLabel.Text = "🤣 Just kidding! You found an easter egg!"

wait(2)
screenGui:Destroy()

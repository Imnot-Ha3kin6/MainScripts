local function createRemoteEventsGUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "RemoteEventsGUI"

    -- Create Main Frame
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Create Title Bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleBar.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Text = "Remote Event Finder"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24

    -- Create UIGradient for main frame
    local gradient = Instance.new("UIGradient", mainFrame)
    gradient.Color = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(100, 100, 100))
    gradient.Rotation = 90

    -- Create ScrollingFrame
    local scrollingFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollingFrame.Size = UDim2.new(1, 0, 1, -110)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    -- Create UIListLayout
    local uiListLayout = Instance.new("UIListLayout", scrollingFrame)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 10)

    -- Create Info Frame
    local infoFrame = Instance.new("Frame", mainFrame)
    infoFrame.Size = UDim2.new(1, 0, 0, 60)
    infoFrame.Position = UDim2.new(0, 0, 1, -60)
    infoFrame.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    infoFrame.BorderSizePixel = 0

    -- Create RemoteEvent Count Label
    local remoteEventCountLabel = Instance.new("TextLabel", infoFrame)
    remoteEventCountLabel.Size = UDim2.new(0.5, 0, 1, 0)
    remoteEventCountLabel.Text = "RemoteEvents: 0"
    remoteEventCountLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    remoteEventCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    remoteEventCountLabel.Font = Enum.Font.SourceSans
    remoteEventCountLabel.TextSize = 24

    -- Create Time Label
    local timeLabel = Instance.new("TextLabel", infoFrame)
    timeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
    timeLabel.Text = "Time: 0s"
    timeLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.Font = Enum.Font.SourceSans
    timeLabel.TextSize = 24

    -- Create Resizer
    local resizer = Instance.new("Frame", mainFrame)
    resizer.Size = UDim2.new(0, 20, 0, 20)
    resizer.Position = UDim2.new(1, -20, 1, -20)
    resizer.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    resizer.BorderSizePixel = 0
    resizer.Active = true
    resizer.Draggable = true

    -- Create Circular Toggle Button Frame
    local toggleButtonFrame = Instance.new("Frame", screenGui)
    toggleButtonFrame.Size = UDim2.new(0, 50, 0, 50)
    toggleButtonFrame.Position = UDim2.new(0, 10, 0, 10)
    toggleButtonFrame.BackgroundTransparency = 1

    -- Create Circular Toggle Button
    local toggleButton = Instance.new("ImageButton", toggleButtonFrame)
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.Image = "rbxassetid://6531587958"
    toggleButton.BackgroundTransparency = 1

    toggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Create "Toggle UI" Button
    local toggleUIButton = Instance.new("TextButton", screenGui)
    toggleUIButton.Size = UDim2.new(0, 150, 0, 50)
    toggleUIButton.Position = UDim2.new(0, 70, 0, 10)
    toggleUIButton.Text = "Toggle UI"
    toggleUIButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleUIButton.Font = Enum.Font.SourceSans
    toggleUIButton.TextSize = 24
    toggleUIButton.AutoButtonColor = false
    local uiCorner = Instance.new("UICorner", toggleUIButton)
    uiCorner.CornerRadius = UDim.new(0.5, 0)

    toggleUIButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    local remoteButtons = {}

    local function createRemoteButton(remoteEvent)
        local button = Instance.new("TextButton", scrollingFrame)
        button.Size = UDim2.new(1, 0, 0, 50)
        button.Text = remoteEvent.Name
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 24

        button.MouseButton1Click:Connect(function()
            pcall(function()
                remoteEvent:FireServer()
            end)
        end)

        remoteButtons[remoteEvent] = button
    end

    local function updateRemoteEvents()
        local startTime = tick()
        local remoteEventCount = 0
        for remoteEvent, button in pairs(remoteButtons) do
            if not remoteEvent:IsDescendantOf(game) then
                button:Destroy()
                remoteButtons[remoteEvent] = nil
            else
                remoteEventCount = remoteEventCount + 1
            end
        end
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") and not remoteButtons[obj] then
                createRemoteButton(obj)
                remoteEventCount = remoteEventCount + 1
            end
        end
        remoteEventCountLabel.Text = "RemoteEvents: " .. remoteEventCount
        timeLabel.Text = string.format("Time: %.2fs", tick() - startTime)
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, remoteEventCount * 60)
    end

    -- Resize Functionality
    local function onResizeInput(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - resizer.Position
            mainFrame.Size = UDim2.new(mainFrame.Size.X.Scale, mainFrame.Size.X.Offset + delta.X, mainFrame.Size.Y.Scale, mainFrame.Size.Y.Offset + delta.Y)
            resizer.Position = input.Position
        end
    end

    resizer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizer.Draggable = false
                end
            end)
            resizer.Draggable = true
            onResizeInput(input)
        end
    end)

    -- Make the UI stay on death
    player.CharacterAdded:Connect(function()
        screenGui.Parent = player:WaitForChild("PlayerGui")
    end)

    game:GetService("RunService").RenderStepped:Connect(updateRemoteEvents)

    updateRemoteEvents()
end

createRemoteEventsGUI()

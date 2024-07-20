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
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Create Title Bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleBar.Active = true
    titleBar.Draggable = true

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Text = "Remote Event Finder"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24

    -- Create ScrollingFrame
    local scrollingFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollingFrame.Size = UDim2.new(1, 0, 1, -110)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)

    -- Create UIListLayout
    local uiListLayout = Instance.new("UIListLayout", scrollingFrame)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Create Info Frame
    local infoFrame = Instance.new("Frame", mainFrame)
    infoFrame.Size = UDim2.new(1, 0, 0, 60)
    infoFrame.Position = UDim2.new(0, 0, 1, -60)
    infoFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)

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
    resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    resizer.BorderSizePixel = 0
    resizer.Active = true
    resizer.Draggable = true

    local resizing = false
    local resizerStartPos
    local mainFrameStartSize

    resizer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizerStartPos = input.Position
            mainFrameStartSize = mainFrame.Size
        end
    end)

    resizer.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizerStartPos
            mainFrame.Size = UDim2.new(
                mainFrameStartSize.X.Scale,
                mainFrameStartSize.X.Offset + delta.X,
                mainFrameStartSize.Y.Scale,
                mainFrameStartSize.Y.Offset + delta.Y
            )
        end
    end)

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
        timeLabel.Text = "Time: " .. math.floor(tick() - startTime) .. "s"
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, remoteEventCount * 50)
    end

    game:GetService("RunService").RenderStepped:Connect(updateRemoteEvents)

    updateRemoteEvents()
end

createRemoteEventsGUI()
Key Adjustments:
Title Bar Color: Set the title bar color to black for better distinction.
Repeated Check for Remote Events: Added functionality to repeatedly check for remote events every frame.
Instructions:
Open Roblox Executor: Ensure it's compatible with running local scripts.
Run the Script: Paste this updated script into your executor and execute it.
This should now properly handle the draggable title bar, resizing functionality, improved text size, and repeated checking of remote events.

The UI still isnt draggable. Also ChatGPT, if you can please make the UI look more alive. 
ChatGPT
Sure, let's improve the UI to make it draggable and more visually appealing. I'll add some gradients and borders to give it a more polished look. Here's the updated script:

lua
Copy code
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

    -- Create a UIGradient for main frame
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
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)

    -- Create UIListLayout
    local uiListLayout = Instance.new("UIListLayout", scrollingFrame)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

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
    resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
        timeLabel.Text = "Time: " .. math.floor(tick() - startTime) .. "s"
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, remoteEventCount * 50)
    end

    -- Draggable functionality
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(updateRemoteEvents)

    updateRemoteEvents()
end

createRemoteEventsGUI()

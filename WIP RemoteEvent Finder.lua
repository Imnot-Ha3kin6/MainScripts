local function createRemoteEventsGUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "RemoteEventsGUI"
    screenGui.ResetOnSpawn = false

    -- Function to create UI corners
    local function createUICorner(parent, cornerRadius)
        local uiCorner = Instance.new("UICorner", parent)
        uiCorner.CornerRadius = UDim.new(cornerRadius, 0)
        return uiCorner
    end

    -- Function to create UI gradient
    local function createRainbowGradient(parent)
        local gradient = Instance.new("UIGradient", parent)
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211))
        })
        gradient.Rotation = 90
        return gradient
    end

    -- Create Sidebar Frame
    local sidebarFrame = Instance.new("Frame", screenGui)
    sidebarFrame.Size = UDim2.new(0, 200, 1, 0)
    sidebarFrame.Position = UDim2.new(0, 0, 0, 0)
    sidebarFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    sidebarFrame.BorderSizePixel = 0
    createUICorner(sidebarFrame, 0.05)

    -- Create Main Frame
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(1, -210, 1, 0)
    mainFrame.Position = UDim2.new(0, 210, 0, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    createUICorner(mainFrame, 0.05)

    -- Create Title Bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleBar.BorderSizePixel = 0
    createUICorner(titleBar, 0.05)

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
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
    createUICorner(scrollingFrame, 0.05)

    -- Create UIListLayout
    local uiListLayout = Instance.new("UIListLayout", scrollingFrame)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Create Info Frame
    local infoFrame = Instance.new("Frame", mainFrame)
    infoFrame.Size = UDim2.new(1, 0, 0, 60)
    infoFrame.Position = UDim2.new(0, 0, 1, -60)
    infoFrame.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    infoFrame.BorderSizePixel = 0
    createUICorner(infoFrame, 0.05)

    -- Create RemoteEvent Count Label
    local remoteEventCountLabel = Instance.new("TextLabel", infoFrame)
    remoteEventCountLabel.Size = UDim2.new(0.5, 0, 1, 0)
    remoteEventCountLabel.Text = "RemoteEvents: 0"
    remoteEventCountLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    remoteEventCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    remoteEventCountLabel.Font = Enum.Font.SourceSans
    remoteEventCountLabel.TextSize = 24
    createUICorner(remoteEventCountLabel, 0.05)

    -- Create Time Label
    local timeLabel = Instance.new("TextLabel", infoFrame)
    timeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
    timeLabel.Text = "Time: 0.0s"
    timeLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.Font = Enum.Font.SourceSans
    timeLabel.TextSize = 24
    createUICorner(timeLabel, 0.05)

    -- Create Resizer
    local resizer = Instance.new("Frame", mainFrame)
    resizer.Size = UDim2.new(0, 20, 0, 20)
    resizer.Position = UDim2.new(1, -20, 1, -20)
    resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    resizer.BorderSizePixel = 0
    resizer.Active = true
    resizer.Draggable = true

    -- Create Circular Toggle Button Frame
    local toggleButtonFrame = Instance.new("Frame", sidebarFrame)
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

    -- Create Settings Button
    local settingsButton = Instance.new("ImageButton", titleBar)
    settingsButton.Size = UDim2.new(0, 50, 0, 50)
    settingsButton.Position = UDim2.new(1, -50, 0, 0)
    settingsButton.Image = "rbxassetid://4859271265"
    settingsButton.BackgroundTransparency = 1
    createUICorner(settingsButton, 0.5)

    -- Create Settings Frame
    local settingsFrame = Instance.new("Frame", screenGui)
    settingsFrame.Size = UDim2.new(1, -200, 1, -20)
    settingsFrame.Position = UDim2.new(0, 200, 0, 10)
    settingsFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    settingsFrame.Visible = false
    createUICorner(settingsFrame, 0.05)

    -- Create Settings Header
    local settingsHeader = Instance.new("Frame", settingsFrame)
    settingsHeader.Size = UDim2.new(1, 0, 0, 50)
    settingsHeader.Position = UDim2.new(0, 0, 0, 0)
    settingsHeader.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    settingsHeader.BorderSizePixel = 0
    createUICorner(settingsHeader, 0.05)

    local settingsLabel = Instance.new("TextLabel", settingsHeader)
    settingsLabel.Size = UDim2.new(1, 0, 1, 0)
    settingsLabel.Text = "Settings"
    settingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsLabel.BackgroundTransparency = 1
    settingsLabel.Font = Enum.Font.SourceSans
    settingsLabel.TextSize = 24

    -- Create Settings Options
    local mobileToggleButton = Instance.new("TextButton", settingsFrame)
    mobileToggleButton.Size = UDim2.new(0, 280, 0, 50)
    mobileToggleButton.Position = UDim2.new(0, 10, 0, 70)
    mobileToggleButton.Text = "Toggle UI (Mobile)"
    mobileToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    mobileToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mobileToggleButton.Font = Enum.Font.SourceSans
    mobileToggleButton.TextSize = 24
    createUICorner(mobileToggleButton, 0.05)

    local pcKeybindButton = Instance.new("TextButton", settingsFrame)
    pcKeybindButton.Size = UDim2.new(0, 280, 0, 50)
    pcKeybindButton.Position = UDim2.new(0, 10, 0, 130)
    pcKeybindButton.Text = "Set PC Toggle Key (Left Ctrl)"
    pcKeybindButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    pcKeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    pcKeybindButton.Font = Enum.Font.SourceSans
    pcKeybindButton.TextSize = 24
    createUICorner(pcKeybindButton, 0.05)

    -- Create Toggle Rainbow Button
    local rainbowToggleButton = Instance.new("TextButton", settingsFrame)
    rainbowToggleButton.Size = UDim2.new(0, 280, 0, 50)
    rainbowToggleButton.Position = UDim2.new(0, 10, 0, 190)
    rainbowToggleButton.Text = "Toggle Rainbow"
    rainbowToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    rainbowToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    rainbowToggleButton.Font = Enum.Font.SourceSans
    rainbowToggleButton.TextSize = 24
    createUICorner(rainbowToggleButton, 0.05)

    local rainbowActive = false
    rainbowToggleButton.MouseButton1Click:Connect(function()
        rainbowActive = not rainbowActive
        if rainbowActive then
            createRainbowGradient(mainFrame)
            createRainbowGradient(titleBar)
            createRainbowGradient(scrollingFrame)
            createRainbowGradient(infoFrame)
        else
            -- Remove gradients if rainbow is not active
            for _, v in pairs(mainFrame:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
            for _, v in pairs(titleBar:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
            for _, v in pairs(scrollingFrame:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
            for _, v in pairs(infoFrame:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
        end
    end)

    local toggleKey = Enum.KeyCode.LeftControl
    pcKeybindButton.MouseButton1Click:Connect(function()
        pcKeybindButton.Text = "Press any key..."
        local connection
        connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                toggleKey = input.KeyCode
                pcKeybindButton.Text = "Set PC Toggle Key ("..input.KeyCode.Name..")"
                connection:Disconnect()
            end
        end)
    end)

    settingsButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        settingsFrame.Visible = true
    end)

    -- Create Toggle Menu Button
    local menuToggleButton = Instance.new("TextButton", sidebarFrame)
    menuToggleButton.Size = UDim2.new(0, 50, 0, 50)
    menuToggleButton.Position = UDim2.new(0, 10, 0, 70)
    menuToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    menuToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuToggleButton.Text = "Menu"
    createUICorner(menuToggleButton, 0.1)

    menuToggleButton.MouseButton1Click:Connect(function()
        sidebarFrame.Visible = not sidebarFrame.Visible
    end)

    -- Toggle UI with custom key for PC
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == toggleKey and not gameProcessedEvent then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    -- Make the UI draggable for both PC and Mobile
    local dragging = false
    local dragInput, mousePos, framePos

    local function update(input)
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position

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

    -- Create Mobile Toggle Button
    local mobileToggleButton = Instance.new("TextButton", sidebarFrame)
    mobileToggleButton.Size = UDim2.new(0, 100, 0, 50)
    mobileToggleButton.Position = UDim2.new(0, 10, 0, 130)
    mobileToggleButton.Text = "Mobile Toggle"
    mobileToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    mobileToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mobileToggleButton.Font = Enum.Font.SourceSans
    mobileToggleButton.TextSize = 24
    createUICorner(mobileToggleButton, 0.05)

    mobileToggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Update Remote Events Function
    local function updateRemoteEvents()
        local startTime = tick()
        while true do
            scrollingFrame:ClearAllChildren()
            local remoteEvents = game:GetDescendants()
            local count = 0
            for _, v in pairs(remoteEvents) do
                if v:IsA("RemoteEvent") then
                    count = count + 1
                    local button = Instance.new("TextButton", scrollingFrame)
                    button.Size = UDim2.new(1, -10, 0, 50)
                    button.Text = v.Name
                    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    button.TextColor3 = Color3.fromRGB(0, 0, 0)
                    button.Font = Enum.Font.SourceSans
                    button.TextSize = 24
                    button.MouseButton1Click:Connect(function()
                        v:FireServer()
                    end)
                    createUICorner(button, 0.05)
                end
            end
            remoteEventCountLabel.Text = "RemoteEvents: " .. count
            timeLabel.Text = string.format("Time: %.2fs", tick() - startTime)
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y)
            wait(1)
        end
    end

    coroutine.wrap(updateRemoteEvents)()
end

createRemoteEventsGUI()

local function createRemoteEventsGUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Utility Functions
    local function createUICorner(parent, radius)
        local corner = Instance.new("UICorner", parent)
        corner.CornerRadius = UDim.new(radius, 0)
        return corner
    end

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

    -- GUI Components
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "RemoteEventsGUI"
    screenGui.ResetOnSpawn = false

    local sidebarFrame = Instance.new("Frame", screenGui)
    sidebarFrame.Size = UDim2.new(0, 200, 1, 0)
    sidebarFrame.Position = UDim2.new(0, 0, 0, 0)
    sidebarFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    createUICorner(sidebarFrame, 0.05)

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(1, -220, 1, 0)
    mainFrame.Position = UDim2.new(0, 220, 0, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.Active = true
    createUICorner(mainFrame, 0.05)

    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    createUICorner(titleBar, 0.05)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Text = "Remote Event Finder"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24

    local scrollingFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollingFrame.Size = UDim2.new(1, 0, 1, -110)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
    createUICorner(scrollingFrame, 0.05)

    local uiListLayout = Instance.new("UIListLayout", scrollingFrame)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 10)

    local infoFrame = Instance.new("Frame", mainFrame)
    infoFrame.Size = UDim2.new(1, 0, 0, 60)
    infoFrame.Position = UDim2.new(0, 0, 1, -60)
    infoFrame.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    createUICorner(infoFrame, 0.05)

    local remoteEventCountLabel = Instance.new("TextLabel", infoFrame)
    remoteEventCountLabel.Size = UDim2.new(0.5, 0, 1, 0)
    remoteEventCountLabel.Text = "RemoteEvents: 0"
    remoteEventCountLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    remoteEventCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    remoteEventCountLabel.Font = Enum.Font.SourceSans
    remoteEventCountLabel.TextSize = 24
    createUICorner(remoteEventCountLabel, 0.05)

    local timeLabel = Instance.new("TextLabel", infoFrame)
    timeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
    timeLabel.Text = "Time: 0.0s"
    timeLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.Font = Enum.Font.SourceSans
    timeLabel.TextSize = 24
    createUICorner(timeLabel, 0.05)

    local resizer = Instance.new("Frame", mainFrame)
    resizer.Size = UDim2.new(0, 20, 0, 20)
    resizer.Position = UDim2.new(1, -20, 1, -20)
    resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    resizer.Active = true
    resizer.Draggable = true

    local toggleButtonFrame = Instance.new("Frame", sidebarFrame)
    toggleButtonFrame.Size = UDim2.new(0, 50, 0, 50)
    toggleButtonFrame.Position = UDim2.new(0, 10, 0, 10)
    toggleButtonFrame.BackgroundTransparency = 1

    local toggleButton = Instance.new("ImageButton", toggleButtonFrame)
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.Image = "rbxassetid://6531587958"
    toggleButton.BackgroundTransparency = 1

    toggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    local settingsButton = Instance.new("ImageButton", titleBar)
    settingsButton.Size = UDim2.new(0, 50, 0, 50)
    settingsButton.Position = UDim2.new(1, -50, 0, 0)
    settingsButton.Image = "rbxassetid://4859271265"
    settingsButton.BackgroundTransparency = 1
    createUICorner(settingsButton, 0.5)

    local settingsFrame = Instance.new("Frame", screenGui)
    settingsFrame.Size = UDim2.new(1, -200, 1, -20)
    settingsFrame.Position = UDim2.new(0, 200, 0, 10)
    settingsFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    settingsFrame.Visible = false
    createUICorner(settingsFrame, 0.05)

    local settingsHeader = Instance.new("Frame", settingsFrame)
    settingsHeader.Size = UDim2.new(1, 0, 0, 50)
    settingsHeader.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    createUICorner(settingsHeader, 0.05)

    local settingsLabel = Instance.new("TextLabel", settingsHeader)
    settingsLabel.Size = UDim2.new(1, 0, 1, 0)
    settingsLabel.Text = "Settings"
    settingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsLabel.BackgroundTransparency = 1
    settingsLabel.Font = Enum.Font.SourceSans
    settingsLabel.TextSize = 24

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

    -- Function to detect RemoteEvents
    local function findRemoteEvents()
        local startTime = tick()
        local remoteEvents = {}
        local function search(instance)
            for _, child in ipairs(instance:GetChildren()) do
                if child:IsA("RemoteEvent") then
                    table.insert(remoteEvents, child)
                end
                search(child)
            end
        end
        search(game:GetDescendants())

        -- Update GUI with RemoteEvent list
        local count = #remoteEvents
        remoteEventCountLabel.Text = "RemoteEvents: " .. count
        scrollingFrame:ClearAllChildren()

        for _, remoteEvent in ipairs(remoteEvents) do
            local button = Instance.new("TextButton", scrollingFrame)
            button.Size = UDim2.new(1, -20, 0, 40)
            button.Text = remoteEvent.Name
            button.TextSize = 18
            button.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            button.BorderSizePixel = 0
            button.MouseButton1Click:Connect(function()
                remoteEvent:FireAllClients()
            end)
            createUICorner(button, 0.1)
        end

        -- Update Time Label
        local elapsed = tick() - startTime
        timeLabel.Text = string.format("Time: %.2fs", elapsed)
    end

    -- Initial Load
    findRemoteEvents()

    -- Toggle Main UI
    settingsButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        settingsFrame.Visible = not settingsFrame.Visible
    end)

    mobileToggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Resize Detection
    resizer.MouseDrag:Connect(function()
        local mouse = player:GetMouse()
        local newSize = UDim2.new(0, mouse.X - mainFrame.AbsolutePosition.X, 0, mouse.Y - mainFrame.AbsolutePosition.Y)
        mainFrame.Size = newSize
    end)

    -- PC Toggle Key Bind
    local UserInputService = game:GetService("UserInputService")
    local toggleKey = Enum.KeyCode.LeftControl
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == toggleKey then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
end

createRemoteEventsGUI()

local function createRemoteEventsGUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")

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
    titleBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    titleBar.Active = true

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
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

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

    runService.RenderStepped:Connect(function()
        if resizing then
            local mousePos = userInputService:GetMouseLocation()
            local delta = mousePos - resizerStartPos
            mainFrame.Size = UDim2.new(
                mainFrameStartSize.X.Scale,
                mainFrameStartSize.X.Offset + delta.X,
                mainFrameStartSize.Y.Scale,
                mainFrameStartSize.Y.Offset + delta.Y
            )
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.UIListLayout.AbsoluteContentSize.Y)
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

    -- Check if the user is on PC or Mobile
    local isMobile = userInputService.TouchEnabled

    if isMobile then
        toggleButton.Visible = false
    else
        -- Create Left Control Instruction for PC
        local controlInstruction = Instance.new("TextLabel", mainFrame)
        controlInstruction.Size = UDim2.new(1, 0, 0, 30)
        controlInstruction.Position = UDim2.new(0, 0, 0, 10)
        controlInstruction.Text = "Left Control To Toggle Menu"
        controlInstruction.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        controlInstruction.TextColor3 = Color3.fromRGB(255, 255, 255)
        controlInstruction.Font = Enum.Font.SourceSans
        controlInstruction.TextSize = 18
        controlInstruction.TextStrokeTransparency = 0.5
    end

    toggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

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
    end

    local function updateRemoteEvents()
        local remoteEventCount = 0
        local existingRemoteEvents = {}

        local function traverse(cont)
            for _, obj in pairs(cont:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    if not existingRemoteEvents[obj] then
                        createRemoteButton(obj)
                        existingRemoteEvents[obj] = true
                        remoteEventCount = remoteEventCount + 1
                    end
                else
                    existingRemoteEvents[obj] = nil
                end
            end
        end

        traverse(game)
        remoteEventCountLabel.Text = "RemoteEvents: " .. remoteEventCount
        timeLabel.Text = "Time: " .. string.format("%.2fs", tick() - startTime)
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, remoteEventCount * 50)
    end

    -- Update Remote Events periodically
    local startTime = tick()
    runService.Heartbeat:Connect(function()
        updateRemoteEvents()
    end)
end

createRemoteEventsGUI()

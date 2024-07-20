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

    -- Create ScrollingFrame
    local scrollingFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollingFrame.Size = UDim2.new(1, 0, 1, -60)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
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

    -- Create Time Label
    local timeLabel = Instance.new("TextLabel", infoFrame)
    timeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
    timeLabel.Text = "Time: 0s"
    timeLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Create Toggle Button Frame
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

    local function createRemoteButton(remoteEvent)
        local button = Instance.new("TextButton", scrollingFrame)
        button.Size = UDim2.new(1, 0, 0, 50)
        button.Text = remoteEvent.Name
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)

        button.MouseButton1Click:Connect(function()
            pcall(function()
                remoteEvent:FireServer()
            end)
        end)
    end

    local function findRemoteEvents(container)
        local startTime = tick()
        local remoteEventCount = 0
        local function traverse(cont)
            for _, obj in pairs(cont:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    createRemoteButton(obj)
                    remoteEventCount = remoteEventCount + 1
                end
            end
        end
        traverse(container)
        remoteEventCountLabel.Text = "RemoteEvents: " .. remoteEventCount
        timeLabel.Text = "Time: " .. math.floor(tick() - startTime) .. "s"
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, remoteEventCount * 50)
    end

    findRemoteEvents(game)
end

createRemoteEventsGUI()

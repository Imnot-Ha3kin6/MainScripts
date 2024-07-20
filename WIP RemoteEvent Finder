-- Create a GUI to display RemoteEvents
local function createRemoteEventsGUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RemoteEventsGUI"
    screenGui.Parent = playerGui
    
    -- Create Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
    mainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.Parent = screenGui
    
    -- Create ScrollingFrame
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, -60)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0) -- Default canvas size
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.Parent = mainFrame

    -- Create UIListLayout inside ScrollingFrame
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = scrollingFrame
    
    -- Create RemoteEvent Count and Time Display
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(1, 0, 0, 60)
    infoFrame.Position = UDim2.new(0, 0, 1, -60)
    infoFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    infoFrame.Parent = mainFrame
    
    local remoteEventCountLabel = Instance.new("TextLabel")
    remoteEventCountLabel.Size = UDim2.new(0.5, 0, 1, 0)
    remoteEventCountLabel.Position = UDim2.new(0, 0, 0, 0)
    remoteEventCountLabel.Text = "RemoteEvents: 0"
    remoteEventCountLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    remoteEventCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    remoteEventCountLabel.Parent = infoFrame
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
    timeLabel.Text = "Time: 0s"
    timeLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.Parent = infoFrame

    -- Create Toggle Button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.1, 0, 0.1, 0)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.Text = "Toggle"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = screenGui
    
    local function toggleMainFrame()
        mainFrame.Visible = not mainFrame.Visible
    end
    
    toggleButton.MouseButton1Click:Connect(toggleMainFrame)

    -- Function to make the GUI movable
    local function makeDraggable(frame)
        local dragging = false
        local dragInput, mousePos, framePos
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragInput = input
                mousePos = input.Position
                framePos = frame.Position
            end
        end)
        
        frame.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - mousePos
                frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
            end
        end)
        
        frame.InputEnded:Connect(function(input)
            if input == dragInput then
                dragging = false
            end
        end)
    end
    
    -- Make the main frame draggable
    makeDraggable(mainFrame)

    -- Function to create buttons for RemoteEvents
    local function createRemoteButton(remoteEvent)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 50)
        button.Text = remoteEvent.Name
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = scrollingFrame
        
        button.MouseButton1Click:Connect(function()
            pcall(function()
                remoteEvent:FireServer() -- Execute RemoteEvent
            end)
        end)
    end

    -- Find all RemoteEvents and create buttons for them
    local function findRemoteEvents(container)
        local startTime = tick()
        local remoteEventCount = 0
        local foundRemoteEvents = {}

        local function countRemoteEvents(cont)
            for _, obj in pairs(cont:GetChildren()) do
                if obj:IsA("RemoteEvent") then
                    table.insert(foundRemoteEvents, obj)
                    remoteEventCount = remoteEventCount + 1
                elseif obj:IsA("Folder") or obj:IsA("Model") then
                    countRemoteEvents(obj)
                end
            end
        end
        
        countRemoteEvents(container)
        
        -- Create buttons for each found RemoteEvent
        for _, remoteEvent in ipairs(foundRemoteEvents) do
            createRemoteButton(remoteEvent)
        end
        
        -- Update RemoteEvent count and elapsed time
        remoteEventCountLabel.Text = "RemoteEvents: " .. remoteEventCount
        local elapsedTime = math.floor(tick() - startTime)
        timeLabel.Text = "Time: " .. elapsedTime .. "s"
    end
    
    findRemoteEvents(game)
end

-- Execute the function to create the GUI
createRemoteEventsGUI()

-- Notification Function
function Notify(titletxt, text, time)
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame", GUI)
    local title = Instance.new("TextLabel", Main)
    local message = Instance.new("TextLabel", Main)
    local UICorner = Instance.new("UICorner")
    GUI.Name = "NotificationOof"
    GUI.Parent = game.CoreGui
    Main.Name = "MainFrame"
    Main.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(1, 5, 0, 50)
    Main.Size = UDim2.new(0, 330, 0, 100)
    
    UICorner.Parent = Main
    UICorner.CornerRadius = UDim.new(0, 15)

    title.BackgroundColor3 = Color3.new(0, 0, 0)
    title.BackgroundTransparency = 0.9
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(255, 0, 255)
    title.TextSize = 25
    
    message.BackgroundColor3 = Color3.new(0, 0, 0)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextSize = 15
    
    -- Rainbow Text
    coroutine.wrap(function()
        while GUI.Parent do
            for i = 0, 1, 0.01 do
                title.TextColor3 = Color3.fromHSV(i, 1, 1)
                message.TextColor3 = Color3.fromHSV(i, 1, 1)
                wait(0.03)
            end
        end
    end)()
    
    wait(0.1)
    Main:TweenPosition(UDim2.new(1, -330, 0, 50), "Out", "Sine", 0.5)
    wait(time)
    Main:TweenPosition(UDim2.new(1, 5, 0, 50), "Out", "Sine", 0.5)
    wait(10.0)
    GUI:Destroy()
end

-- Show Notification
Notify("Notification (IF SCRIPT DOESENT LOAD RE-EXECUTE)", "Use Hunter Bypass Before Using Hunter", 5)

-- Main Script
local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Imnot-Ha3kin6/MainScripts/main/Shaddow%20Script%20Library.lua"))()

local Main = library:CreateWindow("KJ’s Shenanigans", "Crimson")

local tab = Main:CreateTab("Ult Moveset")
local tab2 = Main:CreateTab("Basic Moveset")
local tab3 = Main:CreateTab("Other Scripts")
local tab4 = Main:CreateTab("Characters")
local tab5 = Main:CreateTab("Bypasses")
local tab6 = Main:CreateTab("Other Remotes")

tab:CreateButton("20 Series", function()
    local args = {
        [1] = "KJ"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Ultimate"):FireServer(unpack(args))
end)

tab:CreateButton("Stoic Bomb", function()
    local player = game:GetService("Players").LocalPlayer
    local remoteEvent = player.Backpack:FindFirstChild("Stoic Bomb"):FindFirstChild("Activate"):FindFirstChild("RemoteEvent")

    if remoteEvent then
        remoteEvent:FireServer()
    else
        warn("RemoteEvent not found!")
    end
end)

tab:CreateButton("20-20-20 Dropkick", function()
    local player = game:GetService("Players").LocalPlayer
    local remoteEvent = player.Backpack:FindFirstChild("20-20-20 Dropkick"):FindFirstChild("Activate"):FindFirstChild("RemoteEvent")

    if remoteEvent then
        remoteEvent:FireServer()
    else
        warn("RemoteEvent not found!")
    end
end)

tab2:CreateButton("Ravage", function()
    local player = game:GetService("Players").LocalPlayer
    local remoteEvent = player.Backpack:FindFirstChild("Ravage"):FindFirstChild("Activate"):FindFirstChild("RemoteEvent")

    if remoteEvent then
        remoteEvent:FireServer()
    else
        warn("RemoteEvent not found!")
    end
end)

tab2:CreateButton("Swift Sweep", function()
    local player = game:GetService("Players").LocalPlayer
    local remoteEvent = player.Backpack:FindFirstChild("Swift Sweep"):FindFirstChild("Activate"):FindFirstChild("RemoteEvent")

    if remoteEvent then
        remoteEvent:FireServer()
    else
        warn("RemoteEvent not found!")
    end
end)

tab2:CreateButton("Collateral Ruin", function()
    local player = game:GetService("Players").LocalPlayer
    local remoteEvent = player.Backpack:FindFirstChild("Collateral Ruin"):FindFirstChild("Activate"):FindFirstChild("RemoteEvent")

    if remoteEvent then
        remoteEvent:FireServer()
    else
        warn("RemoteEvent not found!")
    end
end)

tab3:CreateButton("Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end)

tab3:CreateButton("Remotes Finder", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imnot-Ha3kin6/hhhhh/main/Remote%20Event%20Finder%20PC%20and%20Mobile.lua", true))()
end)

tab3:CreateButton("Infinite Yield Reborn", function()
    loadstring(game:HttpGet("https://github.com/fuckusfm/infiniteyield-reborn/raw/master/source"))()
end)

tab3:CreateButton("Turtle Spy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua", true))()
end)

tab4:CreateButton("Hunter", function()
    local player = game:GetService("Players").LocalPlayer
    player.Data.CurrentCharacter.Value = "Hunter"
end)

tab4:CreateButton("KJ", function()
    local player = game:GetService("Players").LocalPlayer
    player.Data.CurrentCharacter.Value = "KJ"
end)

tab5:CreateButton("Hunter Bypass", function()
    if game.CreatorType == Enum.CreatorType.User then
        game.Players.LocalPlayer.UserId = game.CreatorId
    elseif game.CreatorType == Enum.CreatorType.Group then
        game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
    end
end)

tab6:CreateButton("Normal Moveset", function()
  game:GetService("ReplicatedStorage").Remotes.Intro:FireServer("KJ")
end)

tab:Show()

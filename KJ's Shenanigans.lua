local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Imnot-Ha3kin6/hhhhh/main/Shaddow%20Script%20Library.lua"))()

local Main = library:CreateWindow("KJ’s Shenanigans", "Crimson")

local tab = Main:CreateTab("Ult Moveset")
local tab2 = Main:CreateTab("Basic Moveset")
local tab3 = Main:CreateTab("Misc")
local tab4 = Main:CreateTab("Characters")

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

tab4:CreateButton("Hunter", function()
    local player = game:GetService("Players").LocalPlayer
    player.Data.CurrentCharacter.Value = "Hunter"
end)

tab4:CreateButton("KJ", function()
    local player = game:GetService("Players").LocalPlayer
    player.Data.CurrentCharacter.Value = "KJ"
end)

tab:Show()

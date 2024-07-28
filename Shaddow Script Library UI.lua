    Toggle_2.TextSize = 14.000

    Frame_t.Name = "Frame_t"
    Frame_t.Parent = Toggle_2
    Frame_t.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_t.BackgroundTransparency = 1.000
    Frame_t.Position = UDim2.new(1, 0, 0.395000011, 0)
    Frame_t.Size = UDim2.new(0, 40, 0, 20)
    Frame_t.Image = "rbxassetid://3570695787"
    Frame_t.ImageColor3 = theme2
    Frame_t.ScaleType = Enum.ScaleType.Slice
    Frame_t.SliceCenter = Rect.new(100, 100, 100, 100)
    Frame_t.SliceScale = 0.020

    Frame_2.Name = "Frame_2"
    Frame_2.Parent = Frame_t
    Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_2.BackgroundTransparency = 1.000
    Frame_2.Position = UDim2.new(0, 0, 0.25, 0)
    Frame_2.Size = UDim2.new(0, 40, 0, 8)
    Frame_2.Image = "rbxassetid://3570695787"
    Frame_2.ImageColor3 = theme3
    Frame_2.ScaleType = Enum.ScaleType.Slice
    Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Frame_2.SliceScale = 0.020

    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = Frame_t
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundTransparency = 1.000
    ToggleButton.Position = UDim2.new(0.75, -10, 0.25, 0)
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    ToggleButton.TextSize = 14.000
    ToggleButton.AutoButtonColor = false

    local Toggled = false

    local function setstate()
        Frame_2:TweenPosition(Toggled and UDim2.new(0.75, -10, 0.25, 0) or UDim2.new(0, 0, 0.25, 0), "Out", "Sine", 0.2, true)
        callback(Toggled)
    end

    ToggleButton.MouseButton1Click:Connect(function()
        play("rbxassetid://178104975")
        Toggled = not Toggled
        setstate()
    end)

    setstate()

    function switchactions:SetState(state)
        Toggled = state
        setstate()
    end

    return switchactions
end

return InsideLibrary
end

return library

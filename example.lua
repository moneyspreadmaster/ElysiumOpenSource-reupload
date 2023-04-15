local FluxLib = {}

function FluxLib:NewGui(GuiProperties)
	local Gui = {}
	local GuiTabs = {}


	local function GuiTabs_GetTableIndex(ItemContainer)
		for i = 1, #GuiTabs do
			local GuiTab = GuiTabs[i]
			if GuiTab.ItemContainer == ItemContainer then
				return GuiTab
			end
		end
	end
	
	local SizeX = GuiProperties.SizeX or 370
	local SizeY = GuiProperties.SizeY or 245
	local TitleText = GuiProperties.Title and string.upper(GuiProperties.Title) or "GUI"
	local Player = game:GetService("Players").LocalPlayer
	local Mouse = Player:GetMouse()
	local ScreenGui = Instance.new("Screengui")
	local Frame = Instance.new("Frame")
	local SideBarParent = Instance.new("Frame")
	local SideBar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local ServerLocation = Instance.new("TextLabel")
	local SideBarItemList = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local TweenService = game:GetService("TweenService")
	local Radius = 5
	


	Script.KeyType:Connect(function(e)
	if e.KeyCode == 54 then
    ScreenGui:Open()
	end
	end)	

	Frame.Size = UDim2.new(0, SizeX, 0, SizeY)
	Frame.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	Frame.BorderSizePixel = 0
	Frame.BackgroundColor3 = Color3.fromHex("#421155")
	Frame.Draggable = true
	Frame.VerticalAlignment = "Center"
	Frame.HorizontalAlignment = "Center"

	Title.Text = TitleText
	Title.Font = "https://cdn.discordapp.com/attachments/695925843834306592/1071401151913803786/1746-font.otf"
	Title.Position = UDim2.new(0, 40, 0, 16)
	Title.FontSize = 20
	
	ServerLocation.FontSize = 15
	ServerLocation.Position = UDim2.new(0, 12, 0, 31)
	
	SideBarParent.Size = UDim2.new(0, 120, 0, 245)
	SideBarParent.BackgroundTransparency = 1
	SideBarParent.ClipsDescendants = true
	
	SideBar.Size = UDim2.new(0, 125, 0, 245)
	SideBar.BackgroundColor3 = Color3.fromHex("#290238")
	SideBar.BorderSizePixel = 0
	SideBar.CornerRadius = CornerRadius.new(5, 5, 5, 5)
	
	SideBarItemList.Size = UDim2.new(0, 125, 0, 198)
	SideBarItemList.BackgroundTransparency = 1
	SideBarItemList.BorderSizePixel = 0
	SideBarItemList.VerticalAlignment = "bottom"
	
	UIListLayout.Padding = UDim.new(3, 0)
	UIListLayout.ChildrenHorizontalAlignment = "Center"
	
	UIListLayout.Parent = SideBarItemList
	SideBarItemList.Parent = SideBar
	ServerLocation.Parent = SideBar
	Title.Parent = SideBar
	SideBar.Parent = SideBarParent
	SideBarParent.Parent = Frame
	Frame.Parent = ScreenGui
	ScreenGui.IsEnabled = true
	
	function Gui:NewTab(TabProperties)
		local Tab = {}
		
		local TabName = TabProperties.TabName or "Tab ".. tostring(#GuiTabs + 1)
		local TabItemImage = TabProperties.TabItemImage
		local AccentColor = TabProperties.AccentColor or Color3.fromHex("#9D6AB1")
		local Active = TabProperties.Active or (#GuiTabs == 0 and true or false)
		
		if Active and #GuiTabs > 0 then
			for i = 1, #GuiTabs do
				local GuiTab = GuiTabs[i]
				if GuiTab.Active then
					GuiTab.Active = false
					GuiTab.TabItem.BackgroundTransparency = 1
					GuiTab.ItemContainer.Visible = false
				end
			end
		end
		
		local TabItem = Instance.new("TextButton")
		local TabItemTitle = Instance.new("TextLabel")
		local ItemContainer = Instance.new("Frame")
		local ItemListLayout = Instance.new("UIListLayout")
		
		TabItem.Size = UDim2.new(0, 125, 0, 24)
		TabItem.BorderSizePixel = 0
		TabItem.BackgroundColor3 = AccentColor
		TabItem.BackgroundTransparency = Active and 0 or 1
		
		TabItemTitle.Text = TabName
		TabItemTitle.FontSize = 16
		TabItemTitle.Font = "SourceSansPro-SemiBold"
		TabItemTitle.VerticalAlignment = "Center"
		TabItemTitle.Position = UDim2.new(0, 25, 0, 1)
		
		ItemContainer.BackgroundColor3 = Color3.fromRGB(255, 255,255)
		ItemContainer.Size = UDim2.new(0, 250, 0, 230)
		ItemContainer.VerticalAlignment = "Bottom"
		ItemContainer.BorderSizePixel = 0
		ItemContainer.BackgroundTransparency = 1
		ItemContainer.HorizontalAlignment = "Right"
		ItemContainer.Visible = Active
		
		ItemListLayout.Padding = UDim.new(3, 1)
		ItemListLayout.ChildrenHorizontalAlignment = "Center"
		
		TabItem.Parent = SideBarItemList
		TabItemTitle.Parent = TabItem
		ItemContainer.Parent = Frame
		ItemListLayout.Parent = ItemContainer
		
		TabItem.MouseButton1Click:Connect(function()
			local Self_GuiTab = GuiTabs_GetTableIndex(ItemContainer)
			if not Self_GuiTab.Active then
				Self_GuiTab.Active = true
				ItemContainer.Visible = true
                local TabSelectTween = TweenService:Create(TabItem, TweenInfo.new(0.5), {BackgroundTransparency = 0})
                TabSelectTween:Play()
				for i = 1, #GuiTabs do
					local GuiTab = GuiTabs[i]
					if GuiTab ~= Self_GuiTab and GuiTab.Active then
						GuiTab.Active = false
						GuiTab.ItemContainer.Visible = false
                        local TabUnselectTween = TweenService:Create(GuiTab.TabItem, TweenInfo.new(0.5), {BackgroundTransparency = 1})
						TabUnselectTween:Play()
					end
				end
			end
		end)
		
		function Tab:NewButton(ButtonProperties)
			local Text = ButtonProperties.Text or "Text"
			local CallbackFunction = ButtonProperties.CallbackFunction
			
			local ItemButton = Instance.new("TextButton")
			local Circle = Instance.new("Frame")
			local ItemButtonTitle = Instance.new("TextLabel")
			local OuterCircle = Instance.new("TextButton")
			local InnerCircle = Instance.new("Frame")
			
			local Toggled = false
			
			ItemButton.Size = UDim2.new(0, 225, 0, 24)
			ItemButton.BorderSizePixel = 0
			ItemButton.BackgroundColor3 = Color3.fromHex("#7A4A8D")
			ItemButton.CornerRadius = CornerRadius.new(5, 5, 5, 5)
			
			Circle.Size = UDim2.new(0, 7, 0, 7)
			Circle.Position = UDim2.new(0, 9, 0, 0)
			Circle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			Circle.BackgroundColor3 = Color3.fromHex("#9A73A9")
			Circle.BorderSizePixel = 0
			Circle.VerticalAlignment = "Center"
			
			ItemButtonTitle.VerticalAlignment = "Center"
			ItemButtonTitle.Position = UDim2.new(0, 22, 0, 1)
			ItemButtonTitle.Text = Text
			ItemButtonTitle.FontSize = 16
			
			OuterCircle.Size = UDim2.new(0, 16, 0, 7)
			OuterCircle.Position = UDim2.new(0, -11, 0, 0)
			OuterCircle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			OuterCircle.BackgroundColor3 = Color3.fromHex("#8B828E")
			OuterCircle.BorderSizePixel = 0
			OuterCircle.VerticalAlignment = "Center"
			OuterCircle.HorizontalAlignment = "Right"
			
			InnerCircle.Size = UDim2.new(0, 10, 0, 10)
			InnerCircle.Position = UDim2.new(0, 0, 0, 0)
			InnerCircle.CornerRadius = CornerRadius.new(10, 10, 10, 10)
			InnerCircle.BackgroundColor3 = Color3.fromHex("#fefefe")
			InnerCircle.BorderSizePixel = 0
			InnerCircle.VerticalAlignment = "Center"
			
			ItemButton.MouseButton1Click:Connect(function()
				Toggled = not Toggled
				if Toggled then
					local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
					UnToggleTween:Play()
					UnToggleTweenColor:Play()
				else
					local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#ff6f30")})
					ToggleTween:Play()
					UnToggleTweenColor:Play()
				end
				if CallbackFunction then
					CallbackFunction()
				end
			end)
			
			ItemButton.Parent = ItemContainer
			Circle.Parent = ItemButton
			ItemButtonTitle.Parent = ItemButton
		end
		
		function Tab:NewToggle(ToggleProperties)
			local Text = ToggleProperties.Text or "Text"
			local CallbackFunction = ToggleProperties.CallbackFunction
			
			local ItemButton = Instance.new("TextButton")
			local Circle = Instance.new("Frame")
			local ItemButtonTitle = Instance.new("TextLabel")
			local OuterCircle = Instance.new("TextButton")
			local InnerCircle = Instance.new("Frame")
			
			local Toggled = false
			
			ItemButton.Size = UDim2.new(0, 225, 0, 24)
			ItemButton.BorderSizePixel = 0
			ItemButton.BackgroundColor3 = Color3.fromHex("#7A4A8D")
			ItemButton.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			
			Circle.Size = UDim2.new(0, 7, 0, 7)
			Circle.Position = UDim2.new(0, 9, 0, 0)
			Circle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			Circle.BackgroundColor3 = Color3.fromHex("#9A73A9")
			Circle.BorderSizePixel = 0
			Circle.VerticalAlignment = "Center"
			
			ItemButtonTitle.VerticalAlignment = "Center"
			ItemButtonTitle.Position = UDim2.new(0, 22, 0, 1)
			ItemButtonTitle.Text = Text
			ItemButtonTitle.FontSize = 16
			
			OuterCircle.Size = UDim2.new(0, 16, 0, 7)
			OuterCircle.Position = UDim2.new(0, -11, 0, 0)
			OuterCircle.CornerRadius = CornerRadius.new(6, 6, 6, 6)
			OuterCircle.BackgroundColor3 = Color3.fromHex("#8B828E")
			OuterCircle.BorderSizePixel = 0
			OuterCircle.VerticalAlignment = "Center"
			OuterCircle.HorizontalAlignment = "Right"
			
			InnerCircle.Size = UDim2.new(0, 10, 0, 10)
			InnerCircle.Position = UDim2.new(0, 0, 0, 0)
			InnerCircle.CornerRadius = CornerRadius.new(10, 10, 10, 10)
			InnerCircle.BackgroundColor3 = Color3.fromHex("#fefefe")
			InnerCircle.BorderSizePixel = 0
			InnerCircle.VerticalAlignment = "Center"
			
			OuterCircle.MouseButton1Click:Connect(function()
				if Toggled then
					local UnToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 0, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#fefefe")})
					UnToggleTween:Play()
					UnToggleTweenColor:Play()
				else
					local ToggleTween = TweenService:Create(InnerCircle, TweenInfo.new(0.01), {Position = UDim2.new(0, 7, 0, 0)})
					local UnToggleTweenColor = TweenService:Create(InnerCircle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHex("#9D6AB1")})
					ToggleTween:Play()
					UnToggleTweenColor:Play()
				end
				Toggled = not Toggled
				if CallbackFunction then
					CallbackFunction(Toggled)
				end
			end)
			
			ItemButton.Parent = ItemContainer
			Circle.Parent = ItemButton
			ItemButtonTitle.Parent = ItemButton
			OuterCircle.Parent = ItemButton
			InnerCircle.Parent = OuterCircle
		end
		
		GuiTabs[#GuiTabs + 1] = {Active = Active, TabItem = TabItem, ItemContainer = ItemContainer}
		return Tab
	end
	
	return Gui
end


local player = game:GetService("Players").LocalPlayer


local Eagle = false

local Gui = FluxLib:NewGui({
	SizeX = 370,
	SizeY = 245,
	Title = "Equity"
})

local Tab1 = Gui:NewTab({
	TabName = "Ghost"
})

local Tab2 = Gui:NewTab({
	TabName = "Blatant" -- Defaults to "Tab <Tab Order>"
})



Tab1:NewToggle({
	Text = "auto shift bridge",
	CallbackFunction = function(Callback)
		if Eagle then
		Eagle = false
		else
		Eagle = true
		end
	end
})

local Reach = false

Tab1:NewToggle({
	Text = "Reach",
	CallbackFunction = function(Callback)
		if Reach then
		Reach = false
		else
		Reach = true
		end
	end
})

local JumpReset = false

Tab1:NewToggle({
	Text = "Jump Reset",
	CallbackFunction = function(Callback)
		if JumpReset then
		JumpReset = false
		else
		JumpReset = true
		end
	end
})

time = os.time()
Script.Update:Connect(function()
    if JumpReset == true then
        if player:GetHurtTime() == player:GetMaxHurtTime() and player:GetMaxHurtTime() > 0 and player:IsMoving() == true then
            wait(0.2)
			player:Jump()
        end
    end

    if Speed == true then
	player:Strafe(2)
    end
    if Eagle == true then
     if player:IsBlockBelowAir() and player:GetMoveForward() < 0.1 then
        if not player:IsFlying() then
            time = os.time()
        end
    end
    if not ((os.time() - time) > 125 ) then
        player:SetSneaking(true)
    else if not player:IsSneakPressed() then
        player:SetSneaking(false)
    end
    end
    end
end)

Script.MouseClick1:Connect(function()
 	if Reach == true then
    	player:Reach(3.1)
	end
end)

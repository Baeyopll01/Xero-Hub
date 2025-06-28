local Env = {}

local TweenService: TweenService = game:GetService("TweenService")
local UserInputService: UserInputService = game:GetService("UserInputService")

GetIcon = function(i)
	if type(i) == 'string' and not i:find('rbxassetid://') then
		return "rbxassetid://".. i
	elseif type(i) == 'number' then
		return "rbxassetid://".. i
	else
		return i
	end
end

tw = function(info)
	return TweenService:Create(info.v, TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]), info.g)
end

lak = function(a)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		local Tween = game:GetService("TweenService"):Create(a, TweenInfo.new(0.3), {Position = pos})
		Tween:Play()
	end

	a.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = a.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	a.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

click = function(p)
	local Click = Instance.new("TextButton")

	Click.Name = "Click"
	Click.Parent = p
	Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Click.BackgroundTransparency = 1.000
	Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Click.BorderSizePixel = 0
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.Font = Enum.Font.SourceSans
	Click.Text = ""
	Click.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click.TextSize = 14.000
	Click.ZIndex = p.ZIndex + 2

	return Click
end

EffectClick = function(c, p)
	local Mouse = game.Players.LocalPlayer:GetMouse()

	local relativeX = Mouse.X - c.AbsolutePosition.X
	local relativeY = Mouse.Y - c.AbsolutePosition.Y

	if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
		return
	end

	local ClickButtonCircle = Instance.new("Frame")
	ClickButtonCircle.Parent = p
	ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ClickButtonCircle.BackgroundTransparency = 0.5
	ClickButtonCircle.BorderSizePixel = 0
	ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
	ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
	ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
	ClickButtonCircle.ZIndex = p.ZIndex

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = ClickButtonCircle

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local goal = {
		Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1
	}

	local expandTween = TweenService:Create(ClickButtonCircle, tweenInfo, goal)

	expandTween.Completed:Connect(function()
		ClickButtonCircle:Destroy()
	end)

	expandTween:Play()
end

Canvas_Y = function(uilist, sc, n)
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sc.CanvasSize = UDim2.new(0, 0, 0, uilist.AbsoluteContentSize.Y + n)
	end)
end

Canvas_X = function(uilist, sc, n)
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sc.CanvasSize = UDim2.new(0, uilist.AbsoluteContentSize.X + n, 0, 0)
	end)
end

Sono = function(s)
	return Font.new(GetIcon(12187374537),Enum.FontWeight.SemiBold)
end

SonoM = function(s)
	return Font.new(GetIcon(12187374537),Enum.FontWeight.Medium)
end

Parent = function()
	return not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui
end

Tog = function(p, frame, bn, i)
	local CloseUI = Instance.new("TextButton")
	local UICorner_1z = Instance.new("UICorner")
	local Icon_1 = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")


	CloseUI.Name = "CloseUI"
	CloseUI.Parent = p
	CloseUI.AnchorPoint = Vector2.new(0, 1)
	CloseUI.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CloseUI.BorderColor3 = Color3.fromRGB(0,0,0)
	CloseUI.BorderSizePixel = 0
	CloseUI.Position = UDim2.new(0.5, 0,0.2, 0)
	CloseUI.Size = UDim2.new(0, 50,0, 50)
	CloseUI.BackgroundTransparency = 0.35
	CloseUI.Text = ""

	lak(CloseUI)

	UICorner_1z.Parent = CloseUI
	UICorner_1z.CornerRadius = UDim.new(0,5)

	Icon_1.Name = "Icon"
	Icon_1.Parent = CloseUI
	Icon_1.BackgroundColor3 = Color3.fromRGB(22,22,22)
	Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Icon_1.BorderSizePixel = 0
	Icon_1.Size = UDim2.new(0, 50,0, 50)
	Icon_1.BackgroundTransparency = 1

	ImageLabel.Parent = Icon_1
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel.Size = UDim2.new(0, 45,0, 45)
	ImageLabel.Image = GetIcon(i)
	ImageLabel.ImageTransparency = 0

	local function closeopenui()
		task.spawn(function()
			tw({
				v = ImageLabel,
				t = 0.2,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(0, 35, 0, 35)}
			}):Play()
			task.wait(0.016) 
			tw({
				v = ImageLabel,
				t = 0.2,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(0, 45, 0, 45)}
			}):Play()
		end)
		frame.Visible = not frame.Visible
	end

	local On = true

	CloseUI.MouseButton1Click:Connect(function()
		closeopenui()
		On = not On
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == bn then
			closeopenui()
			On = not On
		end
	end)
end

local lnwza = Instance.new("ScreenGui")
lnwza.Name = "lnwza"
lnwza.Parent = Parent()
lnwza.ZIndexBehavior = Enum.ZIndexBehavior.Global
lnwza.IgnoreGuiInset = true

function Env.new(Logo, Bind)
	local Background_1 = Instance.new("Frame")
	local DropShadow_1 = Instance.new("ImageLabel")
	local Tabs_1 = Instance.new("Frame")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local Profile_1 = Instance.new("ImageLabel")
	local UICorner_1 = Instance.new("UICorner")
	local TabScolling_1 = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	
	Background_1.Name = "Background"
	Background_1.Parent = lnwza
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(0, 525,0, 375)
	lak(Background_1)
	Tog(lnwza, Background_1, Bind, Logo)
	
	

	DropShadow_1.Name = "DropShadow"
	DropShadow_1.Parent = Background_1
	DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
	DropShadow_1.BackgroundTransparency = 1
	DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.BorderSizePixel = 0
	DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	DropShadow_1.Size = UDim2.new(1, 120,1, 120)
	DropShadow_1.ZIndex = 0
	DropShadow_1.Image = "rbxassetid://8992230677"
	DropShadow_1.ImageColor3 = Color3.fromRGB(9,14,21)
	DropShadow_1.ScaleType = Enum.ScaleType.Slice
	DropShadow_1.SliceCenter = Rect.new(100, 100, 100, 100)

	Tabs_1.Name = "Tabs"
	Tabs_1.Parent = Background_1
	Tabs_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Tabs_1.BackgroundTransparency = 1
	Tabs_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Tabs_1.BorderSizePixel = 0
	Tabs_1.Size = UDim2.new(0.885714293, 60,0.119999997, 0)

	UIListLayout_1.Parent = Tabs_1
	UIListLayout_1.Padding = UDim.new(0,10)
	UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

	Profile_1.Name = "Profile"
	Profile_1.Parent = Tabs_1
	Profile_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Profile_1.BackgroundColor3 = Color3.fromRGB(40,50,59)
	Profile_1.BackgroundTransparency = 0.8999999761581421
	Profile_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Profile_1.BorderSizePixel = 0
	Profile_1.LayoutOrder = -3
	Profile_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Profile_1.Size = UDim2.new(0, 30,0, 30)
	Profile_1.Image = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

	UICorner_1.Parent = Profile_1
	UICorner_1.CornerRadius = UDim.new(1,0)

	TabScolling_1.Name = "TabScolling"
	TabScolling_1.Parent = Tabs_1
	TabScolling_1.Active = true
	TabScolling_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabScolling_1.BackgroundTransparency = 1
	TabScolling_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TabScolling_1.BorderSizePixel = 0
	TabScolling_1.LayoutOrder = -4
	TabScolling_1.Position = UDim2.new(0.0209523812, 0,0, 0)
	TabScolling_1.Size = UDim2.new(0.887619019, 0,1, 0)
	TabScolling_1.ClipsDescendants = true
	TabScolling_1.AutomaticCanvasSize = Enum.AutomaticSize.None
	TabScolling_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	TabScolling_1.CanvasPosition = Vector2.new(0, 0)
	TabScolling_1.CanvasSize = UDim2.new(2, 0,0, 0)
	TabScolling_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	TabScolling_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	TabScolling_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	TabScolling_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
	TabScolling_1.ScrollBarImageTransparency = 1
	TabScolling_1.ScrollBarThickness = 0
	TabScolling_1.ScrollingDirection = Enum.ScrollingDirection.XY
	TabScolling_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	TabScolling_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
	TabScolling_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

	UIListLayout_2.Parent = TabScolling_1
	UIListLayout_2.Padding = UDim.new(0,5)
	UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
	
	Canvas_X(UIListLayout_2, TabScolling_1, 20)
	
	local UIPadding_1 = Instance.new("UIPadding")
	local Line_1 = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	
	UIPadding_1.Parent = Tabs_1
	UIPadding_1.PaddingTop = UDim.new(0,2)

	Line_1.Name = "Line"
	Line_1.Parent = Background_1
	Line_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Line_1.BackgroundTransparency = 0.949999988079071
	Line_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Line_1.BorderSizePixel = 0
	Line_1.Position = UDim2.new(0, 0,0, 44)
	Line_1.Size = UDim2.new(1, 0,0, 1)

	UICorner_2.Parent = Background_1
	UICorner_2.CornerRadius = UDim.new(0,3)
	
	Env.Tabs = {
		Value = false
	}
	
	function Env.Tabs:Tab(title)
		local List_1 = Instance.new("Frame")
		local Title_1 = Instance.new("TextLabel")
		local clicktab = click(List_1)


		local Pages_1 = Instance.new("Frame")
		local Left_1 = Instance.new("ScrollingFrame")
		local UIListLayout_3 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")
		local Right_1 = Instance.new("ScrollingFrame")
		local UIListLayout_4 = Instance.new("UIListLayout")
		local UIPadding_3 = Instance.new("UIPadding")
		local UIListLayout_5 = Instance.new("UIListLayout")

		List_1.Name = "List"
		List_1.Parent = TabScolling_1
		List_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		List_1.BackgroundTransparency = 1
		List_1.BorderColor3 = Color3.fromRGB(0,0,0)
		List_1.BorderSizePixel = 0
		List_1.Position = UDim2.new(0, 0,0.139534891, 0)
		List_1.Size = UDim2.new(0, 58,0, 31)

		Title_1.Name = "Title"
		Title_1.Parent = List_1
		Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Title_1.BackgroundTransparency = 1
		Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Title_1.BorderSizePixel = 0
		Title_1.Position = UDim2.new(0.5, 0,0.5, 0)
		Title_1.Size = UDim2.new(0.823529422, 0,0, 20)
		Title_1.FontFace = Font.new(GetIcon(12187374537),Enum.FontWeight.Regular)
		Title_1.RichText = true
		Title_1.Text = title
		Title_1.TextColor3 = Color3.fromRGB(255,255,255)
		Title_1.TextSize = 15
		
		List_1.Size = UDim2.new(0, Title_1.TextBounds.X + 15 ,0, 31)

		Pages_1.Name = "Pages"
		Pages_1.Parent = Background_1
		Pages_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Pages_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Pages_1.BackgroundTransparency = 1
		Pages_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Pages_1.BorderSizePixel = 0
		Pages_1.Position = UDim2.new(0.5, 0,0.558666646, 0)
		Pages_1.Size = UDim2.new(1, 0,0.882666647, 0)
		Pages_1.Visible = false

		Left_1.Name = "Left"
		Left_1.Parent = Pages_1
		Left_1.Active = true
		Left_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Left_1.BackgroundTransparency = 1
		Left_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Left_1.BorderSizePixel = 0
		Left_1.Size = UDim2.new(0, 255,1, 0)
		Left_1.ClipsDescendants = true
		Left_1.AutomaticCanvasSize = Enum.AutomaticSize.None
		Left_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		Left_1.CanvasPosition = Vector2.new(0, 0)
		Left_1.CanvasSize = UDim2.new(0, 0,0, 339)
		Left_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		Left_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		Left_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		Left_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
		Left_1.ScrollBarImageTransparency = 1
		Left_1.ScrollBarThickness = 0
		Left_1.ScrollingDirection = Enum.ScrollingDirection.XY
		Left_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		Left_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		Left_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

		UIListLayout_3.Parent = Left_1
		UIListLayout_3.Padding = UDim.new(0,7)
		UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

		UIPadding_2.Parent = Left_1
		UIPadding_2.PaddingTop = UDim.new(0,7)

		Right_1.Name = "Right"
		Right_1.Parent = Pages_1
		Right_1.Active = true
		Right_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Right_1.BackgroundTransparency = 1
		Right_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Right_1.BorderSizePixel = 0
		Right_1.Size = UDim2.new(0, 255,1, 0)
		Right_1.ClipsDescendants = true
		Right_1.AutomaticCanvasSize = Enum.AutomaticSize.None
		Right_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		Right_1.CanvasPosition = Vector2.new(0, 0)
		Right_1.CanvasSize = UDim2.new(0, 0,0, 64)
		Right_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		Right_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		Right_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		Right_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
		Right_1.ScrollBarImageTransparency = 1
		Right_1.ScrollBarThickness = 0
		Right_1.ScrollingDirection = Enum.ScrollingDirection.XY
		Right_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		Right_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		Right_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

		UIListLayout_4.Parent = Right_1
		UIListLayout_4.Padding = UDim.new(0,7)
		UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

		UIPadding_3.Parent = Right_1
		UIPadding_3.PaddingTop = UDim.new(0,7)

		UIListLayout_5.Parent = Pages_1
		UIListLayout_5.Padding = UDim.new(0,3)
		UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Center
		
		Canvas_Y(UIListLayout_3, Left_1, 20)
		Canvas_Y(UIListLayout_4, Right_1, 20)
		
		clicktab.MouseButton1Click:Connect(function()
			for i, v in next, Background_1:GetChildren() do
				if v.Name ==  "Pages" then
					v.Visible = false
					v.Size = UDim2.new(0, 0,0, 0)
				end
			end
			for i, v in next, TabScolling_1:GetChildren() do
				if v:IsA("Frame") then
					v.Title.TextColor3 = Color3.fromRGB(255,255,255)
				end
			end
			Pages_1.Visible = true
			Title_1.TextColor3 = Color3.fromRGB(0, 255, 127)
			tw({
				v = Pages_1,
				t = 0.1,
				s = "Linear",
				d = "Out",
				g = {Size = UDim2.new(1, 0,0.882666647, 0)}
			}):Play()
		end)
		
		delay(0.2,function()
			if not Env.Tabs.Value then
				Env.Tabs.Value = true
				Title_1.TextColor3 = Color3.fromRGB(0, 255, 127)
				Pages_1.Visible = true
				Pages_1.Size = UDim2.new(0, 0,0, 0)
				tw({
					v = Pages_1,
					t = 0.1,
					s = "Linear",
					d = "Out",
					g = {Size = UDim2.new(1, 0,0.882666647, 0)}
				}):Play()
			end
		end)
		
		local function GetSide(side)
			if not side then
				return Left_1
			end
			local sideLower = string.lower(tostring(side))
			if sideLower == "r" or sideLower == "right" or side == 2 then
				return Right_1
			elseif sideLower == "l" or sideLower == "left" or side == 1 then
				return Left_1
			else
				return Left_1
			end
		end
		
		local Section = {}
		
		function Section:Section(t, s)

			local Section = Instance.new("Frame")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local Title_1 = Instance.new("TextLabel")
			local UIPadding_1 = Instance.new("UIPadding")
			local Line_1 = Instance.new("Frame")
			local UIStroke_1 = Instance.new("UIStroke")
			local UICorner_1 = Instance.new("UICorner")

			Section.Name = "Section"
			Section.Parent = GetSide(s)
			Section.BackgroundColor3 = Color3.fromRGB(8,8,8)
			Section.BackgroundTransparency = 0.4000000059604645
			Section.BorderColor3 = Color3.fromRGB(20,20,20)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(0.980000019, 0,0, 150)

			UIListLayout_1.Parent = Section
			UIListLayout_1.Padding = UDim.new(0,5)
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

			Title_1.Name = "Title"
			Title_1.Parent = Section
			Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Title_1.BackgroundTransparency = 1
			Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Title_1.BorderSizePixel = 0
			Title_1.LayoutOrder = -3
			Title_1.Size = UDim2.new(0.899999976, 0,0, 20)
			Title_1.FontFace = Sono()
			Title_1.RichText = true
			Title_1.Text = t
			Title_1.TextColor3 = Color3.fromRGB(255,255,255)
			Title_1.TextSize = 14

			UIPadding_1.Parent = Section
			UIPadding_1.PaddingTop = UDim.new(0,7)

			Line_1.Name = "Line"
			Line_1.Parent = Section
			Line_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Line_1.BackgroundTransparency = 0.949999988079071
			Line_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Line_1.BorderSizePixel = 0
			Line_1.LayoutOrder = -2
			Line_1.Position = UDim2.new(-0.209090903, 0,0.215053767, 0)
			Line_1.Size = UDim2.new(1, 0,0, 1)

			UIStroke_1.Parent = Section
			UIStroke_1.Color = Color3.fromRGB(20,20,20)
			UIStroke_1.Thickness = 1

			UICorner_1.Parent = Section
			UICorner_1.CornerRadius = UDim.new(0,2)
			
			UIListLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Size = UDim2.new(0.980000019, 0, 0, UIListLayout_1.AbsoluteContentSize.Y + 10)
			end)
			
			local Class = {}
			
			function Class:Button(title, call)
				
				local Button = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local TextLabel_1 = Instance.new("TextLabel")
				local cb = click(Button)

				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Button.BorderColor3 = Color3.fromRGB(0,0,0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0.949999988, 0,0, 25)
				Button.ClipsDescendants = true

				UICorner_1.Parent = Button
				UICorner_1.CornerRadius = UDim.new(0,3)

				UIGradient_1.Parent = Button
				UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}
				UIGradient_1.Rotation = -90

				TextLabel_1.Parent = Button
				TextLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				TextLabel_1.BackgroundTransparency = 1
				TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
				TextLabel_1.BorderSizePixel = 0
				TextLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
				TextLabel_1.Size = UDim2.new(0.5, 0,0, 10)
				TextLabel_1.FontFace = Sono()
				TextLabel_1.RichText = true
				TextLabel_1.Text = title
				TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
				TextLabel_1.TextSize = 14
				
				cb.MouseButton1Click:Connect(function()
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					EffectClick(cb, Button)
					call()
				end)
			end
			
			function Class:Toggle(to, v, c)
				local Toggle = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Title_1 = Instance.new("TextLabel")
				local Nocolor_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Nocolor_2 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local TRUE_1 = Instance.new("ImageLabel")
				local ClickToggle = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Toggle.BackgroundTransparency = 0.949999988079071
				Toggle.BorderColor3 = Color3.fromRGB(0,0,0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.949999988, 0,0, 35)
				Toggle.ClipsDescendants = true

				UICorner_1.Parent = Toggle
				UICorner_1.CornerRadius = UDim.new(0,3)

				Title_1.Name = "Title"
				Title_1.Parent = Toggle
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.Position = UDim2.new(0.25, 0,0.5, 0)
				Title_1.Size = UDim2.new(0.411980599, 0,0, 10)
				Title_1.FontFace = Sono()
				Title_1.RichText = true
				Title_1.Text = to
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 14
				Title_1.TextXAlignment = Enum.TextXAlignment.Left
				Title_1.TextTransparency = 0.5

				Nocolor_1.Name = "Nocolor"
				Nocolor_1.Parent = Toggle
				Nocolor_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Nocolor_1.BackgroundColor3 = Color3.fromRGB(48,48,48)
				Nocolor_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Nocolor_1.BorderSizePixel = 0
				Nocolor_1.Position = UDim2.new(0.930000007, 0,0.5, 0)
				Nocolor_1.Size = UDim2.new(0, 20,0, 20)

				UICorner_2.Parent = Nocolor_1
				UICorner_2.CornerRadius = UDim.new(0,3)

				Nocolor_2.Name = "Nocolor"
				Nocolor_2.Parent = Nocolor_1
				Nocolor_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Nocolor_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Nocolor_2.BackgroundTransparency = 1
				Nocolor_2.BorderColor3 = Color3.fromRGB(0,0,0)
				Nocolor_2.BorderSizePixel = 0
				Nocolor_2.Position = UDim2.new(0.5, 0,0.5, 0)
				Nocolor_2.Size = UDim2.new(1, 0,1, 0)

				UICorner_3.Parent = Nocolor_2
				UICorner_3.CornerRadius = UDim.new(0,3)

				UIGradient_1.Parent = Nocolor_2
				UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 57, 28))}
				UIGradient_1.Rotation = 50

				TRUE_1.Name = "TRUE"
				TRUE_1.Parent = Nocolor_2
				TRUE_1.AnchorPoint = Vector2.new(0.5, 0.5)
				TRUE_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				TRUE_1.BackgroundTransparency = 1
				TRUE_1.BorderColor3 = Color3.fromRGB(0,0,0)
				TRUE_1.BorderSizePixel = 0
				TRUE_1.Position = UDim2.new(0.5, 0,0.5, 0)
				TRUE_1.Size = UDim2.new(0, 0,0, 0)
				TRUE_1.Image = "rbxassetid://99035215947422"
				
				local function Togglex(Value)
					if not Value then 
						c(Value)
						tw({
							v = Nocolor_2,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 1}
						}):Play()
						tw({
							v = TRUE_1,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0, 0,0, 0)}
						}):Play()
						tw({
							v = Title_1,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {TextTransparency = 0.5}
						}):Play()
					elseif Value then 
						c(Value)
						tw({
							v = Nocolor_2,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 0}
						}):Play()
						tw({
							v = Title_1,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {TextTransparency = 0}
						}):Play()
						tw({
							v = TRUE_1,
							t = 0.1,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0.8, 0,0.8, 0)}
						}):Play()
						delay(0.05, function()
							tw({
								v = TRUE_1,
								t = 0.2,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0.5, 0,0.5, 0)}
							}):Play()
						end)
					end
				end

				ClickToggle.MouseButton1Click:Connect(function()
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					v = not v
					Togglex(v)
				end)

				Togglex(v)
			end
			
			function Class:Dropdown(info)
				local Title = info.Title
				local List = info.List or {}
				local Value = info.Value
				local Multi = info.Multi or false
				local Callback = info.Callback
				
				local Dropdown = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Title_1 = Instance.new("TextLabel")
				local Icon_1 = Instance.new("ImageLabel")
				local Desc_1 = Instance.new("TextLabel")
				local ClickDropdown = click(Dropdown)

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Section
				Dropdown.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Dropdown.BackgroundTransparency = 0.949999988079071
				Dropdown.BorderColor3 = Color3.fromRGB(0,0,0)
				Dropdown.BorderSizePixel = 0
				Dropdown.Size = UDim2.new(0.949999988, 0,0, 40)

				UICorner_1.Parent = Dropdown
				UICorner_1.CornerRadius = UDim.new(0,3)

				Title_1.Name = "Title"
				Title_1.Parent = Dropdown
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.Position = UDim2.new(0.25, 0,0.400000006, 0)
				Title_1.Size = UDim2.new(0.411980569, 0,0.075000003, 10)
				Title_1.FontFace = Sono()
				Title_1.RichText = true
				Title_1.Text = Title
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 14
				Title_1.TextXAlignment = Enum.TextXAlignment.Left

				Icon_1.Name = "Icon"
				Icon_1.Parent = Dropdown
				Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Icon_1.BackgroundTransparency = 1
				Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Icon_1.BorderSizePixel = 0
				Icon_1.Position = UDim2.new(0.920000017, 0,0.5, 0)
				Icon_1.Size = UDim2.new(0, 20,0, 20)
				Icon_1.Image = "rbxassetid://129573215183311"

				Desc_1.Name = "Desc"
				Desc_1.Parent = Dropdown
				Desc_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Desc_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Desc_1.BackgroundTransparency = 1
				Desc_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Desc_1.BorderSizePixel = 0
				Desc_1.Position = UDim2.new(0.24999997, 0,0.705356956, 0)
				Desc_1.Size = UDim2.new(0.411980569, 0,0.160713956, 10)
				Desc_1.FontFace = SonoM()
				Desc_1.RichText = true
				local function Update()
					if type(Value) == "table" then
						Desc_1.Text = table.concat(Value, ", ")
					else
						Desc_1.Text = Value
					end
				end
				Desc_1.TextColor3 = Color3.fromRGB(0, 255, 127)
				Desc_1.TextSize = 11
				Desc_1.TextXAlignment = Enum.TextXAlignment.Left
				Desc_1.TextTruncate = Enum.TextTruncate.AtEnd
				
				
				local DropdownB = Instance.new("Frame")
				local DropShadow_1 = Instance.new("ImageLabel")
				local Search_1 = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local TextBox_1 = Instance.new("TextBox")
				local UIStroke_1 = Instance.new("UIStroke")
				local ScrollingFrame_1 = Instance.new("ScrollingFrame")
				local UIListLayout_1 = Instance.new("UIListLayout")
				local UICorner_3 = Instance.new("UICorner")
				local UIStroke_2 = Instance.new("UIStroke")

				DropdownB.Name = "DropdownB"
				DropdownB.Parent = Background_1
				DropdownB.AnchorPoint = Vector2.new(0.5, 0.5)
				DropdownB.BackgroundColor3 = Color3.fromRGB(8,8,8)
				DropdownB.BorderColor3 = Color3.fromRGB(0,0,0)
				DropdownB.BorderSizePixel = 0
				DropdownB.Position = UDim2.new(0.5, 0,0.497552395, 0)
				DropdownB.Size = UDim2.new(0, 250,0, 306)
				DropdownB.Visible = false
				DropdownB.ZIndex = 3

				DropShadow_1.Name = "DropShadow"
				DropShadow_1.Parent = DropdownB
				DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
				DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
				DropShadow_1.BackgroundTransparency = 1
				DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
				DropShadow_1.BorderSizePixel = 0
				DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
				DropShadow_1.Size = UDim2.new(1, 120,1, 120)
				DropShadow_1.ZIndex = 2
				DropShadow_1.Image = "rbxassetid://8992230677"
				DropShadow_1.ImageColor3 = Color3.fromRGB(0,0,0)
				DropShadow_1.ImageTransparency = 0.30000001192092896
				DropShadow_1.ScaleType = Enum.ScaleType.Slice
				DropShadow_1.SliceCenter = Rect.new(100, 100, 100, 100)

				Search_1.Name = "Search"
				Search_1.Parent = DropdownB
				Search_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Search_1.BackgroundColor3 = Color3.fromRGB(45,45,45)
				Search_1.BackgroundTransparency = 0.5
				Search_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Search_1.BorderSizePixel = 0
				Search_1.Position = UDim2.new(0.5, 0,0.0867868811, 0)
				Search_1.Size = UDim2.new(0.920000017, 0,0.00689166877, 25)
				Search_1.ZIndex = 3

				UICorner_1.Parent = Search_1
				UICorner_1.CornerRadius = UDim.new(1,0)

				TextBox_1.Parent = Search_1
				TextBox_1.Active = true
				TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				TextBox_1.BackgroundTransparency = 1
				TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
				TextBox_1.BorderSizePixel = 0
				TextBox_1.Position = UDim2.new(0.5, 0,0.5, 0)
				TextBox_1.Size = UDim2.new(1, 0,1, 0)
				TextBox_1.ZIndex = 3
				TextBox_1.FontFace = SonoM()
				TextBox_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
				TextBox_1.PlaceholderText = "Search"
				TextBox_1.Text = ""
				TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
				TextBox_1.TextSize = 14

				UIStroke_1.Parent = Search_1
				UIStroke_1.Color = Color3.fromRGB(255,255,255)
				UIStroke_1.Thickness = 1
				UIStroke_1.Transparency = 0.8

				ScrollingFrame_1.Name = "ScrollingFrame"
				ScrollingFrame_1.Parent = DropdownB
				ScrollingFrame_1.Active = true
				ScrollingFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ScrollingFrame_1.BackgroundTransparency = 1
				ScrollingFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
				ScrollingFrame_1.BorderSizePixel = 0
				ScrollingFrame_1.Position = UDim2.new(0.0500000007, 0,0.172311857, 0)
				ScrollingFrame_1.Size = UDim2.new(0.899999976, 0,0.787610233, 0)
				ScrollingFrame_1.ZIndex = 3
				ScrollingFrame_1.ClipsDescendants = true
				ScrollingFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.None
				ScrollingFrame_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
				ScrollingFrame_1.CanvasPosition = Vector2.new(0, 0)
				ScrollingFrame_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
				ScrollingFrame_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				ScrollingFrame_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
				ScrollingFrame_1.ScrollBarImageTransparency = 1
				ScrollingFrame_1.ScrollBarThickness = 0
				ScrollingFrame_1.ScrollingDirection = Enum.ScrollingDirection.XY
				ScrollingFrame_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
				ScrollingFrame_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

				Canvas_Y(UIListLayout_1, ScrollingFrame_1, 20)

				UIListLayout_1.Parent = ScrollingFrame_1
				UIListLayout_1.Padding = UDim.new(0,5)
				UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
				
				UICorner_3.Parent = DropdownB

				UIStroke_2.Parent = DropdownB
				UIStroke_2.Color = Color3.fromRGB(25,25,25)
				UIStroke_2.Thickness = 1
				
				
				
				local isOpen = false
				UserInputService.InputBegan:Connect(function(A)
					if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
						local mouse = game:GetService("Players").LocalPlayer:GetMouse()
						local mx, my = mouse.X, mouse.Y

						local DBP, DBS = DropdownB.AbsolutePosition, DropdownB.AbsoluteSize
						local TBP, TBS = TextBox_1.AbsolutePosition, TextBox_1.AbsoluteSize
						local SBP, SBS = Search_1.AbsolutePosition, Search_1.AbsoluteSize

						local function inside(pos, size)
							return mx >= pos.X and mx <= pos.X + size.X and my >= pos.Y and my <= pos.Y + size.Y
						end

						if not inside(DBP, DBS)
							and not inside(TBP, TBS)
							and not inside(SBP, SBS) then
							isOpen = false
							DropdownB.Size = UDim2.new(0, 0, 0, 306)
							DropdownB.Visible = false
						end
					end
				end)

				ClickDropdown.MouseButton1Click:Connect(function()
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					isOpen = not isOpen
					if isOpen then
						DropdownB.Visible = true
						tw({
							v = DropdownB,
							t = 0.3,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0, 250,0, 306)}
						}):Play()
					else
						tw({
							v = DropdownB,
							t = 0.3,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0, 250,0, 306)}
						}):Play()
						DropdownB.Visible = false
					end
					tw({
						v = Icon_1,
						t = 0.15,
						s = "Bounce",
						d = "Out",
						g = {Size = UDim2.new(0, 40,0, 40)}
					}):Play()
					delay(0.06, function()
						tw({
							v = Icon_1,
							t = 0.15,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0, 20,0, 20)}
						}):Play()
					end)
				end)

				TextBox_1.Changed:Connect(function()
					local SearchT = string.lower(TextBox_1.Text)
					for i, v in next, ScrollingFrame_1:GetChildren() do
						if v:IsA("Frame") then
							local labelText = string.lower(v.Real.Title.Text)
							if string.find(labelText, SearchT, 1, true) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end)

				local itemslist = {}
				local selectedItem

				function itemslist:Clear(a)
					local function shouldClear(v)
						if a == nil then
							return true
						elseif type(a) == "string" then
							return v.Real:FindFirstChild("Title") and v.Real.Title.Text == a
						elseif type(a) == "table" then
							for _, name in next, a do
								if v.Real:FindFirstChild("Title") and v.Real.Title.Text == name then
									return true
								end
							end
						end
						return false
					end

					for _, v in next, ScrollingFrame_1:GetChildren() do
						if v:IsA("Frame") and shouldClear(v) then
							if selectedItem and v.Real:FindFirstChild("Title") and v.Real.Title.Text == selectedItem then
								selectedItem = nil
								Desc_1.Text = "N/A"
							end
							v:Destroy()
						end
					end

					if selectedItem == a or Desc_1.Text == a then
						selectedItem = nil
						Desc_1.Text = "N/A"
					end

					if a == nil then
						selectedItem = nil
						Desc_1.Text = "N/A"
					end
				end

				local selectedValues = {}

				local function isValueInTable(val, tbl)
					if type(tbl) ~= "table" then
						return false
					end

					for _, v in next, tbl do
						if v == val then
							return true
						end
					end
					return false
				end
				
				function itemslist:AddList(text)
					local Items_1 = Instance.new("Frame")
					local Real_1 = Instance.new("Frame")
					local Title_1 = Instance.new("TextLabel")
					local Line_1 = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local UIListLayout_2 = Instance.new("UIListLayout")
					local ClickList = click(Items_1)

					Items_1.Name = "Items"
					Items_1.Parent = ScrollingFrame_1
					Items_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Items_1.BackgroundTransparency = 1
					Items_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Items_1.BorderSizePixel = 0
					Items_1.Size = UDim2.new(1, 0,0, 30)
					Items_1.ZIndex = 3

					Real_1.Name = "Real"
					Real_1.Parent = Items_1
					Real_1.AnchorPoint = Vector2.new(0.5, 0.5)
					Real_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Real_1.BackgroundTransparency = 1
					Real_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Real_1.BorderSizePixel = 0
					Real_1.Position = UDim2.new(0.5, 0,0.5, 0)
					Real_1.Size = UDim2.new(1, 0,1, 0)
					Real_1.ZIndex = 3

					Title_1.Name = "Title"
					Title_1.Parent = Real_1
					Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Title_1.BackgroundTransparency = 1
					Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Title_1.BorderSizePixel = 0
					Title_1.LayoutOrder = -1
					Title_1.Position = UDim2.new(0.57476455, 0,0.5, 0)
					Title_1.Size = UDim2.new(0.660639942, 0,1, 0)
					Title_1.ZIndex = 3
					Title_1.FontFace = SonoM()
					Title_1.Text = text
					Title_1.TextColor3 = Color3.fromRGB(255,255,255)
					Title_1.TextSize = 14
					Title_1.TextXAlignment = Enum.TextXAlignment.Left
					Title_1.TextTransparency = 0.5

					Line_1.Name = "Line"
					Line_1.Parent = Real_1
					Line_1.AnchorPoint = Vector2.new(0, 0.5)
					Line_1.BackgroundColor3 = Color3.fromRGB(0,255,127)
					Line_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Line_1.BorderSizePixel = 0
					Line_1.LayoutOrder = -3
					Line_1.Position = UDim2.new(0, 0,0.5, 0)
					Line_1.Size = UDim2.new(0, 5,1, 0)
					Line_1.ZIndex = 3
					Line_1.BackgroundTransparency = 1

					UICorner_2.Parent = Line_1
					UICorner_2.CornerRadius = UDim.new(1,0)

					UIListLayout_2.Parent = Real_1
					UIListLayout_2.Padding = UDim.new(0,10)
					UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
					UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
					
					ClickList.MouseButton1Click:Connect(function()
						Update()
						if Multi then
							if selectedValues[text] then
								selectedValues[text] = nil
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0.5}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 1}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 1}
								}):Play()
							else
								selectedValues[text] = true
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.9}
								}):Play()
							end
							local selectedList = {}
							for i, v in next, selectedValues do
								table.insert(selectedList, i)
							end
							if #selectedList > 0 then
								Value = selectedList
								Update()
							else
								Desc_1.Text = "N/A"
							end
							pcall(Callback, selectedList)
						else
							for i,v in next, ScrollingFrame_1:GetChildren() do
								if v:IsA("Frame") then
									tw({
										v = v.Real.Title,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {TextTransparency = 0.5}
									}):Play()
									tw({
										v = v.Real.Line,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {BackgroundTransparency = 1}
									}):Play()
									tw({
										v = v,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {BackgroundTransparency = 1}
									}):Play()
								end
							end

							tw({
								v = Title_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {TextTransparency = 0}
							}):Play()
							tw({
								v = Line_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {BackgroundTransparency = 0}
							}):Play()
							tw({
								v = Items_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {BackgroundTransparency = 0.9}
							}):Play()
							tw({
								v = DropdownB,
								t = 0.3,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0, 0,0, 374)}
							}):Play()
							isOpen = false
							Value = text
							Desc_1.Text = text
							pcall(function()
								Callback(Desc_1.Text)
							end)
							task.wait(0.05)
							DropdownB.Visible = false
						end
					end)

					delay(0,function()
						if Multi then
							if isValueInTable(text, Value) then
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.85}
								}):Play()
								selectedValues[text] = true
								local selectedList = {}
								for i, v in next, selectedValues do
									table.insert(selectedList, i)
								end
								if #selectedList > 0 then
									Update()
								else
									Desc_1.Text = "N/A"
								end
								pcall(Callback, selectedList)
							end
						else
							if text == Value then
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.85}
								}):Play()
								Value = text
								Desc_1.Text = text
								Callback(Desc_1.Text)
							end
						end
					end)
				end
				
				for _, name in next, List do
					itemslist:AddList(name)
				end

				return itemslist
			end
			
			function Class:Slider(info)
				local Title = info.Title
				local Min = info.Min or 0
				local Max = info.Max or 100
				local Rounding = info.Rounding or 0
				local Value = info.Value or Min
				local Callback = info.CallBack or function() end

				local Slider = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Title_1 = Instance.new("TextLabel")
				local Boxval_1 = Instance.new("TextBox")
				local Nova_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local val_1 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local Circle_1 = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local Slide = click(Slider)

				Slider.Name = "Slider"
				Slider.Parent = Section
				Slider.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Slider.BackgroundTransparency = 0.949999988079071
				Slider.BorderColor3 = Color3.fromRGB(0,0,0)
				Slider.BorderSizePixel = 0
				Slider.Size = UDim2.new(0.949999988, 0,0, 40)

				UICorner_1.Parent = Slider
				UICorner_1.CornerRadius = UDim.new(0,3)

				Title_1.Name = "Title"
				Title_1.Parent = Slider
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.Position = UDim2.new(0.135, 0,0.5, 0)
				Title_1.Size = UDim2.new(0.2, 0,0.075000003, 10)
				Title_1.FontFace = Sono()
				Title_1.RichText = true
				Title_1.Text = Title
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 11
				Title_1.TextTruncate = Enum.TextTruncate.AtEnd
				Title_1.TextXAlignment = Enum.TextXAlignment.Center

				Boxval_1.Name = "Boxval"
				Boxval_1.Parent = Slider
				Boxval_1.Active = true
				Boxval_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Boxval_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Boxval_1.BackgroundTransparency = 1
				Boxval_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Boxval_1.BorderSizePixel = 0
				Boxval_1.CursorPosition = -1
				Boxval_1.Position = UDim2.new(0.899999917, 0,0.5, 0)
				Boxval_1.Size = UDim2.new(0, 30,0, 25)
				Boxval_1.FontFace = SonoM()
				Boxval_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
				Boxval_1.PlaceholderText = "..."
				Boxval_1.Text = tostring(Value)
				Boxval_1.TextColor3 = Color3.fromRGB(255,255,255)
				Boxval_1.TextSize = 11
				Boxval_1.TextTransparency = 0.5
				Boxval_1.TextWrapped = true
				Boxval_1.TextXAlignment = Enum.TextXAlignment.Right
				Boxval_1.ZIndex = Slide.ZIndex

				Nova_1.Name = "Nova"
				Nova_1.Parent = Slider
				Nova_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Nova_1.BackgroundColor3 = Color3.fromRGB(48,48,48)
				Nova_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Nova_1.BorderSizePixel = 0
				Nova_1.Position = UDim2.new(0.537205458, 0,0.5, 0)
				Nova_1.Size = UDim2.new(0.569678426, 0,0.174999997, 0)

				UICorner_2.Parent = Nova_1

				val_1.Name = "val"
				val_1.Parent = Nova_1
				val_1.AnchorPoint = Vector2.new(0, 0.5)
				val_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				val_1.BorderColor3 = Color3.fromRGB(0,0,0)
				val_1.BorderSizePixel = 0
				val_1.Position = UDim2.new(0, 0,0.5, 0)
				val_1.Size = UDim2.new(0, 50,1, 0)

				UICorner_3.Parent = val_1

				UIGradient_1.Parent = val_1
				UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 42, 20))}
				UIGradient_1.Rotation = -90

				Circle_1.Name = "Circle"
				Circle_1.Parent = val_1
				Circle_1.AnchorPoint = Vector2.new(1, 0.5)
				Circle_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Circle_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Circle_1.BorderSizePixel = 0
				Circle_1.Position = UDim2.new(1, 0,0.5, 0)
				Circle_1.Size = UDim2.new(0, 10,0, 12)

				UICorner_4.Parent = Circle_1
				UICorner_4.CornerRadius = UDim.new(1,0)
				
				local function roundToDecimal(value, decimals)
					local factor = 10 ^ decimals
					return math.floor(value * factor + 0.5) / factor
				end

				local function updateSlider(value)
					value = math.clamp(value, Min, Max)
					value = roundToDecimal(value, Rounding)
					tw({
						v = val_1,
						t = 0.15,
						s = "Exponential",
						d = "Out",
						g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
					}):Play()
					local startValue = tonumber(Boxval_1.Text) or 0
					local targetValue = value

					local steps = 5
					local currentValue = startValue
					for i = 1, steps do
						task.wait(0.01 / steps)
						currentValue = currentValue + (targetValue - startValue) / steps
						Boxval_1.Text = tostring(roundToDecimal(currentValue, Rounding))
					end

					Boxval_1.Text = tostring(roundToDecimal(targetValue, Rounding))

					Callback(value)
				end

				updateSlider(Value or 0)

				local function move(input)
					local sliderBar = Nova_1
					local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
					local value = relativeX * (Max - Min) + Min
					updateSlider(value)
				end

				Boxval_1.FocusLost:Connect(function()
					local value = tonumber(Boxval_1.Text) or Min
					updateSlider(value)
				end)

				local dragging = false

				Slide.InputBegan:Connect(function(input)
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						move(input)
					end
				end)

				Slide.InputEnded:Connect(function(input)
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					for _, v in next, Background_1:GetChildren() do
						if v.Name == "DropdownB" and v.Visible then
							return
						end
					end
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						move(input)
					end
				end)
			end
			
			function Class:Textbox(meta)
				
				local Value = meta.Value or "Example"
				local ClearOnFocus = meta.ClearOnFocus or false
				local Callback = meta.Callback

				local Textbox = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Val_1 = Instance.new("TextBox")

				Textbox.Name = "Textbox"
				Textbox.Parent = Section
				Textbox.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Textbox.BackgroundTransparency = 0.949999988079071
				Textbox.BorderColor3 = Color3.fromRGB(0,0,0)
				Textbox.BorderSizePixel = 0
				Textbox.Size = UDim2.new(0.949999988, 0,0, 25)

				UICorner_1.Parent = Textbox
				UICorner_1.CornerRadius = UDim.new(0,3)

				Val_1.Name = "Val"
				Val_1.Parent = Textbox
				Val_1.Active = true
				Val_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Val_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Val_1.BackgroundTransparency = 1
				Val_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Val_1.BorderSizePixel = 0
				Val_1.CursorPosition = -1
				Val_1.Position = UDim2.new(0.5, 0,0.5, 0)
				Val_1.Size = UDim2.new(0.899999976, 0,0.899999976, 0)
				Val_1.FontFace = Sono()
				Val_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
				Val_1.PlaceholderText = "..."
				Val_1.Text = tostring(Value)
				Val_1.TextColor3 = Color3.fromRGB(255,255,255)
				Val_1.TextSize = 10
				Val_1.TextTransparency = 0.5
				Val_1.TextTruncate = Enum.TextTruncate.AtEnd
				Val_1.TextXAlignment = Enum.TextXAlignment.Center
				Val_1.ClearTextOnFocus = ClearOnFocus
				
				Val_1.FocusLost:Connect(function()
					if #Val_1.Text > 0 then
						pcall(Callback, Val_1.Text)
					end
				end)
			end
			
			function Class:Label(t)
				local Label = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Title_1 = Instance.new("TextLabel")

				Label.Name = "Label"
				Label.Parent = Section
				Label.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Label.BackgroundTransparency = 1
				Label.BorderColor3 = Color3.fromRGB(0,0,0)
				Label.BorderSizePixel = 0
				Label.Size = UDim2.new(0.899999976, 0,0, 16)

				UICorner_1.Parent = Label
				UICorner_1.CornerRadius = UDim.new(0,3)

				Title_1.Name = "Title"
				Title_1.Parent = Label
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.LayoutOrder = 1
				Title_1.Position = UDim2.new(0.5, 0,0.5, 0)
				Title_1.Size = UDim2.new(1, 0,0, 10)
				Title_1.FontFace = Sono()
				Title_1.RichText = true
				Title_1.Text = t
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 14
				Title_1.TextWrapped = true
				Title_1.TextXAlignment = Enum.TextXAlignment.Left
				
				
				Title_1.Size = UDim2.new(1, 0,0, Title_1.TextBounds.Y)
				Label.Size = UDim2.new(0.899999976, 0,0, Title_1.TextBounds.Y + 10)
				
				local o = {}
				
				function o:Title(a)
					Title_1.Text = a
					Title_1.Size = UDim2.new(1, 0,0, Title_1.TextBounds.Y)
					Label.Size = UDim2.new(0.899999976, 0,0, Title_1.TextBounds.Y + 5)
				end
				
				return o
			end
			
			return Class
		end
		
		return Section
	end
	
	return Env.Tabs
end

return Env
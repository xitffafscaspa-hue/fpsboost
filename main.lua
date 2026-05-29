--// FPS BOOSTER GUI

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BoostGui"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 190)
frame.Position = UDim2.new(0.5, -130, 0.5, -95)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "FPS BOOSTER"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

-- função criar botão
local function createButton(text, posY)
	local button = Instance.new("TextButton")
	button.Parent = frame
	button.Size = UDim2.new(0,220,0,40)
	button.Position = UDim2.new(0.5,-110,0,posY)
	button.BackgroundColor3 = Color3.fromRGB(30,30,30)
	button.TextColor3 = Color3.new(1,1,1)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.Text = text
	button.AutoButtonColor = true
	
	local c = Instance.new("UICorner", button)
	c.CornerRadius = UDim.new(0,12)
	
	return button
end

local boostBtn = createButton("Boost FPS", 50)
local stretchBtn = createButton("Esticar Tela", 100)
local playerBtn = createButton("Boost Player", 150)

-- Minimizar com CTRL
local visible = true

UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	
	if input.KeyCode == Enum.KeyCode.LeftControl 
	or input.KeyCode == Enum.KeyCode.RightControl then
		
		visible = not visible
		frame.Visible = visible
	end
end)

-- BOOST FPS
boostBtn.MouseButton1Click:Connect(function()

	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	Lighting.Brightness = 0
	
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	
	for _,v in pairs(Lighting:GetChildren()) do
		if v:IsA("BloomEffect")
		or v:IsA("BlurEffect")
		or v:IsA("SunRaysEffect")
		or v:IsA("ColorCorrectionEffect")
		or v:IsA("DepthOfFieldEffect") then
			v:Destroy()
		end
	end
	
	if Terrain then
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 1
		
		pcall(function()
			sethiddenproperty(Terrain,"Decoration",false)
		end)
	end
	
	for _,obj in pairs(game:GetDescendants()) do
		
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.Reflectance = 0
			obj.CastShadow = false
			
		elseif obj:IsA("Texture")
		or obj:IsA("Decal") then
			obj:Destroy()
			
		elseif obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Smoke")
		or obj:IsA("Sparkles")
		or obj:IsA("Fire") then
			obj:Destroy()
		end
	end
	
	boostBtn.Text = "Boostado!"
	wait(1)
	boostBtn.Text = "Boost FPS"
end)

-- ESTICAR TELA
stretchBtn.MouseButton1Click:Connect(function()

	pcall(function()
		local camera = workspace.CurrentCamera
		camera.FieldOfView = 120
	end)
	
	stretchBtn.Text = "Tela Esticada!"
	wait(1)
	stretchBtn.Text = "Esticar Tela"
end)

-- BOOST PLAYER
playerBtn.MouseButton1Click:Connect(function()

	local function optimizeCharacter(char)
		for _,v in pairs(char:GetDescendants()) do
			
			if v:IsA("Accessory") then
				v:Destroy()
				
			elseif v:IsA("Shirt")
			or v:IsA("Pants")
			or v:IsA("ShirtGraphic") then
				v:Destroy()
				
			elseif v:IsA("CharacterMesh") then
				v:Destroy()
				
			elseif v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.CastShadow = false
			end
		end
	end
	
	for _,plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			optimizeCharacter(plr.Character)
		end
		
		plr.CharacterAdded:Connect(optimizeCharacter)
	end
	
	playerBtn.Text = "Players Boostados!"
	wait(1)
	playerBtn.Text = "Boost Player"
end)

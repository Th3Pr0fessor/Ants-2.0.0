local middleclass = {}
middleclass.__index = middleclass
local Size = 3
local rotate = CFrame.fromEulerAnglesXYZ
function middleclass.new()
	local Fractal = {}
    setmetatable(Fractal, middleclass)
	Fractal.Length = 1
	return Fractal
end
local num = 0
middleclass.Plate = function(CF, Color)
	local P2 = Instance.new("Part")
	P2.Anchored = true
	P2.Size = Vector3.new(1,.05,1)
	P2.Name = num.." Divider"
	P2.CFrame = CF
	P2.BrickColor = Color
	P2.Material = Enum.Material.Neon
	P2.Parent = game.Workspace
end
local Hreturner = function()
	local X = math.random(1, 100)/100
	return .67
end
local degreturner = function(Cap)
	local X = math.rad(math.random(-Cap,Cap))
	return X
end
middleclass.Leaf = function(CF, Color, S)
	local P2 = Instance.new("Part")
	P2.Anchored = true
	P2.Size = Vector3.new(S,S,S)
	P2.CFrame = CF * rotate(degreturner(360),degreturner(360),degreturner(360))
	P2.BrickColor = Color
	P2.Material = Enum.Material.Grass
	P2.Parent = game.Workspace
end

middleclass.Intersect = function(CF, p)
	local Part = Instance.new("Part")
	Part.Parent = p.Parent
	Part.Anchored = true
	Part.Name = "Ball"
	Part.Shape = Enum.PartType.Ball
	Part.Size = Vector3.new(Size,Size,Size)
	Part.CFrame = CF
	Part.Color = p.Color
	--Part.Color = Color3.fromRGB(86, 66, 54)
	Part.Material = Enum.Material.SmoothPlastic
end

function middleclass:branch(height, p, deg, deg2)
	local Cap = 45
	if height < 1 then
		local store2 = self.CF * CFrame.new(0,(p.Size.Y/2), 0)
		middleclass.Plate(store2, BrickColor.Green())
		return
	end
	self.Size = Vector3.new(Size, height, Size)
	self.Len = self.Size.y
	self.CF = p.CFrame
	local Part = game.ReplicatedStorage.Cylinder:Clone()--Instance.new("Part")
	Part.Parent = p.Parent
	Part.Anchored = true
	Part.Size = self.Size
	--Part.BrickColor = BrickColor.Red()
	Part.Color = Color3.fromRGB(86, 66, 54)
	Part.Material = Enum.Material.SmoothPlastic
	if num == 0 then
		local store = self.CF * CFrame.new(0,(p.Size.Y/2+ Part.Size.Y/2),0)
		Part.CFrame = store
		num = num + 1
		for d = 1,1 do
			for i =1, 2 do
				spawn(function()
					if i == 1 then
						middleclass:branch(height * Hreturner(), Part,degreturner(Cap), -degreturner(Cap))
					elseif i == 2 then
						middleclass:branch(height * Hreturner(), Part, -degreturner(Cap), degreturner(Cap))
					end
				end)
			end
		end
	else
		num = num + 1
		local store3 = self.CF * CFrame.new(0,(p.Size.Y/2),0)
		local store2 = self.CF * CFrame.new(0,(p.Size.Y/2+ Part.Size.Y), 0)
		local store4 = self.CF * CFrame.new(0,-(p.Size.Y/2),0)
		local CF = store3
		local S, E = pcall(function()
			Part.CFrame = CF * rotate(deg2,0,deg)
		end)
		if S == false then
			Part.CFrame = CF * rotate(-degreturner(0),0,degreturner(0))
		end
		middleclass.Intersect(CF, p)
		Part.CFrame = Part.CFrame:ToWorldSpace(CFrame.new(0,Part.Size.Y/2,0))
		
	
		if height > 2 then
			for d = 1,1 do
				for i =1, 2 do
					spawn(function()
						if i == 1 then
							middleclass:branch(height * Hreturner(), Part,degreturner(Cap), -degreturner(Cap))
						elseif i == 2 then
							middleclass:branch(height * Hreturner(), Part, -degreturner(Cap), degreturner(Cap))
						end
					end)
				end
			end
		else
			middleclass.Leaf(store2, BrickColor.Green(),5)
		end
	end
end

return middleclass

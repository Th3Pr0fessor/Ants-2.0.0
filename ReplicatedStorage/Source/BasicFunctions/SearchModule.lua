local Ants = {}

Ants.FindNearestAnt = function(User, MaxDistance)
	local BeingSearched = game.Workspace:GetDescendants()
	local Temp = nil
	local Dist = MaxDistance
	local Found = nil
	for i = 1, #BeingSearched do
		local Chosen = BeingSearched[i]
		if Chosen.ClassName == "Model" and Chosen.Parent ~= User.Parent then
			local S, E = pcall(function()
				Temp = Chosen.PrimaryPart
				local TempDist = (User.PrimaryPart.Position - Temp.Position).Magnitude
				if TempDist <= Dist then
					Dist = TempDist
					Found = Temp.Parent
				end
			end)
			if S ~= true then
				return nil
			end
		end
	end
	return Found
end

Ants.FindNearestResource = function(User, MaxDistance, Resource)
	local BeingSearched = game.Workspace:GetDescendants()
	local Temp = nil
	local Dist = MaxDistance
	local Found = nil
	for i = 1, #BeingSearched do
		local Chosen = BeingSearched[i] 
		if Chosen.ClassName == "Part" and Chosen.Name == Resource then
			Temp = Chosen
			local TempDist = (User.PrimaryPart.Position - Temp.Position).Magnitude
			if TempDist <= Dist then
				Dist = TempDist
				Found = Temp
			end
		end
	end
	return Found
end

Ants.Collect = function(Ant, Resource)
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(1,1,1)
	Part.Parent = Ant
	Part.CanCollide = false
	Part.Anchored = false
	if Resource == "Food" then
		Part.Color = Color3.fromRGB(49, 255, 6)
		Part.Material = Enum.Material.Grass
	elseif Resource == "Dirt" then
		Part.Color = Color3.fromRGB(105, 64, 40)
		Part.Material = Enum.Material.Grass
	end
	local Weld = Instance.new("Weld")
	Weld.Part0 = Ant.PrimaryPart
	Weld.Part1 = Part
	Weld.C1 = CFrame.new(0,-1,0)
	Weld.Parent = Part
	return Weld
end

Ants.Retrieve = function(Ant, Resource)
	if Resource == nil then
		warn("You did not label the resource")
		return
	end
    if Ant.Configuration.IsActive.Value == false then
        Ant.Configuration.IsActive.Value = true
        local Found = nil
        repeat
            Found = Ants.FindNearestResource(Ant, 300, Resource)
            wait()
		until Found ~= nil
		if Found.Size.X < 1 then
			Found:Destroy()
			Ant.Configuration.IsActive.Value = false
			Ants.Retrieve(Ant, Resource)
		end
		local S, E = pcall(function()
			local Hum = Ant.Humanoid
			if Found.Size.X >= 1 then
				Hum:MoveTo(Found.Position)
				Hum.MoveToFinished:Wait()
				if Found.Size.X < 1 then -- ;-;
					Found:Destroy()
					Ant.Configuration.IsActive.Value = false
					Ants.Retrieve(Ant, Resource)
				else
					Found.Size = Found.Size - Vector3.new(1,1,1)
					local weld = Ants.Collect(Ant, Resource)
					Hum:MoveTo(Ant.Parent.Deposit.Position)
					Hum.MoveToFinished:Wait()
					weld:Destroy()
					Ant.Configuration.IsActive.Value = false
					Ants.Retrieve(Ant, Resource)
				end
			end
		end)
		if S == false then
			Ant.Configuration.IsActive.Value = false
			Ants.Retrieve(Ant, Resource)
		else
			Ant.Configuration.IsActive.Value = false
			Ants.Retrieve(Ant, Resource)
		end
    end
end

Ants.ArmyFunction = function(Ant)
	if Ant.Configuration.IsActive.Value == false then
		Ant.Configuration.IsActive.Value = true
        local Found = nil
        repeat
            Found = Ants.FindNearestAnt(Ant, 300)
            wait()
		until Found ~= nil
		local S, E = pcall(function()
			local Hum = Ant.Humanoid
			local S, E = pcall(function()
				if Found.Humanoid.Health > 0 or Found ~= nil then
					Hum:MoveTo(Found.PrimaryPart.Position)
					Hum.MoveToFinished:Wait()
					local S, E = pcall(function()
						Found.Humanoid:TakeDamage(10)
						if Found.Humanoid.Health == 0 then
							Found:Destroy()
							Ant.Configuration.IsActive.Value = false
							Ants.Retrieve(Ant)
						else
							Ant.Configuration.IsActive.Value = false
							Ants.Retrieve(Ant)
						end
					end)
					if S == false then
						Ant.Configuration.IsActive.Value = false
						Ants.Retrieve(Ant)
					else
						Ant.Configuration.IsActive.Value = false
						Ants.Retrieve(Ant)
					end
				else
					Ant.Configuration.IsActive.Value = false
					Ants.Retrieve(Ant)
				end
			end)
			if S == false then
				Ant.Configuration.IsActive.Value = false
				Ants.Retrieve(Ant)
			else
				Ant.Configuration.IsActive.Value = false
				Ants.Retrieve(Ant)
			end
		end)
		if S == false then
			Ant.Configuration.IsActive.Value = false
			Ants.Retrieve(Ant)
		else
			Ant.Configuration.IsActive.Value = false
			Ants.Retrieve(Ant)
		end
	end
end



--a lil asthetics 

return Ants

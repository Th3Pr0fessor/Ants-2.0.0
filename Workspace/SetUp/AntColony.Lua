local Mod = require(game.ReplicatedStorage.Source.BasicFunctions.BirthModule)
local Search = require(game.ReplicatedStorage.Source.BasicFunctions.SearchModule)
local Queen, Folder = Mod.SetUp("KentrathColony", "Army")

wait()
local Gatherers = {}
local Builders = {}
local Army = {}
spawn(function()
	while wait(2) do
		if Queen.PrimaryPart ~= nil then
			local Larva = Mod.Creation(Queen, Folder, 2)
			wait()
			if Larva.Class.Value == "Gatherer" then
				table.insert(Gatherers, Larva)
			elseif Larva.Class.Value == "Builder" then
				table.insert(Builders, Larva)
			elseif Larva.Class.Value == "Army" then
				table.insert(Army, Larva)
			end
		else
			break;
		end
	end
end)

wait()

spawn(function()
	while wait() do
		for i, Ant in pairs(Gatherers) do
			spawn(function()
				local S, E = pcall(function()
					Search.Retrieve(Ant, "Food")
				end)
				if S == false then
					table.remove(Gatherers, i)
				end
			end)
		end
	end
end)
spawn(function()
	while wait() do
		for i, Ant in pairs(Builders) do
			spawn(function()
				local S, E = pcall(function()
					Search.Retrieve(Ant, "Dirt")
				end)
				if S == false then
					table.remove(Builders, i)
				end
			end)
		end
	end
end)
spawn(function()
	while wait() do
		for i, Ant in pairs(Army) do
			spawn(function()
				local S, E = pcall(function()
					if Ant ~= nil then
						Search.ArmyFunction(Ant)
					else
						table.remove(Army, i)
					end
				end)
				if S == false then
					table.remove(Army, i)
				end
			end)
		end
	end
end)

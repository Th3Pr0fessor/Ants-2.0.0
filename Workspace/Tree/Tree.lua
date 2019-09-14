local Class = require(game.ReplicatedStorage.Source.etc.TreeModule)
local Fractal = Class.new()
for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA"Part" then
		Fractal:branch(math.random(10,10), v)
	end
end

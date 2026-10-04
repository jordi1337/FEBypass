_G.fsociety = _G.fsociety or {}

_G.fsociety.elliotalderson = function(...)
	local Remote = game:GetService("ReplicatedStorage"):WaitForChild("fsociety")
	Remote:FireServer("elliotalderson", ...)
end

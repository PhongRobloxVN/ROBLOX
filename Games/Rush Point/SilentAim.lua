-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/PhongRobloxVN/Aiming/main/Load.lua"))()("Module", "RushPoint")
local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local CFramelookAt = CFrame.lookAt

local WeaponManagerClient = require(ReplicatedStorage.Modules.Client.Managers.WeaponManagerClient)
local Shoot = WeaponManagerClient.Shoot

-- // Get rid of their lmao check against this
debug.setupvalue(Shoot, 5, function()
    if (AimingChecks.IsAvailable()) then
        local Origin = CurrentCamera.CFrame.Position
        local Destination = AimingSelected.Part.Position

        local Modified = CFramelookAt(Origin, Destination)
        return Modified
    end
end)

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Make sure it is the shoot function trying to get the camera's cframe
    if (not checkcaller() and t == CurrentCamera and k == "CFrame" and AimingChecks.IsAvailable() and debug.validlevel(3) and #debug.getupvalues(3) == 12) then
        local Origin = __index(t, k).Position
        local Destination = AimingSelected.Part.Position

        local Modified = CFramelookAt(Origin, Destination)
        return Modified
    end

    -- // Return old
    return __index(t, k)
end)

if not game:IsLoaded() then
    while not game:IsLoaded() do wait(1) end

   -- wait(5)
end

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke

-- Hooking the _check function in the module to bypass the anticheat.

local old
old = hookfunction(getupvalue(Fire, 1), function(...)
   return true
end)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
    game:GetService("RunService").Heartbeat:Wait();
end;
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local InputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local ContentProvider = game:GetService("ContentProvider")
local banSuccess, banError = pcall(function() 
		local Blunder = require(game:GetService("ReplicatedStorage"):WaitForChild("X", 10):WaitForChild("Blunder", 10):WaitForChild("BlunderList", 10))
		if not Blunder or not Blunder.getAndClear then LocalPlayer:Kick("Error while bypassing the anti-cheat! (Didn't find blunder)") end
		
		local OldGet = Blunder.getAndClear
		setreadonly(Blunder, false)
		local function OutputData(Message)
		   print("-- PET SIM X BLUNDER --")
		   print(Message .. "\n")
		end
		
		Blunder.getAndClear = function(...)
		   local Packet = ...
			for i,v in next, Packet.list do
			   if v.message ~= "PING" then
				   OutputData(v.message)
				   table.remove(Packet.list, i)
			   end
		   end
		   return OldGet(Packet)
		end
		
		setreadonly(Blunder, true)
	end)

	if not banSuccess then
		LocalPlayer:Kick("Error while bypassing the anti-cheat! (".. banError ..")")
		return
	end
	
	local Library = require(game:GetService("ReplicatedStorage").Library)
	assert(Library, "Oopps! Library has not been loaded. Maybe try re-joining?") 
	while not Library.Loaded do task.wait() end
	
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	
	
	local bypassSuccess, bypassError = pcall(function()
		if not Library.Network then 
			LocalPlayer:Kick("Network not found, can't bypass!")
		end
		
		if not Library.Network.Invoke or not Library.Network.Fire then
			LocalPlayer:Kick("Network Invoke/Fire was not found! Failed to bypass!")
		end
		
		hookfunction(debug.getupvalue(Library.Network.Invoke, 1), function(...) return true end)
		-- Currently we don't need to hook Fire, since both Invoke/Fire have the same upvalue, this may change in future.
		-- hookfunction(debug.getupvalue(Library.Network.Fire, 1), function(...) return true end)
		
		local originalPlay = Library.Audio.Play
		Library.Audio.Play = function(...) 
			if checkcaller() then
				local audioId, parent, pitch, volume, maxDistance, group, looped, timePosition = unpack({ ... })
				if type(audioId) == "table" then
					audioId = audioId[Random.new():NextInteger(1, #audioId)]
				end
				if not parent then
					warn("Parent cannot be nil", debug.traceback())
					return nil
				end
				if audioId == 0 then return nil end
				
				if type(audioId) == "number" or not string.find(audioId, "rbxassetid://", 1, true) then
					audioId = "rbxassetid://" .. audioId
				end
				if pitch and type(pitch) == "table" then
					pitch = Random.new():NextNumber(unpack(pitch))
				end
				if volume and type(volume) == "table" then
					volume = Random.new():NextNumber(unpack(volume))
				end
				if group then
					local soundGroup = game.SoundService:FindFirstChild(group) or nil
				else
					soundGroup = nil
				end
				if timePosition == nil then
					timePosition = 0
				else
					timePosition = timePosition
				end
				local isGargabe = false
				if not pcall(function() local _ = parent.Parent end) then
					local newParent = parent
					pcall(function()
						newParent = CFrame.new(newParent)
					end)
					parent = Instance.new("Part")
					parent.Anchored = true
					parent.CanCollide = false
					parent.CFrame = newParent
					parent.Size = Vector3.new()
					parent.Transparency = 1
					parent.Parent = workspace:WaitForChild("__DEBRIS")
					isGargabe = true
				end
				local sound = Instance.new("Sound")
				sound.SoundId = audioId
				sound.Name = "sound-" .. audioId
				sound.Pitch = pitch and 1
				sound.Volume = volume and 0.5
				sound.SoundGroup = soundGroup
				sound.Looped = looped and false
				sound.MaxDistance = maxDistance and 100
				sound.TimePosition = timePosition
				sound.RollOffMode = Enum.RollOffMode.Linear
				sound.Parent = parent
				if not require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")).Settings.SoundsEnabled then
					sound:SetAttribute("CachedVolume", sound.Volume)
					sound.Volume = 0
				end
				sound:Play()
				getfenv(originalPlay).AddToGarbageCollection(sound, isGargabe)
				return sound
			end
			
			return originalPlay(...)
		end
	
	end)
	
	if not bypassSuccess then
		print(bypassError)
		LocalPlayer:Kick("Error while bypassing network, try again or wait for an update!")
		return
	end

function FrTeleportToWorld(world, area)
        local Library = require(game:GetService("ReplicatedStorage").Library)
		Library.WorldCmds.Load(world)
		wait(0.25)
		local areaTeleport = Library.WorldCmds.GetMap().Teleports:FindFirstChild(area)
		Library.Signal.Fire("Teleporting")
		task.wait(0.25)
		local Character = game.Players.LocalPlayer.Character
		local Humanoid = Character.Humanoid
		local HumanoidRootPart = Character.HumanoidRootPart
		Character:PivotTo(areaTeleport.CFrame + areaTeleport.CFrame.UpVector * (Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2))
		Library.Network.Fire("Performed Teleport", area)
		task.wait(0.25)
end
function FrTeleportToArea(world, area)
    local areaTeleport = Library.WorldCmds.GetMap().Teleports:FindFirstChild(area)
		local Character = game.Players.LocalPlayer.Character
		local Humanoid = Character.Humanoid
		local HumanoidRootPart = Character.HumanoidRootPart
		Character:PivotTo(areaTeleport.CFrame + areaTeleport.CFrame.UpVector * (Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2))
		Library.Network.Fire("Performed Teleport", area)
    
end
local TimeElapsed = 0
    local ThingsBroke = 0
    local STOP = false
    local MADE = false
    
    HttpService = game:GetService("HttpService")
    
    local timer = coroutine.create(function()
        while 1 do
            TimeElapsed = TimeElapsed + 1
            wait(1)
        end
    end)
    
    coroutine.resume(timer)
    SettingsBreakable = {
        WorldHop = true, -- If This Is True It Will Break Stuff In Every World Up To Cat World
        Area = "", -- If World Hop Is False And This Isnt Blank It Will Only Farm In This Area
        AutoCollectOrbs = true, -- If This Is True It Will Collect The Orbs Automatically
        Loop = false, -- If This Is True It Will Happen All Again And Again (Only Enable If Server Hop Is False)
        WaitTime = 20, -- If Something Isnt Broken Past This Time Then Move On To The Next Thing 1 = 0.1s
        ThingsToBreak = {
        	"Apple",
        	"Orange",
        	"Pineapple",
        	"Pear",
        	"Rainbow Fruit",
        	"Banana"

        } -- List Of Things To Break, If The Name Of The Breakable Contains Any Of These It Will Break It
    }
   
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    while not v1.Loaded do
    	game:GetService("RunService").Heartbeat:Wait();
    end;
    
    function WaitUntilAllThingsHaveLoaded()
        while 1 do
            if #game.Workspace["__THINGS"].Coins:GetChildren() <= 100 then
                break
            end
            wait(0.1)
        end
        if true then
            return
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount ~= oldcount then
                break
            end
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount == oldcount then
                break
            end
        end
    end
    
    function ShouldBreak(coin)
        for i2, v2 in pairs(SettingsBreakable.ThingsToBreak) do
            if string.find(coin, v2) then
                return true
            end
        end
        return false
    end
    
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    

    
    while 1 do
        local Ccount = 0
        for i, v in pairs(Invoke("Get Coins")) do
            Ccount = Ccount + 1
        end
        if Ccount >= 10 then break end
        wait(3)
    end
    
    function ForeverPickupOrbs()
      while true do
        orbs = {}
        for i, v in pairs (game.Workspace['__THINGS'].Orbs:GetChildren()) do
            table.insert(orbs, v.Name)
        end
        Fire("Claim Orbs", orbs)
        wait(0.1)
      end
    end
    foreverpickup = coroutine.create(ForeverPickupOrbs)
    if SettingsBreakable.AutoCollectOrbs then
        coroutine.resume(foreverpickup)
    end
    
    
    
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = true
    wait(0.1)
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = false
    
   
           
            wait(0.01)
            FrTeleportToWorld("Spawn", "Shop")
            wait(0.5)
            AllCs = Invoke("Get Coins")
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Fantasy", "Fantasy Shop")
            wait(0.5)
            FarmWorld = "Fantasy"
            AllCs = Invoke("Get Coins")
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Tech", "Tech Shop")
            wait(0.5)
            FarmWorld = "Tech"
            AllCs = Invoke("Get Coins")
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Axolotl Ocean", "Axolotl Cave")
            FarmWorld = "Axolotl Ocean"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Pixel", "Pixel Forest")
            FarmWorld = "Pixel"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Cat", "Cat Paradise")
            FarmWorld = "Cat"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Doodle", "Doodle Shop")
            FarmWorld = "Doodle"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Kawaii", "Kawaii Tokyo")
            FarmWorld = "Kawaii"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
 FrTeleportToWorld("Dog", "Dog Park")
            FarmWorld = "Dog"
            AllCs = Invoke("Get Coins")
            wait(0.5)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    wait(0.1)
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end
--FrTeleportToArea(Diamond Mine)
-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport()

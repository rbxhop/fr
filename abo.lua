getgenv()["vijenas_Sniper"] = {
    Configuration = {
        Buy_Delay_MS = 5,
        Webhook = {
            Url = "https://discord.com/api/webhooks/1105890306374774896/zWeabHtGwuKobN8NZwfVWFuFlCTlgsBqLBfPHBsM-R9GgNDkJCoUCsdJaK1uZJG_SiMF",
            Content = "@everyone";
        }
    },
    Pets = {
        ["TNT Crate"] = {
            MAX_PRICE = 2000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
        },
        ["Present"] = {
            MAX_PRICE = 5000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
        },
		 ["TNT"] = {
            MAX_PRICE = 500,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
        },
["Crystal Key"] = {
            MAX_PRICE = 12000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
        },
["Diamond Plant Seed"] = {
            MAX_PRICE = 3000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
	["Large Gift Box"] = {
            MAX_PRICE = 10000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
		["Spinny Wheel Ticket"] = {
            MAX_PRICE = 10000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
			["Gift Bag"] = {
            MAX_PRICE = 3000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
				["Gift Plant Seed"] = {
            MAX_PRICE = 5000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = false -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
			["Exclusive"] = {
            MAX_PRICE = 25000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
		    [""] = {
            MAX_PRICE = 2,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
		    ["Potion"] = {
            MAX_PRICE = 100,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
		    ["Voucher"] = {
            MAX_PRICE = 15000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
    
	},
["Huge"] = {
            MAX_PRICE = 700000,
            FORM = "Normal", -- Normal, Rainbow, Golden
            NAME_MATCHING = true -- Basically it will buy the pet if only part of the described name matches (you can insta buy huges with this buy just calling the pet you want to snipe Huge and turning this on)
        }
    },
}

local Plaza = getsenv(game.Players.LocalPlayer.PlayerScripts:WaitForChild("Scripts"):WaitForChild("Game"):WaitForChild("Trading Plaza"):WaitForChild("Booths Frontend"))
local Save = require(game.ReplicatedStorage.Library.Client.Save).Get()
local _oldFunction = clonefunction(Plaza.updateBooth)
Url = "https://discord.com/api/webhooks/1105890306374774896/zWeabHtGwuKobN8NZwfVWFuFlCTlgsBqLBfPHBsM-R9GgNDkJCoUCsdJaK1uZJG_SiMF"

local GetDiamonds = function()
    for _, v in pairs(Save.Inventory.Currency) do 
        if v.id == 'Diamonds' then 
            return v._am 
        end 
    end
end

local Notify = function(PET_DATA)
    local data = {
        ["content"] = vijenas_Sniper.Configuration.Webhook.Content,
        ["embeds"] = {
            {
                ["title"] = string.format("Bought %s for %s (Profit: %s)", PET_DATA.NAME, PET_DATA.PRICE, (math.round((PET_DATA.MAX_PRICE / PET_DATA.PRICE) * 100).."%")),
                ["description"] = string.format("**> Transaction Details <**\n**Pet Name: %s**\n**Bought by: %s (%s)**\n**Bought from %s (%s)**\n**> Finances <**\n**Price: %s**\n**Max Price: %s**\n**Profit (percent): %s**\n**Gem Balance: %s**", PET_DATA.NAME, game.Players.LocalPlayer.Name, game.Players.LocalPlayer.UserId, game.Players:GetPlayerByUserId(PET_DATA.PLAYER_ID).Name, PET_DATA.PLAYER_ID, PET_DATA.PRICE, PET_DATA.MAX_PRICE, (math.round((PET_DATA.MAX_PRICE / PET_DATA.PRICE) * 100).."%"), GetDiamonds()) ,
                ["color"] = 3929344,
                ["author"] = {
                    ["name"] = "vijena's sniper"
                },
                ["footer"] = {
                    ["text"] = "by vijena"
                },
                ["timestamp"] = "2023-12-13T23:00:00.000Z";
            }
        }
    }

    local http = game:GetService("HttpService")
    local jsonMessage = http:JSONEncode(data)
    http:PostAsync(
        Url,
        jsonMessage,
        Enum.HttpContentType.ApplicationJson,
        false
    )
end

local GetPetForm = function(Data)
    return (Data.pt == nil) and 'Normal' or (Data.pt == 1) and 'Golden' or (Data.pt == 2) and 'Rainbow'
end

local MeetsForm = function(Form, Needed)
    local forms = {
        [1] = 'Normal',
        [2] = 'Golden',
        [3] = 'Rainbow';
    }

    return table.find(forms, Form) >= table.find(forms, Needed)
end

local GetMatch = function(PetName)
    for _, v in pairs(vijenas_Sniper.Pets) do 
        if v.NAME_MATCHING then 
            if PetName:match(_) then 
                return vijenas_Sniper.Pets[_]
            end
        end 
    end
end

local GetSnipes = function(Update)
    local hits = {}
    for _, v in pairs(Update.Listings) do 
        if vijenas_Sniper.Pets[v.Item["_data"].id] or GetMatch(v.Item["_data"].id) then
            local SnipingID = vijenas_Sniper.Pets[v.Item["_data"].id] or GetMatch(v.Item["_data"].id)
            local Price = v.DiamondCost;
            print(math.round(v.DiamondCost / (v.Item["_data"]["_am"] or 1)))
            if math.round(v.DiamondCost / (v.Item["_data"]["_am"] or 1)) <= SnipingID.MAX_PRICE and GetDiamonds() >= v.DiamondCost and MeetsForm(GetPetForm(v.Item["_data"]), SnipingID.FORM) then
                hits[#hits + 1] = {
                    NAME = v.Item["_data"].id,
                    PRICE = Price,
                    MAX_PRICE = SnipingID.MAX_PRICE,
                    PLAYER_ID = Update.PlayerID,
                    COUNT = v.Item["_data"]["_am"] or 1,
                    UID = _
                }
            end     
        end 
    end

    return hits
end

Plaza.updateBooth = function(...)
    local args = {...}
    local Data = args[1]

    local a = GetSnipes(Data)
    if #a > 0 then 
        for _, v in pairs(a) do 
            task.wait(vijenas_Sniper.Configuration.Buy_Delay_MS / 1000)
            local args = {
                [1] = v.PLAYER_ID,
                [2] = tostring(v.UID)
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Booths_RequestPurchase"):InvokeServer(unpack(args))
            
            Notify(v)

        end
    end

    _oldFunction(...)
end

------------------------------------
-- HEY YOU SKID, DONT STEAL THE CODE
-- IS JUST WRONG AND, SO ANNOYING
-- CODE IS ORIGNALLY MADE BY OC9X97
-- BTW WE ARE WORKING ON A DISCORD
-- SO GOODLUCK COPYING THAT SKIDS
------------------------------------

getgenv().host = "Username"
getgenv().alts = {"alt1", "alt2"} -- Optional to fill out
getgenv().defaultfps = 60
getgenv().prefix = ""
getgenv().shouldbotrender = true -- To show bot's screen or not to reduce lag
RunService = game:GetService("RunService")
TeleportService = game:GetService("TeleportService") -- Remove this and Rejoin if you are using Delta
PlaceId, JobId = game.PlaceId, game.JobId
local apiws

local function apierr(str)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Failed to connect to the API! (Error: " .. str .. ")")
end

local function sendApiMessage(message)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
end

if game.Players.LocalPlayer.Name ~= host then
    setfpscap(getgenv().defaultfps)
    print("loading")
else
    warn("not loading for host")
    if not getgenv().shouldbotrender then
        RunService:Set3dRenderingEnabled(false)
    end
    return
end

threadlive = true

-- Function to check if getgenv().host is not in game.Players and kick the bot
local function checkHostInPlayers()
    local host = getgenv().host
    local playerList = game.Players:GetPlayers()
    
    local hostInPlayerList = false
    for _, player in ipairs(playerList) do
        if player.Name == host then
            hostInPlayerList = true
            break
        end
    end
    
    if not hostInPlayerList then
        game.Players.LocalPlayer:Kick("Creator has left.")
    end
end

-- Run the check immediately when the script starts
checkHostInPlayers()

-- Monitor when players join and leave
game.Players.PlayerAdded:Connect(function(player)
    checkHostInPlayers() -- Check when a player joins
end)

game.Players.PlayerRemoving:Connect(function(player)
    checkHostInPlayers() -- Check when a player leaves
end)

game.Players[host].Chatted:Connect(function(message)
    if threadlive then
        local lowerMessage = string.lower(message)
        if lowerMessage == getgenv().prefix.."follow" then
            following = true
            if following then
                while following do
                    game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Players[host].Character.HumanoidRootPart.Position)
                    wait()
                end
            end
        elseif lowerMessage == getgenv().prefix.."unfollow" then
            following = false
        elseif lowerMessage == getgenv().prefix.."bring" then
            for i,v in ipairs(game.Players:GetPlayers()) do
                if v.Name == getgenv().host then
                    local targetplayer = v
                    local LocalPlayer = game.Players.LocalPlayer
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetplayer.Character.HumanoidRootPart.Position.X, targetplayer.Character.HumanoidRootPart.Position.Y, targetplayer.Character.HumanoidRootPart.Position.Z)
                end
            end
        elseif lowerMessage == getgenv().prefix.."oldbring" then
            local player = game.Players.LocalPlayer
            local target = game.Players[host].Character

            if target and target:IsDescendantOf(game) then
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
            local tweenProperties = {CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)}

            local tween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, tweenInfo, tweenProperties)
            tween:Play()
          else
           apierr("Host player's character not found.")
          end
        elseif lowerMessage == getgenv().prefix.."sit" then
            game.Players.LocalPlayer.Character.Humanoid.Sit = true
        elseif lowerMessage == getgenv().prefix.."jump" then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        elseif lowerMessage == getgenv().prefix.."reset" then
            game.Players.LocalPlayer.Character:BreakJoints()
        elseif lowerMessage == getgenv().prefix.."dance" then
            if game:GetService("TextChatService").TextChannels.RBXGeneral then
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/e dance")
            else
                print("unable to lol")
            end
        elseif lowerMessage == getgenv().prefix.."render" then
            sendApiMessage("Rendering enabled. I can see!")
            RunService:Set3dRenderingEnabled(true)
         elseif lowerMessage == getgenv().prefix.."kick" then
             game.Players.LocalPlayer:Kick("Creator has kicked you.")
        elseif lowerMessage == getgenv().prefix.."dontrender" then
            sendApiMessage("Rendering disabled. I'm blind!")
            RunService:Set3dRenderingEnabled(false)
        elseif string.find(lowerMessage, getgenv().prefix .. "say") then
            local args = string.gsub(message, getgenv().prefix .. "say", "")
            sendApiMessage(args)
        elseif lowerMessage == getgenv().prefix.."rejoin" then
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
        elseif lowerMessage == getgenv().prefix.."wave" then
            sendApiMessage("/e wave")
        elseif lowerMessage == getgenv().prefix.."cheer" then
            sendApiMessage("/e cheer")
        elseif lowerMessage == getgenv().prefix.."laugh" then
            sendApiMessage("/e laugh")
        elseif lowerMessage == getgenv().prefix.."point" then
            sendApiMessage("/e point")
        elseif lowerMessage == getgenv().prefix.."credits" then
            sendApiMessage("Code by oc9x97, with some help of his friends!")
        elseif lowerMessage == getgenv().prefix.."cmds" then
            sendApiMessage("credits, render, dontrender, rejoin, sit, dance, follow, unfollow, jump, reset, cmds, bring, laugh, cheer, wave, point, rejoin, kick ")
        elseif lowerMessage == getgenv().prefix.."stopaltcontrol" then
            threadlive = false
        elseif lowerMessage == getgenv().prefix.."resumealtcontrol" then
            threadlive = true
        end
    end
end)

sendApiMessage("RobloxBots by oc9x97 v1.3 Loaded ( Host: " .. getgenv().host .. " )")
print("loaded")

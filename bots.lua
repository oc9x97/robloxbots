getgenv().host = "Bot Controller Username"
    getgenv().alts = {"alt1", "alt2"} -- Optinal to fill out
    getgenv().defaultfps = 60
    getgenv().prefix = "!"
    getgenv().shouldbotrender = true -- To show bot's screen or not to reduce lag
    RunService = game.RunService
    TeleportService = game:GetService("TeleportService") -- Remove this and Rejoin if you are using Delta
    PlaceId, JobId = game.PlaceId, game.JobId
    local apiws
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Attempting API connection...")
    function apierr(str)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Failed to connect to the API! (Error: " .. str .. ")")
    end
    xpcall(function()
        apiws = WebSocket.connect("localhost:8080")
    end, apierr)

    local following = false

    if not getgenv().shouldbotrender then
        RunService:Set3dRenderingEnabled(false)
    end
    
    if game.Players.LocalPlayer.Name ~= host then
        setfpscap(defaultfps)
        print("loading")
    else 
        warn("not loading for host") -- This is supposed to happen so then the host isn't controlled.
        return
    end
threadlive = true
    game.Players[host].Chatted:Connect(function(message)
    if threadlive then
        local message = string.lower(message)
        if message == prefix.."follow" then -- Makes Player Follow You
            following = true 
            if following == true then
                while following == true do
                    game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Players[host].Character.HumanoidRootPart.Position)
                    wait()
                end
            end
        elseif message == prefix.."unfollow" then
            following = false
        elseif message == prefix.."sit" then -- Makes Player Sit
            game.Players.LocalPlayer.Character.Humanoid.Sit = true
        elseif message == prefix.."jump" then -- Makes Player Jump
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        elseif message == prefix.."reset" then -- Kills Player
            game.Players.LocalPlayer.Character:BreakJoints()
        elseif message == prefix.."dance" then -- Makes Them Hit A Jig
            if game:GetService("TextChatService").TextChannels.RBXGeneral then
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/e dance")
                else
                    print("unable to lol") -- They can't dance.
            end
        elseif message == prefix.."render" then -- Enable Render
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Rendering enabled. I can see!")
            RunService:Set3dRenderingEnabled(true)
        elseif message == prefix.."dontrender" then -- Disable Render
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Rendering disabled. I'm blind!")
                RunService:Set3dRenderingEnabled(false)
        elseif string.find(message, prefix .. "say") then -- Say Command
            args = string.gsub(message, prefix .. "say", "")
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(args)
        elseif message == prefix.."rejoin" then -- Rejoin (Remove If Delta has Errors)
                TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
        elseif message == prefix.."credits" then -- Disable Render
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Code by CasualDev Expanded by oc9x97 Fixing by Torn!")
        elseif message == prefix.."cmds" then -- Disable Render
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("The commands we're inside of the README file, but we have credits, render, dontrender, rejoin, sit dance, follow, unfollow")
        elseif message == prefix.."stopaltcontrol" then
            threadlive = true
        else
            return
        end
    end)
    else
        if message == prefix.."resumealtcontrol" then
            threadlive = true
        end
        end
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("RobloxBots by oc9x97 v0.0.1 Loaded (Host: " .. host .. ")")
    print("loaded")

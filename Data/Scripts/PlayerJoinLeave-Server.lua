local c = 1
function OnPlayerJoined(player)
    -- Assign new player to team 1 or 2, red or blue
    player.team = (c % 2) + 1
    c = c + 1
end

function OnPlayerLeft(player)
end


Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
Task.Wait()
local worldGenerationServer = script:GetCustomProperty("WorldGenerationServer"):WaitForObject()
local GM = require(script:GetCustomProperty("GridMath"))

local cellPool1 = {}        -- Pool of cell ids that team 1 players change between broadcasts
local cellPool2 = {}        -- Pool of cell ids that team 2 players change between broadcasts

local broadcastTimer = 0
local timeBtwBroadcasts = 0.2
function Tick(dt)
    broadcastTimer = broadcastTimer + dt

    local players = Game.GetPlayers()
    local grid = worldGenerationServer.context.gridCellsOccupied
    -- get cells that players feet touch
    for i, p in ipairs(players) do
        local pPos = p:GetWorldPosition() + Vector3.UP * -100 + -GM.gridOrigin
        local gridPos = GM.RoundToGrid(pPos)
        local cell = GM.GridPosToCell(gridPos)
        if grid[cell] ~= nil then
            if p.team == 1 then
                cellPool1[cell] = p.team
            elseif p.team == 2 then
                cellPool2[cell] = p.team
            end
        end
    end

    -- Broadcast cell ids that need their color changed
    if broadcastTimer > timeBtwBroadcasts then
        broadcastTimer = 0
        local cellStr1 = ""
        local cellStr2 = ""
        for cell, team in pairs(cellPool1) do
            cellStr1 = cellStr1 .. cell .. ","
        end
        for cell, team in pairs(cellPool2) do
            cellStr2 = cellStr2 .. cell .. ","
        end
        cellPool1 = {}
        cellPool2 = {}
        Events.BroadcastToAllPlayers("UpdateCellColors", cellStr1, cellStr2)
    end

end
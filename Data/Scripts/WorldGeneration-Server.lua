local GM = require(script:GetCustomProperty("GridMath"))

gridCellsOccupied = {}        -- List where flat 3D grid cell number is index and value is bool, nil = unoccupied, 0 = occupied and neutral color

-- Generate grid using raycast against terrain object
local counter = 0
for y = 0, GM.gridSizeY - 1, 1 do
    for x = 0, GM.gridSizeX - 1, 1 do
        counter = counter + 1
        if counter > 1000 then
            Task.Wait()
            counter = 0
        end
        local rayStart = Vector3.New(50, 50, 0) + GM.gridOrigin + Vector3.FORWARD * (x * GM.cellSize) + Vector3.RIGHT * (y * GM.cellSize) + Vector3.UP * 25600
        local rayEnd = rayStart + (Vector3.UP * -25600)
        local rayHit = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})
        if rayHit then
            local hitPos = rayHit:GetImpactPosition() + (-GM.gridOrigin)
            local gridPos = GM.RoundToGrid(hitPos)
            local cell = GM.GridPosToCell(gridPos)
            local index = x + (y * GM.gridSizeX) + 1
            gridCellsOccupied[cell] = index
        end
    end
end




local GM = require(script:GetCustomProperty("GridMath"))

local cube = script:GetCustomProperty("CubePolished")
local basicMaterial = script:GetCustomProperty("BasicMaterial")

gridCellsOccupied = {}        -- List where flat 3D grid cell number is index and value cellID
gridCellIDs = {}              -- Index list of grid cells that are blocks, index is block name/cellID, value is coreObject

-- Generate grid using raycast against terrain object and spawn blocks
local counter = 0
for y = 0, GM.gridSizeY - 1, 1 do
    for x = 0, GM.gridSizeX - 1, 1 do
        counter = counter + 1
        if counter > 100 then
            Task.Wait()
            counter = 0
        end
        local rayStart = Vector3.New(GM.cellSize * 0.5, GM.cellSize * 0.5, 0) + GM.gridOrigin + Vector3.FORWARD * (x * GM.cellSize) + Vector3.RIGHT * (y * GM.cellSize) + Vector3.UP * 25600
        local rayEnd = rayStart + (Vector3.UP * -25600)
        local rayHit = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})
        if rayHit then
            local hitPos = rayHit:GetImpactPosition() + (-GM.gridOrigin)
            local gridPos = GM.RoundToGrid(hitPos)
            local cell = GM.GridPosToCell(gridPos)
            local index = x + (y * GM.gridSizeX) + 1
            gridCellsOccupied[cell] = index
            local block = World.SpawnAsset(cube)
            gridCellIDs[index] = block
            block.name = tostring(index)
            block:SetWorldPosition(rayHit:GetImpactPosition() + Vector3.UP * -50)
            block:SetColor(Color.GREEN)
            local matSlot = block:GetMaterialSlot("Shared_BaseMaterial")
            matSlot.materialAssetId = basicMaterial
        end
    end
end
local GM = require(script:GetCustomProperty("GridMath"))
local worldGenerationClient = script:GetCustomProperty("WorldGenerationClient"):WaitForObject()

-- When client recieves broadcast from server to update block colors
function OnCellColorUpdate(str1, str2)
    local t1Cells = {}
    local t2Cells = {}
    -- convert strings to grid table
    for match in (str1..","):gmatch("(.-)"..",") do
        table.insert(t1Cells, tonumber(match));
    end
    for match in (str2..","):gmatch("(.-)"..",") do
        table.insert(t2Cells, tonumber(match));
    end
    -- update grid cell block colors
    for _, cell in ipairs(t1Cells) do
        local gridCells = worldGenerationClient.context.gridCellsOccupied
        local gridBlocks = worldGenerationClient.context.gridCellIDs
        if gridCells[cell] ~= nil then
            local index = gridCells[cell]
            local block = gridBlocks[index]
            block:SetColor(Color.RED)
        end
    end
    for _, cell in ipairs(t2Cells) do
        local gridCells = worldGenerationClient.context.gridCellsOccupied
        local gridBlocks = worldGenerationClient.context.gridCellIDs
        if gridCells[cell] ~= nil then
            local index = gridCells[cell]
            local block = gridBlocks[index]
            block:SetColor(Color.BLUE)
        end
    end
end

Events.Connect("UpdateCellColors", OnCellColorUpdate)
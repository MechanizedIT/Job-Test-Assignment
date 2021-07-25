local API = {}

API.gridSizeX = 100     -- size of grid on X axis in meters
API.gridSizeY = 100     -- size of grid on Y axis in meters
API.gridSizeZ = 100     -- size of grid on Z axis in meters

API.cellSize = 100      -- size of grid cell in centimeters

-- Southwest corner of grid, keeps all grid positions positive
API.gridOrigin = Vector3.New(-(API.gridSizeX * 0.5), -(API.gridSizeY * 0.5), -(API.gridSizeZ * 0.5)) * API.cellSize

-- Takes a vector3 and calculates the flat 3D grid cell index
function API.GridPosToCell(gridPos)
    local x = gridPos.x
    local y = gridPos.y * API.gridSizeX
    local z = gridPos.z * (API.gridSizeX * API.gridSizeY)
    local cell = math.floor(x + y + z)
    return cell
end

-- Takes a cell index and calculates a vector3 grid position
function API.CellToGridPos(cell)
    local z = math.floor(cell / (API.gridSizeX * API.gridSizeY))
    local y = math.floor((cell - z * (API.gridSizeX * API.gridSizeY)) / API.gridSizeX)
    local x = (cell - z * (API.gridSizeX * API.gridSizeY)) - (y * API.gridSizeX)
    local gridPos = (Vector3.New(x, y, z) * API.cellSize)
    return gridPos
end

-- Takes a vector3 and rounds it to a 3D grid position
function API.RoundToGrid(pos)
    local gridPos = pos
    gridPos.x = math.floor(pos.x / API.cellSize)
    gridPos.y = math.floor(pos.y / API.cellSize)
    gridPos.z = math.floor(pos.z / API.cellSize)
    return gridPos
end

return API
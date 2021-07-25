API = {}

-- Cost of any given level N
function LevelCost(level)
    local cost = 500 * (1.06 ^ level)
    return cost
end

-- How many levels N a player can afford
function API.PlayerCanBuyNLevels(playerMoney, currentLevel)
    local levels = 0
    local level = currentLevel + 1
    local cost = LevelCost(level)
    local money = playerMoney
    while money >= cost do
        level = level + 1
        cost = LevelCost(level)
        levels = levels + 1
    end
    return levels
end

-- How much N levels will cost total
function API.CostOfNLevels(currentLevel, levelsToPurchase)
    local cost = 0
    for i = 1, levelsToPurchase, 1 do
        local level = currentLevel + i
        cost = cost + LevelCost(level)
    end
    return cost
end

return API
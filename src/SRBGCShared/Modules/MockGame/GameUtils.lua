local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RobloxBoardGameShared
local RobloxBoardGameShared = ReplicatedStorage.RobloxBoardGameShared
local CommonTypes = require(RobloxBoardGameShared.Types.CommonTypes)

-- SRBGCShared
local SRBGCShared = ReplicatedStorage.SRBGCShared
local GameTypes = require(SRBGCShared.Modules.MockGame.GameTypes)
local DieTypes = require(SRBGCShared.Modules.MockGame.DieTypes)

local GameUtils = {}

GameUtils.getGameEventFolderName = function(gameInstanceGUID: CommonTypes.GameInstanceGUID): string
    return "GameEvents_" .. gameInstanceGUID
end

GameUtils.firstUserCanPlayAsSecondUser = function(tableDescription: CommonTypes.TableDescription, userId: CommonTypes.UserId, currentPlayerUserId:CommonTypes.UserId): boolean
    -- Better be a member of the game.
    assert(userId, "userId is nil")
    assert(currentPlayerUserId, "userId is nil")

    -- If current player is attemped actor, fine.
    if userId == currentPlayerUserId then
        return true
    end
    -- If current player is mock and attempted actor is host, fine.
    if tableDescription.hostUserId == userId and tableDescription.mockUserIds[currentPlayerUserId] then
        return true
    end

    -- No good.
    return false
end

GameUtils.getDieName = function(dieType: GameTypes.DieType): string
    if dieType == DieTypes.Standard then
        return "Standard"
    elseif dieType == DieTypes.Smushed then
        return "Smushed"
    elseif dieType == DieTypes.Advantage then
        return "Advantage"
    else
        error("Unknown die type: " .. dieType)
    end
end

return GameUtils
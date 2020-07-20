local Class = require "Libraries.Self"
local QuestDetail = require "Controllers.Events.QuestDetail"
local QuestFinished = require "Controllers.Events.QuestFinished"
local GossipShow = require "Controllers.Events.GossipShow"
local GossipClosed = require "Controllers.Events.GossipClosed"
local ItemTextReady = require "Controllers.Events.ItemTextReady"
local ItemTextClosed = require "Controllers.Events.ItemTextClosed"
local QuestComplete = require "Controllers.Events.QuestComplete"
local QuestProgress = require "Controllers.Events.QuestProgress"
local QuestGreeting = require "Controllers.Events.QuestGreeting"

---@class GameEventsController
local GameEventsController = Class("GameEventsController")

---@param state Storyline_State
---@param actions Storyline_Actions
function GameEventsController:new(state, actions)
    self.questGreeting = QuestGreeting(state, actions)
    self.questDetail = QuestDetail(state, actions)
    self.questProgress = QuestProgress(state, actions)
    self.questComplete = QuestComplete(state, actions)
    self.questFinished = QuestFinished(state, actions)
    self.gossipShow = GossipShow(state, actions)
    self.gossipClosed = GossipClosed(state, actions)
    self.itemTextReady = ItemTextReady(state, actions)
    self.itemTextClosed = ItemTextClosed(state, actions)
end

return GameEventsController
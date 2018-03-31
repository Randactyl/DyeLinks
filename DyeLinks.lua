local ACHIEVEMENTS_KB = SYSTEMS.systems.achievements.keyboardObject
local RESTYLE_KB = SYSTEMS.systems.restyle.keyboardObject

-- Overrides function ZO_RestyleStation_Keyboard:AttemptExit(exitDestinationData) in restylestation_keyboard.lua
function RESTYLE_KB.AttemptExit(self, exitDestinationData)
    if exitDestinationData and exitDestinationData.achievementId then
        ACHIEVEMENTS_KB.popup:Hide()

        local link = ZO_LinkHandler_CreateChatLink(GetAchievementLink, exitDestinationData.achievementId)
        local name, linkStyle, linkType, id, progress, timestamp = ZO_LinkHandler_ParseLink(link)

        ACHIEVEMENTS_KB:ShowAchievementPopup(exitDestinationData.achievementId, progress, timestamp)
        ZO_PopupTooltip_Hide()
    else
        ACHIEVEMENTS_KB.popup:Hide()

        -- Begin ZOS code
        self.exitDestinationData = exitDestinationData
        local preservePendingChanges = exitDestinationData and exitDestinationData.preservePendingChanges or false

        if ZO_RESTYLE_SHEET_WINDOW_KEYBOARD:AreChangesPending() and not preservePendingChanges then
            local function Confirm()
                self.ConfirmExit()
            end

            local function Decline()
                self.exitDestinationData = nil
            end
            ZO_RESTYLE_SHEET_WINDOW_KEYBOARD:ShowRevertRestyleChangesDialog("CONFIRM_REVERT_RESTYLE_CHANGES", Confirm, Decline)
        else
            self:ConfirmExit()
        end
        -- End ZOS code
    end
end
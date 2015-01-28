--overrides function ZO_Dyeing:AttemptExit(exitingToAchievementId) on line 451 in dyeing_keyboard.lua
function DYEING:AttemptExit(exitingToAchievementId)
    if exitingToAchievementId then
        ACHIEVEMENTS.popup:Hide()

        local link = ZO_LinkHandler_CreateChatLink(GetAchievementLink, exitingToAchievementId)
        local name, linkStyle, linkType, id, progress, timestamp = ZO_LinkHandler_ParseLink(link)
        
        ACHIEVEMENTS:ShowAchievementPopup(exitingToAchievementId, progress, timestamp)
        ZO_PopupTooltip_Hide()
    else
        ACHIEVEMENTS.popup:Hide()

        if self:AreTherePendingDyes() then
            if self:AreAllItemsBound() then
                   ZO_Dialogs_ShowDialog("EXIT_DYE_UI")
            end
        else
            self:ConfirmExit()
        end
    end
end
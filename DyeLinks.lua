--overrides function ZO_Dyeing:AttemptExit(exitingToAchievementId) on line 452 in dyeing_keyboard.lua
function DYEING:AttemptExit(exitingToAchievementId)
    if exitingToAchievementId then
        ACHIEVEMENTS.popup:Hide()

        local link = ZO_LinkHandler_CreateChatLink(GetAchievementLink, exitingToAchievementId)
        local name, linkStyle, linkType, id, progress, timestamp = ZO_LinkHandler_ParseLink(link)

        ACHIEVEMENTS:ShowAchievementPopup(exitingToAchievementId, progress, timestamp)
        ZO_PopupTooltip_Hide()
    else
        ACHIEVEMENTS.popup:Hide()

        if ZO_Dyeing_AreTherePendingDyes() then
            if ZO_Dyeing_AreAllItemsBound() then
                   ZO_Dialogs_ShowDialog("EXIT_DYE_UI")
            end
        else
            self:ConfirmExit()
        end
    end
end

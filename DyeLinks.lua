--overrides function ZO_Dyeing:AttemptExit(exitingToAchievementId) in dyeing_keyboard.lua
function DYEING.AttemptExit(self, exitingToAchievementId)
    self.exitingToAchievementId = exitingToAchievementId

    if exitingToAchievementId then
        ACHIEVEMENTS.popup:Hide()

        local link = ZO_LinkHandler_CreateChatLink(GetAchievementLink, exitingToAchievementId)
        local name, linkStyle, linkType, id, progress, timestamp = ZO_LinkHandler_ParseLink(link)

        ACHIEVEMENTS:ShowAchievementPopup(exitingToAchievementId, progress, timestamp)
        ZO_PopupTooltip_Hide()
    else
        ACHIEVEMENTS.popup:Hide()

        if ZO_Dyeing_AreTherePendingDyes(self.mode) then
            if ZO_Dyeing_AreAllItemsBound(self.mode) then
                ZO_Dialogs_ShowDialog("EXIT_DYE_UI")
            else
                ZO_Dialogs_ShowDialog("EXIT_DYE_UI_BIND")
            end
        else
            self:ConfirmExit()
        end
    end
end
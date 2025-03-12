TEX_CAKE = get_texture_info("end_cake")

function render_agent_end()
    local x = djui_hud_get_screen_width()/2 - TEX_CAKE.width/2
    local y = djui_hud_get_screen_height()/2 - TEX_CAKE.height/2

    if gNetworkPlayers[0].currLevelNum ~= LEVEL_ENDING then
        return
    end

    djui_hud_set_color(0, 0, 0, 255)
    djui_hud_render_rect(0, 0, djui_hud_get_screen_width(), djui_hud_get_screen_height())
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_set_filter(FILTER_LINEAR)
    djui_hud_render_texture(TEX_CAKE, x, y, 1, 1)
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, function()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)

    djui_hud_set_color(255, 255, 255, 255)
    render_agent_end()
end)

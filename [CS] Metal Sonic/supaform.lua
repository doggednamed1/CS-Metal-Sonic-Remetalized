 silencetheme = 0
local GLIMMERING_GIFT = audio_stream_load("super_theme.mp3")
local ULTIMATE_FORCE = audio_stream_load("hyper_theme.mp3")

local huehuehuehyper = audio_stream_load("maniaspeedway.mp3")
local mechahyper = audio_stream_load("Doomsday.ogg")
function supertheme()
    _G.SuperThemeExtra = true
    if _G.charSelect.character_get_current_number() == METAL_SONIC then
        if _G.IsSuper == true or _G.IsHyper == true then
            audio_stream_play(huehuehuehyper, false, 1)
            play_cap_music(0)
            sliencetheme = 100
        else
            audio_stream_stop(huehuehuehyper)
            if silencetheme > 0 then
                stop_cap_music(0)
                silencetheme = silencetheme - 10
            end
        end
    elseif _G.charSelect.character_get_current_number() == MECHA_SONIC_MK2 then
        if _G.IsSuper == true or _G.IsHyper == true then
            audio_stream_play(mechahyper, false, 1)
            play_cap_music(0)
            sliencetheme = 100
        else
            audio_stream_stop(mechahyper)
            if silencetheme > 0 then
                stop_cap_music(0)
                silencetheme = silencetheme - 10
            end
        end
    elseif charSelect.character_get_current_number ~= METAL_SONIC or MECHA_SONIC_MK2 then
        if _G.IsSuper == true then
            audio_stream_play(GLIMMERING_GIFT, false, 1)
            play_cap_music(0)
            sliencetheme = 100
        elseif _G.IsHyper == true then
            audio_stream_stop(GLIMMERING_GIFT)
            audio_stream_play(ULTIMATE_FORCE, false, 1)
            play_cap_music(0)
            silencetheme = 100
        else
            audio_stream_stop(GLIMMERING_GIFT)
            audio_stream_stop(ULTIMATE_FORCE)
            stop_cap_music()
            silencetheme = silencetheme - 10
        end
    end
end

hook_event(HOOK_UPDATE, supertheme)


-- name:[CS] The Metal Initiative
-- description:\\#ff7777\\This Pack requires Character Select\nto use as a Library!\nas well as Easy Custom Movesets for the full character pack
--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
]]


local TEXT_MOD_NAME = "[CS] The Metal Initiative"
-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists or not _G.customMovesExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Easy Custom Movesets Mod\nthen you may restart the Room!", 6)
    return 0
end

local MODEL_METAL_SONIC = smlua_model_util_get_id("metals_geo") -- Located in "actors"
local MODEL_MECHA_SONIC_MK2 = smlua_model_util_get_id("mechas_geo")
local TEX_METAL_LIFE_ICON = get_texture_info("metals_icon") -- Located in "textures"
local TEX_MECHA_LIFE_ICON = get_texture_info("mechas_icon")
local TEX_STAR_ICON = get_texture_info("MasterEmerald")
-- All Located in "sound"
local VOICE_METAL = {
    --[CHAR_SOUND_OKEY_DOKEY] = 'StartLevel.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] = 'StartLevel.ogg', -- Starting level
	[CHAR_SOUND_PUNCH_YAH] = nil, -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] = nil, -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] = nil, -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] = nil,
	[CHAR_SOUND_HOOHOO] = nil,
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = nil, -- Triple jump sounds
	[CHAR_SOUND_UH] = 'Damage.ogg', -- Wall bonk
	[CHAR_SOUND_UH2] = 'Silent.ogg', -- Landing after long jump
	[CHAR_SOUND_UH2_2] = 'Silent.ogg', -- Same sound as UH2; jumping onto ledge
	[CHAR_SOUND_HAHA] = 'Silent.ogg', -- Landing triple jump
	[CHAR_SOUND_YAHOO] = 'Jump2.ogg', -- Long jump
	[CHAR_SOUND_DOH] = 'Damage.ogg', -- Long jump wall bonk
	[CHAR_SOUND_WHOA] = 'Jump1.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] = 'Silent.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] = 'Drowning.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] = 'TripleJump2.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] = 'Silent.ogg', 
	[CHAR_SOUND_HRMM] = 'Jump3.ogg', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] = 'GetStar.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] = 'ThrowBowser.ogg', -- Throwing Bowser
--DAMAGE
	[CHAR_SOUND_ATTACKED] = 'Damage.ogg', -- Damaged
	[CHAR_SOUND_PANTING] = 'Silent.ogg', -- Low health
	[CHAR_SOUND_ON_FIRE] = 'Dying.ogg', -- Burned
--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] = 'Silent.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] = 'Tired.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] = 'Silent.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] = 'Panting.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] = 'Silent.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] = 'Panting.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] = 'Silent.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] = 'Silent.ogg', -- Cough take 3
--DEATH
	[CHAR_SOUND_DYING] = 'Dying.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] = 'Drowning.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] = 'Damage.ogg' -- Booted out of level
}
local VOICE_MECHA = {
    --[CHAR_SOUND_OKEY_DOKEY] = 'StartLevel.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] = 'levelmecha.ogg', -- Starting level
	[CHAR_SOUND_PUNCH_YAH] = nil, -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] = nil, -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] = nil, -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] = nil, -- First/Second jump sounds
	[CHAR_SOUND_HOOHOO] = nil, -- Third jump sound
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = nil, -- Triple jump sounds
	[CHAR_SOUND_UH] = 'Damaged.ogg', -- Wall bonk
	[CHAR_SOUND_UH2] = 'Silent.ogg', -- Landing after long jump
	[CHAR_SOUND_UH2_2] = 'Silent.ogg', -- Same sound as UH2; jumping onto ledge
	[CHAR_SOUND_HAHA] = 'Silent.ogg', -- Landing triple jump
	[CHAR_SOUND_YAHOO] = 'jump1mecha.ogg', -- Long jump
	[CHAR_SOUND_DOH] = 'Damaged.ogg', -- Long jump wall bonk
	[CHAR_SOUND_WHOA] = 'GrabLedge.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] = 'Silent.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] = 'Falling.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] = 'jump1mecha.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] = 'Silent.ogg',
	[CHAR_SOUND_HRMM] = 'GrabLedge.ogg', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] = 'getstarmecha.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] = 'mechathrow.ogg', -- Throwing Bowser
--DAMAGE
	[CHAR_SOUND_ATTACKED] = 'Damaged.ogg', -- Damaged
	[CHAR_SOUND_PANTING] = 'Silent.ogg', -- Low health
	[CHAR_SOUND_ON_FIRE] = 'Burned.ogg', -- Burned
--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] = 'Silent.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] = 'Silent.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] = 'Silent.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] = 'Silent.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] = 'Silent.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] = 'Silent.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] = 'Silent.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] = 'Silent.ogg', -- Cough take 3
--DEATH
	[CHAR_SOUND_DYING] = 'dyingmecha.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] = 'drowningmecha.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] = 'LeaveLevel.ogg' -- Booted out of level
}
-- All Located in "actors"
local CAPTABLE_CHAR_MECHA = {
    normal = smlua_model_util_get_id("mechasnormal_geo"),
    wing = smlua_model_util_get_id("mechaswing_geo"),
    metal = smlua_model_util_get_id("mechasmetal_geo"),
}
local CAPTABLE_CHAR_METAL = {
    normal = smlua_model_util_get_id("metals_normal_geo"),
    wing = smlua_model_util_get_id("metals_wing_geo"),
    metal = smlua_model_util_get_id("metals_metal_geo"),
}

local healthMeter = {
    label = {
        left = get_texture_info("metalhud-left"),
        right = get_texture_info("metalhud-right"),
    },
    pie = {
    [1] = get_texture_info("metalhud-1"),
    [2] = get_texture_info("metalhud-2"),
    [3] = get_texture_info("metalhud-3"),
    [4] = get_texture_info("metalhud-4"),
    [5] = get_texture_info("metalhud-5"),
    [6] = get_texture_info("metalhud-6"),
    [7] = get_texture_info("metalhud-7"),
    [8] = get_texture_info("metalhud-8"),
    }
}
gStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    local e = gStateExtras[i]
    e.animFrame = 0
end

local peelRelease = audio_sample_load("PeelRelease.ogg")
local jumpsound = audio_sample_load("cdjump.ogg")
ACT_METAL_CROUCH = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_PAUSE_EXIT | ACT_FLAG_SHORT_HITBOX)
ACT_METAL_CHARGE = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_PAUSE_EXIT | ACT_FLAG_SHORT_HITBOX | ACT_FLAG_INVULNERABLE | ACT_FLAG_ATTACKING)
ACT_METAL_SLIDE = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_INVULNERABLE  | ACT_FLAG_RIDING_SHELL)
ACT_METAL_SLIDE_AIR = allocate_mario_action( ACT_FLAG_AIR | ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_INVULNERABLE  | ACT_FLAG_RIDING_SHELL)
CHAR_ANIM_SONIC_SLIDE = 140


--- @param m MarioState
local function spawn_terrain_particles(m)

    if (m.terrainSoundAddend == (SOUND_TERRAIN_WATER << 16)) then
        set_mario_particle_flags(m, PARTICLE_SHALLOW_WATER_SPLASH, 0);
    else
        if (m.terrainSoundAddend == (SOUND_TERRAIN_SAND << 16)) then
            set_mario_particle_flags(m, PARTICLE_DIRT, 0);
        elseif (m.terrainSoundAddend == (SOUND_TERRAIN_SNOW << 16)) then
            set_mario_particle_flags(m, PARTICLE_SNOW, 0);
        else
            set_mario_particle_flags(m, PARTICLE_DIRT, 0);
        end
    end
end

--- @param m MarioState
local function spawn__sonic_charge_particles(m)
    spawn_terrain_particles(m)
    set_mario_particle_flags(m, PARTICLE_DUST, 0);
end

local m = gMarioStates[0]
local e = gStateExtras[m.playerIndex]
e.animFrame = 0
--- @param m MarioState
function act_sonic_charge(m)
    stationary_ground_step(m)
    if (m.controller.buttonDown & B_BUTTON) == 0 and m.actionArg > 9 then
        m.forwardVel =  m.actionArg * 1.1
        set_mario_action(m, ACT_METAL_SLIDE, 0)
        audio_sample_play(peelRelease, m.pos, 1)
        set_mario_particle_flags(m, PARTICLE_MIST_CIRCLE,0)
        return
    end
    m.actionArg = m.actionArg + 10
    if is_mk2(m) then
        m.actionArg = m.actionArg + 10
    end
    if m.actionArg > 120 and is_metal_sonic(m) then
        m.actionArg = 120
    end
    if m.actionArg > 135 and is_mk2(m) then
        m.actionArg = 135
    end

    smlua_anim_util_set_animation(m.marioObj, "JUMPBALL_METAL")
    e.animFrame = e.animFrame + 1 + m.actionArg/150
    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
	     e.animFrame = 0
  	end
    set_anim_to_frame(m, e.animFrame)
    spawn__sonic_charge_particles(m)

    m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x800/10, 0x800/10)
    m.marioObj.header.gfx.angle.x = 0x8000/6
    return 0
end
local e = gStateExtras[m.playerIndex]
e.animFrame = 0
m.marioObj.header.gfx.animInfo.curAnim.loopEnd = 0

--- @param m MarioState
function update_sonic_slide_animation(m)
	if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
		e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
	end
	e.animFrame = e.animFrame + 2 * (m.forwardVel / 95)
	smlua_anim_util_set_animation(m.marioObj, "JUMPBALL_METAL")
	set_anim_to_frame(m, e.animFrame)
    
end

--- @param m MarioState
--- @return boolean
function act_sonic_slide_above_water(m)
    if(m.floorHeight <= m.waterLevel) then
        play_sound(SOUND_MOVING_TERRAIN_RIDING_SHELL + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
        set_mario_particle_flags(m, PARTICLE_SHALLOW_WATER_WAVE, 0)
        if m.forwardVel < 15 then
            set_mario_action(m, ACT_IDLE, 0)
            return true
        end
    end
    return false
end

--- @param m MarioState
--- @return boolean
function act_sonic_slide_above_lava(m)
    if( m.floor ~= nil and m.floor.type == SURFACE_BURNING) then
        mario_set_forward_vel(m, m.forwardVel - 1.75)
       if m.forwardVel < 25 then
           set_mario_action(m, ACT_IDLE, 0)
           return true
       end
    end
    return false
end

--- @param m MarioState
--- @param startYaw number
local function tilt_sonic_slide(m,startYaw)
    local dYaw = m.faceAngle.y - startYaw;
    local val02 = -convert_s16(dYaw * m.forwardVel * 5);

    val02 = math.min(1365,val02)
    val02 = math.max(-1365,val02)
    m.marioObj.header.gfx.angle.z= approach_s32(m.marioObj.header.gfx.angle.x, val02, 1365, 1365);
end

--- @param m MarioState
function act_sonic_slide(m)
    local startYaw = m.faceAngle.y
	mario_set_forward_vel(m, m.forwardVel - 0.5)
    if (m.controller.buttonDown & B_BUTTON) ~= 0 and m.forwardVel < 70 and m.floorHeight > m.waterLevel and ( m.floor ~= nil and m.floor.type == SURFACE_BURNING) == false then
        m.forwardVel = 120
        audio_sample_play(peelRelease, m.pos, 0.5)
    end

    local changedAction = act_sonic_slide_above_water(m) or act_sonic_slide_above_lava(m)
    if changedAction then return end
    if m.forwardVel < 1 then
		set_mario_action(m, ACT_IDLE, 0)
        return
	end

    adjust_sound_for_speed(m)

    local stepResult = perform_ground_step(m)
	if stepResult == GROUND_STEP_HIT_WALL and m.forwardVel >= 20 then
		set_mario_action(m, ACT_GROUND_BONK, 1)
		m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_sound(SOUND_ACTION_HIT, m.marioObj.header.gfx.cameraToObject)
    elseif stepResult == GROUND_STEP_LEFT_GROUND then
        set_mario_action(m,ACT_METAL_SLIDE_AIR,0)
    end
    m.particleFlags = m.particleFlags | PARTICLE_DUST

	update_sonic_slide_animation(m)

	if (m.input & INPUT_A_PRESSED) ~= 0 then
		set_mario_action(m, ACT_JUMP, 0)
	end

	m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x6000, 0x6000)

    if (m.input & INPUT_ABOVE_SLIDE) ~= 0 then
        return set_mario_action(m, ACT_WALKING, 0)
    end
    tilt_sonic_slide(m,startYaw)
end
hook_mario_action(ACT_METAL_CHARGE, act_sonic_charge)
hook_mario_action(ACT_METAL_SLIDE, act_sonic_slide, INT_KICK)
if _G.doorBust then
	_G.doorBust.add_door_bust_action(ACT_METAL_SLIDE)
end
--- @param m MarioState
function act_sonic_slide_air(m)
    update_sonic_slide_animation(m)
    update_air_without_turn(m);

    local step = perform_air_step(m, 0)
    if step == AIR_STEP_LANDED then
        set_mario_action(m, ACT_METAL_SLIDE, 0);
    elseif step == AIR_STEP_HIT_WALL and m.forwardVel >= 20 then
        set_mario_action(m, ACT_BACKWARD_GROUND_KB, 1)
        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_sound(SOUND_ACTION_HIT, m.marioObj.header.gfx.cameraToObject)
    elseif step == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m);
    end

end

hook_mario_action(ACT_METAL_SLIDE_AIR, act_sonic_slide_air, INT_KICK)

function convert_s16(num)
    local min = -32768
    local max = 32767
    while (num < min) do
        num = max + (num - min)
    end
    while (num > max) do
        num = min + (num - max)
    end
    return num
end
local dropdash = audio_sample_load("dropdash.ogg")
local METAL_SONIC_JUMP = allocate_mario_action(
ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_SHORT_HITBOX | ACT_FLAG_ATTACKING)
function metal_jump(m)
    local mo = m.marioObj
    if (m.actionTimer == 0) then
        audio_sample_play(jumpsound, m.pos, 1)
        set_character_animation(m, CHAR_ANIM_A_POSE)
        smlua_anim_util_set_animation(mo, "JUMPBALL_METAL")
        m.vel.y = 60
    elseif m.controller.buttonPressed == B_BUTTON and is_metal_sonic(m) then
        audio_sample_play(dropdash, m.pos, 1)
        set_mario_action(m, ACT_METAL_DROP_DASH, 0)
        m.vel.y = -50
    elseif (m.pos.y <= m.floorHeight) then
        m.action = ACT_JUMP_LAND
    end
    perform_air_step(m,0)
    m.actionTimer = m.actionTimer + 1
end

function on_metal_jump()
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then return end
    if (m.action == ACT_JUMP or m.action == ACT_TRIPLE_JUMP) then
        set_mario_action(m, METAL_SONIC_JUMP, 0)
    elseif (m.controller.buttonPressed == Z_TRIG and m.action ~= ACT_GROUND_POUND and m.action & ACT_FLAG_AIR ~= 0) then
        set_mario_action(m, ACT_GROUND_POUND, 0)
    end
    if m.action == ACT_GROUND_POUND then
        smlua_anim_util_set_animation(m.marioObj, "JUMPBALL_METAL")
    end
end
hook_mario_action(METAL_SONIC_JUMP, metal_jump)

--- @param m MarioState
function noSwimAllowed(m)
    if (m.flags & MARIO_METAL_CAP) ~= 0 and m.capTimer ~= 0 then return end

    if ((m.action & ACT_GROUP_MASK) == ACT_GROUP_SUBMERGED) then
        m.flags = m.flags | MARIO_METAL_CAP
    else
        m.flags = m.flags & ~MARIO_METAL_CAP
    end

    -- stop rendering as metal cap
    m.marioBodyState.modelState = m.marioBodyState.modelState & ~MODEL_STATE_METAL
end

function on_fall()
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then return end
    m.peakHeight = m.pos.y
end
function use_spindash(m)
    if m.playerIndex ~= 0 then return end
    if (m.action == ACT_MOVE_PUNCHING or m.action == ACT_PUNCHING or m.action == ACT_DIVE) and is_metal_sonic(m) then
        set_mario_action(m, ACT_METAL_CHARGE, 45)
    elseif (m.action == ACT_MOVE_PUNCHING or m.action == ACT_PUNCHING or m.action == ACT_DIVE) and is_mk2(m) then
        set_mario_action(m, ACT_METAL_CHARGE, 30)
    end
end

--- @param m MarioState
--- @return boolean
function is_metal_sonic(m)
    return METAL_SONIC == charSelect.character_get_current_number()
end

--- @param m MarioState
--- @return boolean
function is_mk2(m)
    return MECHA_SONIC_MK2 == charSelect.character_get_current_number()
end

--- @param m MarioState
function hook_moves_lmao(m)
    if is_metal_sonic(m) or is_mk2(m) then
        on_metal_jump()
        noSwimAllowed(m)
        use_spindash(m)
        on_fall()
    end
end
local CSloaded = false
function on_character_select_load()
    METAL_SONIC = _G.charSelect.character_add("Metal Sonic", {"The Blue Blur's robotic doppleganger", "M&S Winter Olympic Games DS"}, "Luogi, Warioplier for model, Darkly for code", {r = 0, g = 0, b = 200}, MODEL_METAL_SONIC, CT_MARIO, TEX_METAL_LIFE_ICON)
    MECHA_SONIC_MK2 = charSelect.character_add("Mecha Sonic MK2", {"The scourge of Mobius AND the Mushroom Kingdom!", "Custom Model by: Tromak"}, "Luogi, Garrulous64 for model, Darkly for code", {r = 0, g = 0, b = 200}, MODEL_MECHA_SONIC_MK2, CT_MARIO, TEX_MECHA_LIFE_ICON)
    _G.charSelect.character_add_caps(MODEL_METAL_SONIC, CAPTABLE_CHAR_METAL)
    _G.charSelect.character_add_caps(MODEL_MECHA_SONIC_MK2, CAPTABLE_CHAR_MECHA)
    _G.charSelect.character_add_voice(MODEL_MECHA_SONIC_MK2, VOICE_MECHA)
    _G.charSelect.character_add_voice(MODEL_METAL_SONIC, VOICE_METAL)
    _G.charSelect.character_hook_moveset(MECHA_SONIC_MK2, HOOK_MARIO_UPDATE, hook_moves_lmao)
    _G.charSelect.character_hook_moveset(METAL_SONIC, HOOK_MARIO_UPDATE, hook_moves_lmao)
    _G.charSelect.character_add_celebration_star(MODEL_METAL_SONIC, nil, TEX_STAR_ICON)
    _G.charSelect.character_add_celebration_star(MODEL_MECHA_SONIC_MK2, nil, TEX_STAR_ICON)
    if _G.customMovesExists then
        _G.customMoves.character_add({
        name = "Metal Sonic",
        disable_burning = true,
        explode_on_death = true,
        disable_breath_heal = true,
        knock_back_resistance = 50,
        walking_speed = 200,
            in_air_speed = 200,
        peel_out_on = true,})
        _G.customMoves.character_add({
        name = "Mecha Sonic MK2",
        disable_burning = true,
        explode_on_death = true,
        disable_breath_heal = true,
        knock_back_resistance = 50,
        walking_speed = 200,
            in_air_speed = 200,
        peel_out_on = true,})
    end
    _G.charSelect.character_add_health_meter(METAL_SONIC, healthMeter)
    CSloaded = true
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICE_METAL then return _G.charSelect.voice.sound(m, sound) end
    if _G.charSelect.character_get_voice(m) == VOICE_MECHA then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICE_METAL then return _G.charSelect.voice.snore(m) end
    if _G.charSelect.character_get_voice(m) == VOICE_MECHA then return _G.charSelect.voice.snore(m) end
end
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)

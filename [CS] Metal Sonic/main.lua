-- name:[CS] The Metal Initiative V2
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
local MODEL_STAR_EMERALD = smlua_model_util_get_id("star_geo")
local TEX_MECHA_LIFE_ICON = get_texture_info("mechas_icon")
local TEX_STAR_ICON = get_texture_info("MasterEmerald")
-- All Located in "sound"
local VOICE_METAL = {
    --[CHAR_SOUND_OKEY_DOKEY] = 'StartLevel.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] = 'StartLevel.ogg', -- Starting level
	[CHAR_SOUND_PUNCH_YAH] = 'Jump1.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] = 'Jump2.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] = 'Jump3.ogg', -- Punch 3
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
	[CHAR_SOUND_PUNCH_YAH] = 'Punch1.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] = 'Punch2.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] = 'Punch3.ogg', -- Punch 3
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

local PALETTE_CHAR = {
    [PANTS]  = "ffffff",
    [SHIRT]  = "ffffff",
    [GLOVES] = "ffffff",
    [SHOES]  = "ffffff",
    [HAIR]   = "ffffff",
    [SKIN]   = "ffffff",
    [CAP]    = "00008B",
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
local rolllockSpindash
function rolllock(msg)
    if msg == "true" then
        rolllockSpindash = METAL_SONIC_JUMP
        return true
    elseif msg == "false" then
        rolllockSpindash = ACT_JUMP
        return true
    end
end
gStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gStateExtras[i]
    local s = gPlayerSyncTable[i]
    e.spincharge = 0
    e.animFrame = 0
end
local math_sqrt, math_min, math_max, math_floor = math.sqrt, math.min, math.max, math.floor

local function limit_angle(a)
    return (a + 0x8000) % 0x10000 - 0x8000
end
local peeloutrelease = audio_sample_load("peeloutrelease.mp3")
local peeloutcharge = audio_sample_load("peeloutcharge.ogg")
local jumpsound = audio_sample_load("jump.ogg")
ACT_METAL_CROUCH = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_PAUSE_EXIT | ACT_FLAG_SHORT_HITBOX)
ACT_METAL_CHARGE = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_PAUSE_EXIT | ACT_FLAG_SHORT_HITBOX | ACT_FLAG_INVULNERABLE | ACT_FLAG_ATTACKING)
ACT_METAL_SLIDE = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_INVULNERABLE)
local spindashInput = Z_TRIG
CHAR_ANIM_SONIC_SLIDE = 140
local peeloutcharge = audio_sample_load("peeloutcharge.ogg")
local peeloutrelease = audio_sample_load("peeloutrelease.mp3")
gStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gStateExtras[i]
    local s = gPlayerSyncTable[i]
    e.spincharge = 0
    e.animFrame = 0
end

local math_sqrt, math_min, math_max, math_floor = math.sqrt, math.min, math.max, math.floor

local function limit_angle(a)
    return (a + 0x8000) % 0x10000 - 0x8000
end

local m = gMarioStates[0]
local e = gStateExtras[m.playerIndex]
local b = m.marioBodyState
e.animFrame = 0
e.spincharge = 0
function act_sonic_charge(m)
    stationary_ground_step(m)
    if m.controller.buttonPressed ~= B_BUTTON and e.spincharge < 10 then
      set_mario_action(m, ACT_STOP_CROUCHING, 0)
    elseif m.controller.buttonPressed ~= B_BUTTON and e.spincharge > 9 then
      set_mario_action(m, ACT_METAL_SLIDE, 0)
      m.forwardVel = e.spincharge*1.1
    end
      e.spincharge = e.spincharge + 10
      if e.spincharge > 100 then
         e.spincharge = 100
      end
      if e.spincharge > 0 then
         e.spincharge = e.spincharge - 1
      end
      smlua_anim_util_set_animation(m.marioObj, "JUMPBALL_METAL")
      e.animFrame = e.animFrame + 1 + e.spincharge/150
      if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
	     e.animFrame = 0
  	end
      set_anim_to_frame(m, e.animFrame)

    return 0
end
local e = gStateExtras[m.playerIndex]
e.animFrame = 0
m.marioObj.header.gfx.animInfo.curAnim.loopEnd = 0
function act_sonic_slide(m)
	mario_set_forward_vel(m, m.forwardVel - 0.5)
	if m.forwardVel < 1 then
		set_mario_action(m, ACT_IDLE, 0)
	end

    local stepResult = perform_ground_step(m)
    if stepResult == GROUND_STEP_LEFT_GROUND then
        set_mario_action(m, ACT_FREEFALL, 99)
	elseif stepResult == GROUND_STEP_HIT_WALL then
		set_mario_action(m, ACT_WALKING, 1)
		m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_sound(SOUND_ACTION_HIT, m.marioObj.header.gfx.cameraToObject)
    end
	m.particleFlags = m.particleFlags | PARTICLE_DUST

	if METAL_SONIC == _G.charSelect.character_get_current_number() or MECHA_SONIC_MK2 == _G.charSelect.character_get_current_number() then
		if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
			e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
		end
		e.animFrame = e.animFrame + 2 * (m.forwardVel / 95)
		smlua_anim_util_set_animation(m.marioObj, "JUMPBALL_METAL")
		set_anim_to_frame(m, e.animFrame)
	end

	if (m.input & INPUT_A_PRESSED) ~= 0 then
		set_mario_action(m, METAL_SONIC_JUMP, 0)
	end

	m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x600, 0x600)

    if (m.input & INPUT_ABOVE_SLIDE) ~= 0 then
        return set_mario_action(m, ACT_WALKING, 0)
    end

    m.actionTimer = m.actionTimer + 1
    return
end
hook_mario_action(ACT_METAL_CHARGE, act_sonic_charge)
hook_mario_action(ACT_METAL_SLIDE, act_sonic_slide, INT_KICK)

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

local METAL_SONIC_JUMP = allocate_mario_action(
ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_SHORT_HITBOX | ACT_FLAG_ATTACKING)
function metal_jump(m)
    local mo = m.marioObj
    if (m.actionTimer == 0) then
        audio_sample_play(jumpsound, m.pos, 1)
        set_character_animation(m, CHAR_ANIM_A_POSE)
        smlua_anim_util_set_animation(mo, "JUMPBALL_METAL")
        m.vel.y = 50
    elseif (m.pos.y <= m.floorHeight)then
        m.action = ACT_JUMP_LAND
    end
    perform_air_step(m,0)
    m.actionTimer = m.actionTimer + 1
end

function on_metal_jump(m)
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then return end
    if (m.action == ACT_JUMP or m.action == ACT_TRIPLE_JUMP) then
        set_mario_action(m, METAL_SONIC_JUMP, 0)
    --elseif (m.controller.buttonPressed == Z_TRIG) then
    --    set_mario_action(m, ACT_GROUND_POUND, 0)
    end
end
hook_mario_action(METAL_SONIC_JUMP, metal_jump)


function noSwimAllowed(m)
    local m = gMarioStates[0]
    if ((m.action & ACT_GROUP_MASK) == ACT_GROUP_SUBMERGED) then
        m.flags = m.flags | MARIO_METAL_CAP
    else
        m.flags = m.flags & ~MARIO_METAL_CAP
    end
end

function on_fall(m)
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then return end
    m.peakHeight = m.pos.y
end
function use_spindash(m)
    if m.playerIndex ~= 0 then return end
    if m.controller.buttonPressed == B_BUTTON then
        set_mario_action(m, ACT_METAL_CHARGE, 0)
    end
end
local peeloutinput = U_JPAD

local METAL_PEELOUT = allocate_mario_action(ACT_GROUP_STATIONARY)

gStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    local e = gStateExtras[i]
    e.animation = 0
    e.animSpeed = 1
end

--- @param m MarioState
local function spawn_terrain_particles(m)

    if (m.terrainSoundAddend == (SOUND_TERRAIN_WATER << 16)) then

            set_mario_particle_flags(m, PARTICLE_SHALLOW_WATER_SPLASH, 0);

    else
        if (m.terrainSoundAddend == (SOUND_TERRAIN_SAND << 16)) then
            set_mario_particle_flags(m, PARTICLE_DIRT, 0);
        elseif (m.terrainSoundAddend == (SOUND_TERRAIN_SNOW << 16)) then
            set_mario_particle_flags(m, PARTICLE_SNOW, 0);
        end
    end
end

local function act_peelout(m)
    local stepResult = perform_ground_step(m)
    local s = gPlayerSyncTable[m.playerIndex]
    local e = gStateExtras[m.playerIndex]
    if stepResult ~= GROUND_STEP_LEFT_GROUND then
        m.vel.y = 0
    else
        mario_set_forward_vel(m, m.forwardVel)
        s.lastPosX = m.pos.x
        s.lastPosZ = m.pos.z
        if (m.input & (INPUT_NONZERO_ANALOG)) ~= 0 then
            if analog_stick_held_back(m) ~= 0 then
                m.faceAngle.y = m.faceAngle.y + 0x8000
                m.forwardVel = -m.forwardVel
                if m.forwardVel < 0 then
                end
            elseif m.forwardVel < 10 then
                m.forwardVel = m.forwardVel + 1
            end
        end
    end

    if m.actionTimer == 0 then
        s.spinrev = 0
        s.lastPosX = m.pos.x
        s.lastPosZ = m.pos.z
        audio_sample_play(peeloutcharge, m.pos, 1)
    end
    if m.pos.y == m.floorHeight then
        play_step_sound(m, 9, 45)
        m.pos.x = s.lastPosX
        m.pos.z = s.lastPosZ
        m.marioObj.header.gfx.pos.x = s.lastPosX
        m.marioObj.header.gfx.pos.y = m.pos.y
        m.marioObj.header.gfx.pos.z = s.lastPosZ
    end

    if m.pos.y == m.floorHeight then
        if m.controller.buttonPressed & peeloutinput ~= 0 then
            audio_sample_play(peeloutrelease, m.pos, 1)
            set_mario_action(m, ACT_WALKING, 0)
            mario_set_forward_vel(m, 100)
            m.forwardVel = s.spinrev
            prevForwardVel = s.spinrev
            set_camera_shake_from_hit(SHAKE_MED_DAMAGE)
            set_camera_shake_from_point(SHAKE_POS_MEDIUM, m.pos.x, m.pos.y, m.pos.z)
            m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
            s.spinrev = 0
        end
        if m.pos.y < m.waterLevel - 100 then
            if s.spinrev >= 80 then
                s.spinrev = 80
            end
        end
        if s.spinrev < 128 then
            s.spinrev = s.spinrev + 5
        end



        if s.spinrev >= 128 and m.actionTimer % 2 == 0 then
            spawn_terrain_particles(m)
        elseif s.spinrev >= 64 and s.spinrev < 128 and m.actionTimer % 3 == 0 then
            spawn_terrain_particles(m)
        elseif s.spinrev >= 64 and (m.actionTimer % 5 < 4) then
            set_mario_particle_flags(m, PARTICLE_DUST, 0);
        end
    end

    m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x300, 0x300)
    set_mario_anim_with_accel(m, e.animation, s.spinrev / 5 * e.animSpeed)
    SetRunAnims(m, s.spinrev, s.spinrev)
    m.actionTimer = m.actionTimer + 1
end

function SetRunAnims(m, Speed, NegSpeed)
    local e = gStateExtras[m.playerIndex]

    if Speed < 50 and Speed > 0 then
        e.animation = CHAR_ANIM_RUNNING_UNUSED
    elseif Speed >= 50 and Speed < 124 then
        e.animation = CHAR_ANIM_RUNNING
    elseif Speed >= 124 then
        e.animation = CHAR_ANIM_RUNNING
    end

    if NegSpeed > -50 and NegSpeed < -0 then
        e.animation = CHAR_ANIM_RUNNING_UNUSED
    elseif NegSpeed <= -50 and Speed > -124 then
        e.animation = CHAR_ANIM_RUNNING
    elseif NegSpeed <= -124 then
        e.animation = CHAR_ANIM_RUNNING
    end

    if e.animation == CHAR_ANIM_RUNNING_UNUSED then
        e.animSpeed = 0x10000
    elseif e.animation ~= CHAR_ANIM_RUNNING then
        e.animSpeed = 0x7000
    elseif e.animation == CHAR_ANIM_RUNNING then
        e.animSpeed = 0x10000
    end
end

local prevForwardVel = 0
function update_walk_speed_without_max_cap(m)
    local maxTargetSpeed = m.floor ~= nil and m.floor.type == SURFACE_SLOW and 24 or 32
    local targetSpeed = math.min(m.intendedMag, maxTargetSpeed)
    if m.quicksandDepth > 10.0 then
        targetSpeed = (targetSpeed * 6.25) / m.quicksandDepth
    end

    if m.forwardVel <= 0.0 then
        m.forwardVel = m.forwardVel + 1.1
    elseif m.forwardVel <= targetSpeed then
        m.forwardVel = m.forwardVel + 1.1 - m.forwardVel / 43;
    elseif m.floor ~= nil and m.floor.normal.y >= 0.95 then
        m.forwardVel = m.forwardVel - 0.5
    end

    apply_slope_accel(m);
end

local peelOutAfter = false
function update_peel_out_after(m)
    if m.prevAction == METAL_PEELOUT then
        peelOutAfter = true
    end
    if peelOutAfter and m.action ~= ACT_WALKING and m.action ~= ACT_BRAKING then
        peelOutAfter = false
    end
end

function on_peelout(m)
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then
        return
    end

    if m.action & ACT_FLAG_IDLE ~= 0 and m.controller.buttonPressed & peeloutinput ~= 0 then
        set_mario_action(m, METAL_PEELOUT, 0)
    elseif (m.action == ACT_BRAKING_STOP or m.action == ACT_BRAKING or m.action == ACT_DECELERATING) and m.controller.buttonPressed & peeloutinput ~= 0 and m.forwardVel < 16 then
        m.forwardVel = 0
        set_mario_action(m, METAL_PEELOUT, 0)
    end

    update_peel_out_after(m)

    if peelOutAfter and m.action == ACT_WALKING and prevForwardVel > 48 then
        m.forwardVel = prevForwardVel
        update_walk_speed_without_max_cap(m)
    end
    prevForwardVel = m.forwardVel

end
hook_mario_action(METAL_PEELOUT, act_peelout)

local function before_phys(m)
    if peelOutAfter and m.action == ACT_WALKING and prevForwardVel > 48  then
        mario_set_forward_vel(m,prevForwardVel)
    end
end
hook_event(HOOK_BEFORE_PHYS_STEP, before_phys)


function hook_moves_lmao(m)
    if METAL_SONIC == _G.charSelect.character_get_current_number() or MECHA_SONIC_MK2 == _G.charSelect.character_get_current_number() then
        on_peelout(m)
        on_metal_jump(m)
        noSwimAllowed(m)
        use_spindash(m)
        on_fall(m)
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
        in_air_speed = 200,})
        _G.customMoves.character_add({
        name = "Mecha Sonic MK2",
        disable_burning = true,
        explode_on_death = true,
        disable_breath_heal = true,
        knock_back_resistance = 50,
        walking_speed = 200,
        in_air_speed = 200,})
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
hook_chat_command("rolllock", "true/false, enables or disables rolllock for Metal Sonic", rolllock)
hook_event(HOOK_MARIO_UPDATE, on_fall)
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)

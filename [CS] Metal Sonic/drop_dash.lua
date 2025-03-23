ACT_METAL_DROP_DASH = allocate_mario_action(ACT_FLAG_AIR | ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING |
                                                ACT_FLAG_INVULNERABLE | ACT_FLAG_RIDING_SHELL)

--- @param m MarioState
function act_metal_drop_dash(m)
    update_sonic_slide_animation(m)
    update_air_without_turn(m);

    local step = perform_air_step(m, 0)
    if step == AIR_STEP_LANDED then
        print("heldObjLastPosition")
        set_mario_action(m, ACT_METAL_CHARGE, 90);
    elseif step == AIR_STEP_HIT_WALL then
        set_mario_action(m, ACT_BACKWARD_GROUND_KB, 1)
        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_sound(SOUND_ACTION_HIT, m.marioObj.header.gfx.cameraToObject)
    elseif step == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m);
    end
end

function act_metal_drop_dash_gravity(m)
    m.vel.y = math.max(-150, m.vel.y - 10)
end
hook_mario_action(ACT_METAL_DROP_DASH, {
    every_frame = act_metal_drop_dash,
    gravity = act_metal_drop_dash_gravity
})

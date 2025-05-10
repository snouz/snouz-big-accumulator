
local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")

local graphics = "__snouz-big-accumulator__/graphics"
local ENTITYPATH = graphics .. "/entity/"

function big_accumulator_picture(tint, repeat_count)
    return
    {
      layers =
      {
        {
            filename = ENTITYPATH .. "big-accumulator.png",
            priority = "extra-high",
            width = 307,
            height = 362,
            scale = 0.5,
            repeat_count = repeat_count,
            tint = tint,
            shift = {0, -0.6},
        },
        {
            filename = ENTITYPATH .. "big-accumulator_shadow.png",
            priority = "extra-high",
            width = 384,
            height = 272,
            repeat_count = repeat_count,
            shift = {1, 0},
            scale = 0.5,
            draw_as_shadow = true,
        }
      }
    }
  end
  
  function big_accumulator_charge()
    return
    {
      layers =
      {
        big_accumulator_picture({1, 1, 1, 1} , 24),
        {
            filename = ENTITYPATH .. "big-accumulator_anim_charge.png",
            priority = "extra-high",
            width = 307,
            height = 362,
            line_length = 6,
            frame_count = 12,
            repeat_count = 2,
            draw_as_glow = true,
            shift = {0, -0.6},
            scale = 0.5,
            animation_speed = 0.3,
        }
      }
    }
  end
  
  function big_accumulator_reflection()
    return
    {
      pictures =
        {
          filename = ENTITYPATH .. "big-accumulator_reflection.png",
          priority = "extra-high",
          width = 20,
          height = 24,
          shift = util.by_pixel(0, 50),
          variation_count = 1,
          scale = 5
        },
        rotate = false,
        orientation_to_variation = false
    }
  end
  
  function big_accumulator_discharge()
    return
    {
      layers =
      {
        big_accumulator_picture({1, 1, 1, 1} , 24),
        {
            filename = ENTITYPATH .. "big-accumulator-anim_discharge.png",
            priority = "extra-high",
            width = 307,
            height = 362,
            line_length = 6,
            frame_count = 24,
            draw_as_glow = true,
            shift = {0, -0.6},
            scale = 0.5,
            animation_speed = 0.4,
        }
      }
    }
  end


data:extend(
{
  {
    type = "item",
    name = "big-accumulator",
    icon = graphics .. "/icons/big-accumulator.png",
    subgroup = "energy",
    order = "e[accumulator]-ba[accumulator]",
    inventory_move_sound = item_sounds.electric_large_inventory_move,
    pick_sound = item_sounds.electric_large_inventory_pickup,
    drop_sound = item_sounds.electric_large_inventory_move,
    place_result = "big-accumulator",
    stack_size = 20,
    weight = 200 * kg
  },

  {
    type = "recipe",
    name = "big-accumulator",
    energy_required = 60,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "accumulator", amount = 60},
      {type = "item", name = "copper-cable", amount = 50},
      {type = "item", name = "concrete", amount = 200}
    },
    results = {{type="item", name="big-accumulator", amount = 1}}
  },

  {
    type = "technology",
    name = "electric-energy-big-accumulators",
    icon = graphics .. "/technology/electric-energy-big-acumulators.png",
    icon_size = 256,
    localised_name = {"technology-name.electric-energy-big-accumulators-1"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-accumulator"
      }
    },
    prerequisites = {"utility-science-pack","electric-energy-accumulators","concrete","electric-energy-distribution-2"},
    unit =
    {
      count = 650,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
  },


  {
    type = "accumulator",
    name = "big-accumulator",
    icon = graphics .. "/icons/big-accumulator.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "big-accumulator"},
    fast_replaceable_group = "big-accumulator",
    max_health = 500,
    corpse = "big-accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-1.75, -1.75}, {1.75, 1.75}},
    selection_box = {{-2, -2}, {2, 2}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.5,
    --[[energy_source =
    {
      type = "electric",
      buffer_capacity = "5MJ",
      usage_priority = "tertiary",
      input_flow_limit = "300kW",
      output_flow_limit = "300kW"
    },]]--
    
  energy_source = {
    type = "electric",
    buffer_capacity = "300MJ",
    usage_priority = "tertiary",
    input_flow_limit = "20MW",
    output_flow_limit = "20MW"
  },
    chargable_graphics =
    {
      picture = big_accumulator_picture(),
      charge_animation = big_accumulator_charge(),
      charge_cooldown = 30,
      discharge_animation = big_accumulator_discharge(),
      discharge_cooldown = 60
      --discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
    },
    water_reflection = big_accumulator_reflection(),
    impact_category = "metal",
    open_sound = sounds.electric_large_open,
    close_sound = sounds.electric_large_close,
    working_sound =
    {
      main_sounds =
      {
        {
          sound = {filename = "__base__/sound/accumulator-working.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44)},
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 2, inverted = true},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        {
          sound = {filename = "__base__/sound/accumulator-discharging.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44)},
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 1},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        }
      },
      idle_sound = {filename = "__base__/sound/accumulator-idle.ogg", volume = 0.35},
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.5
    },

    circuit_connector = circuit_connector_definitions["accumulator"],
    circuit_wire_max_distance = 9,

    default_output_signal = {type = "virtual", name = "signal-A"},
    weight = 200 * kg
  },


  {
    type = "corpse",
    name = "big-accumulator-remnants",
    icon = graphics .. "/icons/big-accumulator.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "energy-remnants",
    order = "a-d-a",
    selection_box = {{-1, -1}, {1, 1}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (1,
    {
      filename = graphics .. "/entity/big-accumulator-remnants.png",
      line_length = 1,
      width = 307,
      height = 362,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.6},
      scale = 0.5
    })
  },
})

if mods["space-age"] then
  table.insert(data.raw["technology"]["electric-energy-big-accumulators"].prerequisites, "electromagnetic-science-pack")
  table.insert(data.raw["technology"]["electric-energy-big-accumulators"].unit.ingredients, {"electromagnetic-science-pack", 1})
  table.insert(data.raw["recipe"]["big-accumulator"].ingredients, {type = "item", name = "supercapacitor", amount = 10})
end
  
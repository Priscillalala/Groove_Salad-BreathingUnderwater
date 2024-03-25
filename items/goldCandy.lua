---@class GoldCandy : ItemModule
local goldCandy, identifier = ...

if not goldCandy then
    goldCandy = {}
    goldCandy.id = gm.item_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.uncommon,
        custom_item_pickup(identifier, load_sprite("sBoomerang", 18, 18)),
        LOOT_TAG.category_healing,
        nil,
        nil,
        true,
        2
    )
end

local item = get(class_item, goldCandy.id)
local on_acquired = get(item, CLASS_ITEM.on_acquired)

---[[
post_callback_hooks[on_acquired] = function (self, other, result, args)
    log.info("acquired Gold Candy!")
    local player = args[2].value
    local base_gold_price_scale = gm.cost_get_base_gold_price_scale()
    gm.drop_gold_and_exp(player.x, player.y - 10, 25 * base_gold_price_scale, false, true, false)
end
--]]

---[[
gm.post_script_hook(gm.constants.interactable_pay_cost, function(self, other, result, args)
    log.info("interactable_pay_cost: " .. #args)
    for index, value in ipairs(args) do
        log.info(value.value)
    end
    if args[1].value ~= 0 then
        return
    end
    local amount = args[2].value
    if amount <= 0 then
        return
    end
    local actor = args[3].value
    if not actor then
        return
    end
    local stack = get(actor.inventory_item_stack, goldCandy.id)
    if stack > 0 then
        log.info("item time!!")
        --gm.actor_heal_networked(actor, amount, false)
        local instance = gm.instance_create(actor.x, actor.y - 40, gm.constants.oEfHeal2)
        instance.value = amount * (0.2 + stack * 0.2)
        instance.direction = instance.direction + gm.random_range(-45, 45)
    end
    --type
    --amount
    --actor
end)
--]]
--instance
--amount
--regen
--[[
    gm.post_script_hook(gm.constants.drop_gold_and_exp, function(self, other, result, args)
        log.info("drop_gold_and_exp: " .. #args)
        for index, value in ipairs(args) do
            log.info(value.value)
        end
    end)
    --]]
    --[[
        gm.post_script_hook(gm.constants.draw_damage, function(self, other, result, args)
            log.info("draw_damage: " .. #args)
            for index, value in ipairs(args) do
                log.info(value.value)
            end
        end)
        --]]

return goldCandy
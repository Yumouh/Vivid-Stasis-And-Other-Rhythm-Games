SMODS.Joker{ --CHAOS
    key = "chaos",
    config = {
        extra = {
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'CHAOS',
        ['text'] = {
            [1] = 'Fill {C:attention}consumable{} slots',
            [2] = 'with random consumables',
            [3] = 'when {C:attention}Blind{} is selected',
            [4] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    local empty_slots = G.consumeables.config.card_limit - #G.consumeables.cards
                    
                    if empty_slots > 0 then
                        for i = 1, empty_slots do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    -- 获取所有消耗牌类型（排除collectable和Cine）
                                    local types = {}
                                    for _, v in pairs(SMODS.ConsumableTypes) do
                                        if v.key ~= "collectable" and v.key ~= "Cine" then
                                            types[#types + 1] = v
                                        end
                                    end
                                    -- 随机选择一个消耗牌类型并创建
                                    local random_type = pseudorandom_element(types, 'chaos_consumable')
                                    SMODS.add_card({ 
                                        set = random_type.key, 
                                        area = G.consumeables,
                                        soulable = true
                                    })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        
                    end
                    return true
                end
            }
        end
    end
}
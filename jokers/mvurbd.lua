SMODS.Joker{ --MVURBD
    key = "mvurbd",
    config = {
        extra = {
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'MVURBD',
        ['text'] = {
            [1] = 'Steal {C:attention}2X{} the {C:attention}sell value{}',
            [2] = 'of Joker to its right',
            [3] = 'when {C:attention}Small Blind{}  or',
            [4] = '{C:attention}Big Blind{} is selected',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.setting_blind then
            if (G.GAME.blind.name == "Small Blind" or G.GAME.blind.name == "Big Blind") then
                if not context.blueprint and G.jokers.cards[#G.jokers.cards] ~= card then
                    for v, joker in ipairs(G.jokers.cards) do
                        if joker == card then
                            -- 夺走右侧小丑的售出价值的两倍加到自己身上
                            local stolen_value = G.jokers.cards[v + 1].sell_cost * 2
                            card.ability.extra_value = (card.ability.extra_value or 0) + stolen_value
                            card:set_cost()

                            -- 将右侧小丑的售出价值设为0
                            G.jokers.cards[v + 1].ability.extra_value = (G.jokers.cards[v + 1].ability.extra_value or 0) - G.jokers.cards[v + 1].sell_cost
                            G.jokers.cards[v + 1]:set_cost()

                            -- 显示效果信息
                            SMODS.calculate_effect({ extra = { message = localize('artb_stolen'), colour = G.C.MONEY } }, G.jokers.cards[v + 1])
                            SMODS.calculate_effect({ extra = { message = localize('k_val_up'), colour = G.C.MONEY } }, card)
                        end
                    end
                end
            end
        end
    end
}
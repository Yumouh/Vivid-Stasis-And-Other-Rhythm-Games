
SMODS.Joker{ 
    key = "allison",
    config = {
        extra = {
            chipz = 0.1,
            jokercount = 0
        }
    },
    loc_txt = {
        ['name'] = 'Allison',
        ['text'] = {
            [1] = 'This joker gains {X:blue,C:white}X0.1{} Chips',
            [2] = 'at the end of round per',
            [3] = '{C:attention}Joker{} to its left',
            [4] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
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
    pools = { ["stargaze_stargaze_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chipz}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                x_chips = card.ability.extra.chipz
            }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval then
            return {
                func = function()
                    local left_jokers = 0
                    local card_found = false
                    
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            card_found = true
                        elseif not card_found then
                            left_jokers = left_jokers + 1
                        end
                    end
                    
                    if left_jokers > 0 then
                        card.ability.extra.chipz = card.ability.extra.chipz + (left_jokers * 0.1)
                        return {
                            message = localize('k_upgrade_ex'),
                            card = card,
                            colour = G.C.RED
                        }
                    else
                        return true
                    end
                end
            }
        end
    end
}
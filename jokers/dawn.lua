SMODS.Joker{ --Dawn
    key = "dawn",
    config = {
        extra = {
            repetitions_min = 3,
            repetitions_max = 5
        }
    },
    loc_txt = {
        ['name'] = 'Dawn',
        ['text'] = {
            [1] = '{C:attention}Retrigger {}last played',
            [2] = 'card used in scoring',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    -- 添加动态文本显示，类似于Alien牌
    loc_vars = function(self, info_queue, card)
        local main_end = {
            {n=G.UIT.O, config={object = DynaText({string = {'3','4','5'}, colours = {G.C.ORANGE}, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2, scale = 0.32, min_cycle_time = 0})}},
            {n=G.UIT.T, config={text = ' additional times', colour = G.C.UI.TEXT_DARK, scale = 0.32}}
        }
        return { vars = {}, main_end = main_end }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    repetitions = pseudorandom('repetitions_c37d07de', card.ability.extra.repetitions_min, card.ability.extra.repetitions_max),
                    message = localize('k_again_ex')
                }
            end
        end
    end
}
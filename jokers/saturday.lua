SMODS.Joker{ 
    key = "saturday",
    config = {
        extra = {
            xmult = 1,
            plus = 0.07
        }
    },
    loc_txt = {
        ['name'] = 'Saturday',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X0.07{} Mult every time',
            [2] = 'a playing card is {C:attention}retriggered{}',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_stargaze_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.cardarea == G.play and context.individual then
            if not context.other_card.timesheeted then
                local c = context.other_card
                context.other_card.timesheeted = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if c then
                            c.timesheeted = nil
                        end
                        return true
                    end
                }))
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.plus
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                message = "Upgrade",
                colour = G.C.ORANGE
                })
                return {}
            end
        end
    end
}
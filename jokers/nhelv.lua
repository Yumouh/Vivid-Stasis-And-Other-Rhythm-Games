SMODS.Joker{ --Nhelv
    key = "nhelv",
    config = {
        extra = {
            size = 1,
            currenthandsize = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nhelv',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.1{} Mult for each',
            [2] = 'card held in hand {C:attention}exceeds{} ',
            [3] = 'hand size when hand is played',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vividsta_vividsta_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.size}}
    end,

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            return {
                func = function()
                    local hand_limit = G.hand and G.hand.config.card_limit or 0
                    local current_hand_count = #G.hand.cards
                    local excess_cards = math.max(0, current_hand_count - hand_limit)
                    card.ability.extra.size = excess_cards * 0.1 + card.ability.extra.size
                    
                    -- 只有当超出牌数大于0时才显示升级消息
                    if excess_cards > 0 then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = "Upgrade",
                        colour = G.C.ORANGE
                        })
                    else
                        return true
                    end
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.size
            }
        end
    end
}
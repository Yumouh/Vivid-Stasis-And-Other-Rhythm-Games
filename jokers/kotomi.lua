SMODS.Joker{ --Kotomi
    key = "kotomi",
    config = {
        extra = {
            rounds = 0,
            max_rounds = 1
        }
    },
    loc_txt = {
        ['name'] = 'Kotomi',
        ['text'] = {
            [1] = 'After {C:attention}1{} round,',
            [2] = 'sell this card to',
            [3] = 'apply a random {C:edition}edition{}',
            [4] = 'to the Joker to the right',
            [5] = '{C:inactive}Currently ({}{C:attention}#1#{}{C:inactive}/1){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rounds,
                card.ability.extra.max_rounds
            }
        }
    end,
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    calculate = function(self, card, context)
        -- 每回合结束时增加计数
        if context.end_of_round and not context.blueprint and not context.individual then
            -- 只在回合真正结束时计数，避免重复计数
            if card.ability.extra.rounds < card.ability.extra.max_rounds then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
                card:juice_up(0.5, 0.5)
                -- 直接显示激活状态，不显示进度
                if card.ability.extra.rounds >= card.ability.extra.max_rounds then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                    return {
                        message = localize('k_active'),
                        colour = G.C.FILTER
                    }
                end
            else
                -- 如果已经激活但还没售出，显示激活状态
                return {
                    message = localize('k_active'),
                    colour = G.C.FILTER
                }
            end
        end
        
        -- 售出时触发效果
        if context.selling_self and card.ability.extra.rounds >= card.ability.extra.max_rounds then
            -- 找到右边的小丑
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then 
                    my_pos = i
                    break 
                end
            end
            
            if my_pos and G.jokers.cards[my_pos+1] then
                local right_card = G.jokers.cards[my_pos+1]
                local edition = poll_edition('kotomi', nil, false, true)
                
                right_card:set_edition(edition, true)
                -- 不显示任何消息
            end
            -- 即使没有右边的小丑也不显示消息
        end
    end
}
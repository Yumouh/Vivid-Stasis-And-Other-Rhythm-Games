SMODS.Joker{ --Chiyo
    key = "chiyo",
    config = {
        extra = {
            CARD = 0,
            totalplayingcards = 0,
            cardsindeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'Chiyo',
        ['text'] = {
            [1] = '{C:red}+1{} Mult for each',
            [2] = 'card not in deck',
            [3] = '{C:inactive}(Currently {C:red}+#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3, 
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_stargaze_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        -- 实时计算不在牌组中的卡牌数量
        local total_cards = #(G.playing_cards or {})
        local deck_cards = #(G.deck and G.deck.cards or {})
        local CARD_value = math.max(0, total_cards - deck_cards)
        
        -- 更新卡牌能力中的值
        card.ability.extra.CARD = CARD_value
        
        return {vars = {CARD_value}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            -- 实时计算不在牌组中的卡牌数量
            local total_cards = #(G.playing_cards or {})
            local deck_cards = #(G.deck and G.deck.cards or {})
            local CARD_value = math.max(0, total_cards - deck_cards)
            
            -- 更新卡牌能力中的值
            card.ability.extra.CARD = CARD_value
            
            return {
            }
        end
    end
}
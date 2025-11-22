SMODS.Joker{ --RGB Prism
    key = "rgb_prism",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'RGB',
        ['text'] = {
            [1] = '#1# cards count as {C:attention}all suits{}',
            [2] = '{C:inactive}suit changes every round{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local current_suit = G.GAME.current_round.rgb_prism_suit or "Spades"
        return {vars = {localize(current_suit, 'suits_singular')}, colours = {G.C.SUITS[current_suit]}}
    end,

    set_ability = function(self, card, initial)
        -- 初始化特殊花色
        G.GAME.current_round.rgb_prism_suit = "Hearts"
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            -- 使用Farmer卡的花色变换逻辑
            if G.playing_cards then
                local valid_suity_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suity_cards[#valid_suity_cards + 1] = v
                    end
                end
                if valid_suity_cards[1] then
                    local suity_card = pseudorandom_element(valid_suity_cards, pseudoseed('rgb_prism' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.rgb_prism_suit = suity_card.base.suit
                    
                    -- 可选：添加视觉反馈
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                    message = "This is color...",
                    colour = G.C.RED
                })
                end
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- 初始化花色
        if not G.GAME.current_round.rgb_prism_suit then
            G.GAME.current_round.rgb_prism_suit = "Hearts"
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- 移除时不需要特殊处理
    end
}

-- 修改Card.is_suit函数来实现RGB Prism的能力
local card_is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local ret = card_is_suit_ref(self, suit, bypass_debuff, flush_calc)
    
    -- 如果RGB Prism小丑牌存在且当前卡牌是特殊花色，则视为所有花色
    if not ret and not SMODS.has_no_suit(self) then
        if next(SMODS.find_card("j_vsvsvsvs_rgb_prism")) then
            local current_special_suit = G.GAME.current_round.rgb_prism_suit or 'Spades'
            if self.base.suit == current_special_suit then
                ret = true
            end
        end
    end
    
    return ret
        
        
end
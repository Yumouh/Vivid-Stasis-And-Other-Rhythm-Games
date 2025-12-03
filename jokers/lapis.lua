SMODS.Joker{ --Lapis
    key = "lapis",
    config = {
        extra = {
            draw_extra = 1,
            to_draw = 0  -- 新增：记录需要抽多少张牌
        }
    },
    loc_txt = {
        ['name'] = 'Lapis',
        ['text'] = {
            [1] = 'Draw {C:attention}1{} additional card',
            [2] = 'for each {C:attention}#1#{} discarded,',
            [3] = 'rank changes every round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {vars = {localize((G.GAME.current_round.ran_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.ran_card = { rank = '7', id = 7 }
    end,
    
    calculate = function(self, card, context)
        -- 每回合结束时改变点数
        if context.end_of_round and context.game_over == false and context.main_eval then
            -- 重置抽牌计数器
            card.ability.extra.to_draw = 0
            
            if G.playing_cards then
                local valid_ran_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_ran_cards[#valid_ran_cards + 1] = v
                    end
                end
                if valid_ran_cards[1] then
                    local ran_card = pseudorandom_element(valid_ran_cards, pseudoseed('ran' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.ran_card.rank = ran_card.base.value
                    G.GAME.current_round.ran_card.id = ran_card.base.id
                end
            end
        end
        
        -- 弃牌时：记录弃掉了多少张指定点数的牌
        if context.discard then
            -- 检查弃掉的牌是否是当前指定的点数
            if context.other_card:get_id() == G.GAME.current_round.ran_card.id then
                card.ability.extra.to_draw = card.ability.extra.to_draw + card.ability.extra.draw_extra
                return {
                    func = function()
                        -- 显示状态文本
                        
                        return true
                    end
                }
            end
        end
        
        -- 抽牌时：根据记录的抽牌数量抽牌
        if (context.hand_drawn or G.hand.config.card_limit < G.hand.config.card_count) and card.ability.extra.to_draw > 0 then
            return {
                func = function()
                    -- 抽指定数量的牌
                    for i = 1, card.ability.extra.to_draw do
                        if #G.deck.cards > 0 then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    draw_card(G.deck, G.hand, 90, 'up', nil)
                                    return true
                                end
                            }))
                        end
                    end
                    
                    -- 重置抽牌计数器
                    card.ability.extra.to_draw = 0
                    return true
                end
            }
        end
    end
}
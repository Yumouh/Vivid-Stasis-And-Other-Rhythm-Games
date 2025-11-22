SMODS.Joker{ --Tsuki
    key = "tsuki",
    config = {
        extra = {
            triggered = 1,
            trash_list = {}
        }
    },
    loc_txt = {
        ['name'] = 'Tsuki',
        ['text'] = {
            [1] = 'If {C:attention}last hand{} of round',
            [2] = 'has only {C:attention}1{} card, destroy',
            [3] = 'it and give its chips value ',
            [4] = 'to all playing cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    calculate = function(self, card, context)
        -- 在每回合开始时重置触发状态
        if context.setting_blind then
            card.ability.extra.triggered = 1
        end

        -- 检查是否是最后一张手牌且只有一张牌
        if context.destroy_card and 
           (context.cardarea == G.play or context.cardarea == 'unscored') and 
           #context.full_hand == 1 and 
           G.GAME.current_round.hands_left == 0 and
           card.ability.extra.triggered == 1 then
            
            local target_card = context.full_hand[1]
            
            if target_card then
                -- 计算筹码加成：牌基础筹码值的1/2，向上取整
                local chip_bonus = math.ceil((target_card.base.nominal or 0) / 1)
                
                -- 给其他所有游戏牌添加筹码
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card ~= target_card then
                        playing_card.ability.bonus = playing_card.ability.bonus or 0
                        playing_card.ability.bonus = playing_card.ability.bonus + chip_bonus
                    end
                end
                
                -- 显示提示信息
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                    message = "R.I.P. ",
                    colour = G.C.BLACK
                })
                
                -- 标记为已触发，避免重复触发
                card.ability.extra.triggered = 0
                
                -- 返回remove=true来销毁目标牌
                return {remove = true}
            end
        end
        
        -- 在回合结束时重置触发状态
        if context.end_of_round then
            card.ability.extra.triggered = 1
        end
    end
}
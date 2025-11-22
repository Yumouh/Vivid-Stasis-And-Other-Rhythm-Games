SMODS.Joker{ --B.B.K.K.B.K.K.
    key = "bbkkbkk",
    config = {
        extra = {
            retriggers = 1  -- 重新触发次数设为1次
        }
    },
    loc_txt = {
        ['name'] = 'B.B.K.K.B.K.K.',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} all cards',
            [2] = 'in {C:red}discard{} {C:attention}1{} time'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    -- 添加计算函数来实现能力
    calculate = function(self, card, context)
        -- 当有卡牌被重新触发检查且不是自身触发的，并且另一个上下文是弃牌时
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and context.other_context.discard then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retriggers,  -- 使用配置的重新触发次数
                card = card
            }
        end
        
        -- 修正封印重复处理
        -- 注意：mf_seal_repetition 可能是特定mod的功能，如果不存在可以移除这部分
        if context.mf_seal_repetition and context.seal_context.discard then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retriggers,
                card = card
            }
        end
    end
}
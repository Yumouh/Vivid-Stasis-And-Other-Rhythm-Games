SMODS.Joker{ --Cutter
    key = "cutter",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Cutter',
        ['text'] = {
            [1] = 'For every pair of Jokers',
            [2] = 'with the same {C:attention}sell price{},',
            [3] = 'gain {X:red,C:white}X1{} Mult',
            [4] = '{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
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
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    -- 添加loc_vars函数用于实时显示当前倍率
    loc_vars = function(self, info_queue, card)
        -- 计算当前倍率
        local current_multiplier = 1
        local price_count = {}
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                local price = joker.sell_cost
                price_count[price] = (price_count[price] or 0) + 1
            end
            
            local total_pairs = 0
            for price, count in pairs(price_count) do
                total_pairs = total_pairs + (count * (count - 1)) / 2
            end
            
            current_multiplier = 1 + (1 * total_pairs)
            
            return {vars = {current_multiplier}}
        end
    end,

    calculate = function(self, card, context)
        local total_multiplier = 1
        if context.cardarea == G.jokers and context.joker_main then
            -- 统计所有小丑的售价（包括自身）
            
            local price_count = {}
            for _, joker in ipairs(G.jokers.cards) do
                local price = joker.sell_cost
                price_count[price] = (price_count[price] or 0) + 1
            end
            
            -- 计算总对数（考虑所有可能的配对）
            local total_pairs = 0
            for price, count in pairs(price_count) do
                total_pairs = total_pairs + (count * (count - 1)) / 2
            end
            
            -- 计算总倍率（每对提供 +0.5 倍率，从 X1 开始相加）
            total_multiplier = 1 + (1 * total_pairs)
            
            -- 返回倍率效果
            if total_pairs > 0 then
                return {
                    Xmult = total_multiplier
                }
            end
        end
    end
}
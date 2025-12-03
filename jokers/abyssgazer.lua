SMODS.Joker{ --Abyssgazer
    key = "abyssgazer",
    config = {
        extra = {
            chipp = 0,
            commonjokers = 0,
            uncommonjokers = 0,
            rarejokers = 0,
            legendaryjokers = 0
        }
    },
    loc_txt = {
        ['name'] = 'Abyssgazer',
        ['text'] = {
            [1] = 'Give Chips for each',
            [2] = '{C:attention}Joker{} depends on its {C:attention}rarity{}',
            [3] = '{C:common}Common{} -- {C:blue}+10{}',
            [4] = '{C:uncommon}Uncommon{} -- {C:blue}+20{}',
            [5] = '{C:rare}Rare{} & {C:legendary}Legendary{} -- {C:blue}+30',
            [6] = '{C:inactive}(Currently {C:blue}+#1#{}{}{C:inactive} chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        -- 实时计算当前应该提供的筹码值
        local current_chipp = 0
        
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                local rarity = joker.config.center.rarity
                if rarity == 1 then -- Common
                    current_chipp = current_chipp + 10
                elseif rarity == 2 then -- Uncommon
                    current_chipp = current_chipp + 20
                elseif rarity == 3 or rarity == 4 then -- Rare & Legendary
                    current_chipp = current_chipp + 30
                end
            end
        end
        
        -- 更新卡牌能力中的chipp值，确保显示和实际效果一致
        card.ability.extra.chipp = current_chipp
        
        return {vars = {current_chipp}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            -- 在主要阶段直接返回实时计算的筹码值
            local current_chipp = 0
            
            if G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do
                    local rarity = joker.config.center.rarity
                    if rarity == 1 then -- Common
                        current_chipp = current_chipp + 10
                    elseif rarity == 2 then -- Uncommon
                        current_chipp = current_chipp + 20
                    elseif rarity == 3 or rarity == 4 then -- Rare & Legendary
                        current_chipp = current_chipp + 30
                    end
                end
            end
            
            -- 更新卡牌能力中的值
            card.ability.extra.chipp = current_chipp
            
            return {
                chips = current_chipp,
                message = localize{type='variable',key='a_chips',vars={current_chipp}}
            }
        end
    end
}
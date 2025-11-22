SMODS.Joker{ --Aleph-0
    key = "aleph0",
    config = {
        extra = {
            mult = 5,
            ranks = {}
        }
    },
    loc_txt = {
        ['name'] = 'Aleph-0',
        ['text'] = {
            [1] = '{C:attention}Ranks{} that have not',
            [2] = 'been played give {C:red}+5{}',
            [3] = 'Mult when scored',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 2
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
        local ranks_played = ""

        for k, v in pairs(card.ability.extra.ranks) do
            ranks_played = ranks_played .. " " .. localize(v, 'ranks')
        end

        if ranks_played == "" then
            ranks_played = " " .. localize('paperback_none')
        end

        return {
            vars = {
                card.ability.extra.mult,
                ranks_played
            }
        }
    end,
    
    calculate = function(self, card, context)
        -- 检查是否为未记录的点数牌并给予倍率
        if context.individual and context.cardarea == G.play then
            local rank = not SMODS.has_no_rank(context.other_card) and context.other_card:get_id()
            
            if rank and not card.ability.extra.ranks[rank] then
                card.ability.extra.ranks[rank] = context.other_card.base.value
                
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end

        -- 回合结束时重置记录的点数
        if context.end_of_round and not context.game_over and not context.blueprint then
            card.ability.extra.ranks = {}
            
            return {

            }
        end
    end
}
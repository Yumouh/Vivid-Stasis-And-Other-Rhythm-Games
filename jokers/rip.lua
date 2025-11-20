SMODS.Joker{ --R.I.P.
    key = "rip",
    config = {
        extra = {
            no = 0,
            var1 = 0,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'R.I.P.',
        ['text'] = {
            [1] = 'When the {C:attention}Joker{} to its',
            [2] = 'right is sold, {C:attention}return{} it',
            [3] = '{C:red}self destructs{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 2
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
        if context.selling_card and context.card ~= card and context.card.ability.set == 'Joker' then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            
            -- 检查售出的小丑是否在RIP的右边
            if my_pos and my_pos < #G.jokers.cards then
                local right_joker = G.jokers.cards[my_pos + 1]
                if right_joker == context.card then
                    G.GAME.pool_flags.vsvsvsvs_ripdestroyed = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            -- 返回售出的小丑
                            local copy = copy_card(context.card)
                            copy:add_to_deck()
                            G.jokers:emplace(copy)
                            
                            -- RIP自毁
                            card:start_dissolve()
                            
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Returned!", colour = G.C.RED})
                            return true
                        end
                    }))
                    
                    return {
                    }
                end
            end
        end
    end
}

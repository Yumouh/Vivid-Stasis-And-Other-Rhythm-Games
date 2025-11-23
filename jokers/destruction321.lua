SMODS.Joker{ --DESTRUCTION 3,2,1
    key = "destruction321",
    config = {
        extra = {
            dollars = 5,
            explode = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'DESTRUCTION 3,2,1',
        ['text'] = {
            [1] = '{C:red}Destroy{} all cards',
            [2] = 'held in hand at the',
            [3] = 'end of the round',
            [4] = '{C:red}self destructs{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            -- 摧毁所有手牌
            for i = #G.hand.cards, 1, -1 do
                local hand_card = G.hand.cards[i]
                SMODS.destroy_cards({ hand_card })
            end
            
            -- 自毁
            return {
                extra = {
                    func = function()
                        card:start_dissolve()
                        return true
                    end,
                    message = "Total destruction!",
                    colour = G.C.RED
                }
            }
        end
        
        if context.destroy_card and context.destroy_card.should_destroy then
            return { remove = true }
        end
    end
}

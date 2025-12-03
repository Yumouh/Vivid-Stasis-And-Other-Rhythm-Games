
SMODS.Joker{ --crystallized
    key = "crystallized",
    config = {
        extra = {
            tot = 1
        }
    },
    loc_txt = {
        ['name'] = 'crystallized',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X0.1{} Mult {C:diamonds}{}when a',
            [2] = '{C:diamonds}#2#{} card is scored',
            [3] = 'Resets each {C:attention}ante{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
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
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.tot, localize((G.GAME.current_round.sui_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.sui_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.sui_card = { suit = 'Diamonds' }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                card.ability.extra.tot = (card.ability.extra.tot) + 0.1
                return {
                    message = "Upgrade"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.tot
            }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            return {
                func = function()
                    card.ability.extra.tot = 1
                    return true
                end,
                message = "Reset"
            }
        end
    end
}

SMODS.Joker{ --New York Back Raise
    key = "newyorkbackraise",
    config = {
        extra = {
            tex = 'Inactive',
            swi = 0,
            ger = 1,
            xchips0 = 3,
            custom_text = 0,
            Active = 0
        }
    },
    loc_txt = {
        ['name'] = 'New York Back Raise',
        ['text'] = {
            [1] = '{X:blue,C:white}X3{} Chips',
            [2] = '{C:red}Inactive{} until you play',
            [3] = 'a {C:attention}Royal Straight Flush{}',
            [4] = 'of {C:hearts}Hearts{}',
            [5] = '{C:inactive}#1#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 3
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.tex, card.ability.extra.swi, card.ability.extra.ger, localize((G.GAME.current_round.suit_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.suit_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.suit_card = { suit = 'Hearts' }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (context.scoring_name == "Straight Flush" and to_big(card.ability.extra.ger) == to_big(1) and G.GAME.current_round.current_hand.handname == localize("Royal Flush", "poker_hands")) then
                card.ability.extra.tex = 'Active'
                card.ability.extra.swi = 1
                return {
                    message = "Active!"
                }
            elseif to_big(card.ability.extra.swi) == to_big(1) then
                return {
                    x_chips = 3
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if not (context.other_card:is_suit("Hearts")) then
                card.ability.extra.ger = 0
            end
        end
        if context.before and context.cardarea == G.jokers  then
            return {
                func = function()
                    card.ability.extra.ger = 1
                    return true
                end
            }
        end
    end
}
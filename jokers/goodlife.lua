
SMODS.Joker{ --Good Life
    key = "goodlife",
    config = {
        extra = {
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Good Life',
        ['text'] = {
            [1] = 'First played {C:hearts}#1#{}, {C:clubs}#2#{},',
            [2] = '{C:diamonds}#3#{} and {C:spades}#4#{} each',
            [3] = 'give {X:red,C:white}X1.5{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.heart_card or {}).suit or 'Spades', 'suits_singular'), localize((G.GAME.current_round.clubs_card or {}).suit or 'Spades', 'suits_singular'), localize((G.GAME.current_round.diam_card or {}).suit or 'Spades', 'suits_singular'), localize((G.GAME.current_round.spa_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.heart_card or {}).suit or 'Spades'], G.C.SUITS[(G.GAME.current_round.clubs_card or {}).suit or 'Spades'], G.C.SUITS[(G.GAME.current_round.diam_card or {}).suit or 'Spades'], G.C.SUITS[(G.GAME.current_round.spa_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.heart_card = { suit = 'Hearts' }
        G.GAME.current_round.clubs_card = { suit = 'Clubs' }
        G.GAME.current_round.diam_card = { suit = 'Diamonds' }
        G.GAME.current_round.spa_card = { suit = 'Spades' }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if ((function()
                for i = 1, #context.scoring_hand do
                    local scoring_card = context.scoring_hand[i]
                    if scoring_card:is_suit("Spades") then
                        return scoring_card == context.other_card
                    end
                end
                return false
            end)() or (function()
                for i = 1, #context.scoring_hand do
                    local scoring_card = context.scoring_hand[i]
                    if scoring_card:is_suit("Hearts") then
                        return scoring_card == context.other_card
                    end
                end
                return false
            end)() or (function()
                for i = 1, #context.scoring_hand do
                    local scoring_card = context.scoring_hand[i]
                    if scoring_card:is_suit("Diamonds") then
                        return scoring_card == context.other_card
                    end
                end
                return false
            end)() or (function()
                for i = 1, #context.scoring_hand do
                    local scoring_card = context.scoring_hand[i]
                    if scoring_card:is_suit("Clubs") then
                        return scoring_card == context.other_card
                    end
                end
                return false
            end)()) then
                return {
                    Xmult = 1.5
                }
            end
        end
    end
}
SMODS.Joker{ --ultradiaxon-N3
    key = "ultradiaxonn3",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'ultradiaxon-N3',
        ['text'] = {
            [1] = 'This Joker Gains {C:red}+2{} Mult',
            [2] = 'per {C:attention}consecutive{} hand played',
            [3] = 'without playing repeated',
            [4] = '{C:attention}poker hand{} this round',
            [5] = '{C:inactive}(Currently{} {C:red}+#1# {C:inactive}Mult){}{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 1
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
        
        return {vars = {card.ability.extra.mult}}
    end,

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
                return {
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + 2
                        return true
                        end,
                        extra = {
                        message = "Dance!",
                        colour = G.C.RED
                    }
                }
            elseif G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                return {
                    func = function()
                        card.ability.extra.mult = 0
                        return true
                        end,
                        extra = {
                        message = "Wrong!",
                        colour = G.C.RED,
                        extra = {
                        message = "Try again!",
                        colour = G.C.RED
                    }
                }
            }
        end
    end
    if context.cardarea == G.jokers and context.joker_main  then
        return {
            mult = card.ability.extra.mult
        }
    end
end
}
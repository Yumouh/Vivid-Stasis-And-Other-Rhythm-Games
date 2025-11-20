SMODS.Joker{ --First Snow
    key = "firstsnow",
    config = {
        extra = {
            dollars = 1
        }
    },
    loc_txt = {
        ['name'] = 'First Snow',
        ['text'] = {
            [1] = 'Each scoring card',
            [2] = 'gives {C:money}$1{} when scored',
            [3] = 'on first {C:blue}hand{} each round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}
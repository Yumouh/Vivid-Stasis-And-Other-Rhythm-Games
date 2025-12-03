
SMODS.Joker{ --Chronomia
    key = "chronomia",
    config = {
        extra = {
            mul = 0,
            chi = 0
        }
    },
    loc_txt = {
        ['name'] = 'Chronomia',
        ['text'] = {
            [1] = 'Gain {C:red}+12{} Mult and {C:blue}+24{} Chips',
            [2] = 'when {C:attention}Big Blind{} is skipped',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{}{C:inactive}/{}{C:blue}+#2#{} {C:inactive}Mult/Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
        
        return {vars = {card.ability.extra.mul, card.ability.extra.chi}}
    end,
    
    calculate = function(self, card, context)
        if context.skip_blind  then
            if G.GAME.blind_on_deck == 'Boss' then
                return {
                    func = function()
                        card.ability.extra.mul = (card.ability.extra.mul) + 12
                        return true
                    end,
                    message = "Upgrade!",
                    extra = {
                        func = function()
                            card.ability.extra.chi = (card.ability.extra.chi) + 24
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chi,
                extra = {
                    mult = card.ability.extra.mul
                }
            }
        end
    end
}
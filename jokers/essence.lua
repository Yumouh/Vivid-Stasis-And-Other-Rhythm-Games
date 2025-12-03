
SMODS.Joker{ --Essence
    key = "essence",
    config = {
        extra = {
            mul = 1
        }
    },
    loc_txt = {
        ['name'] = 'Essence',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X1{} Mult when a',
            [2] = '{C:spectral}spectral{} card is used',
            [3] = '{C:attention}Reset{} when a {C:attention}booster pack{} is',
            [4] = 'skipped or a {C:spectral}spectral{} card is {C:attention}sold{}',
            [5] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mul}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  then
            if context.consumeable and context.consumeable.ability.set == 'Spectral' then
                return {
                    func = function()
                        card.ability.extra.mul = (card.ability.extra.mul) + 1
                        return true
                    end,
                    message = "Upgrade"
                }
            end
        end
        if context.skipping_booster  then
            if to_big(card.ability.extra.undefined) ~= to_big(1) then
                return {
                    func = function()
                        card.ability.extra.mul = 1
                        return true
                    end,
                    message = "Reset"
                }
            end
        end
        if context.selling_card and context.card.ability.set == 'Spectral' then
            if to_big(card.ability.extra.undefined) ~= to_big(1) then
                return {
                    func = function()
                        card.ability.extra.mul = 1
                        return true
                    end,
                    message = "Reset"
                }
            end
        end
    end
}
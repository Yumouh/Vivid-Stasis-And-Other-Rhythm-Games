SMODS.Joker{ --STARGAZERS
    key = "stargazers",
    config = {
        extra = {
            PlanetCount = 0,
            mult = 15,
            mult2 = 30
        }
    },
    loc_txt = {
        ['name'] = 'STARGAZERS',
        ['text'] = {
            [1] = '{C:red}+15{} Mult if a {C:planet}planet{} card',
            [2] = 'is in your consumable area',
            [3] = '{C:green}Doubles{} if you have at least {C:attention}3{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
    pools = { ["vsvsvsvs_mycustom_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if ((function()
                local count = 0
                for _, consumable_card in pairs(G.consumeables.cards or {}) do
                    if consumable_card.ability.set == 'Planet' then
                        count = count + 1
                    end
                end
                return count == 1
                end)() or (function()
                    local count = 0
                    for _, consumable_card in pairs(G.consumeables.cards or {}) do
                        if consumable_card.ability.set == 'Planet' then
                            count = count + 1
                        end
                    end
                    return count == 2
                    end)()) then
                        return {
                            mult = card.ability.extra.mult
                        }
                    elseif (function()
                        local count = 0
                        for _, consumable_card in pairs(G.consumeables.cards or {}) do
                            if consumable_card.ability.set == 'Planet' then
                                count = count + 1
                            end
                        end
                        return count >= 3
                        end)() then
                            return {
                                mult = card.ability.extra.mult2
                            }
                        end
                    end
                end
}
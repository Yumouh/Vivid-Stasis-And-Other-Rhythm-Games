SMODS.Joker{ --Eri
    key = "eri",
    config = {
        extra = {
            slot_change = 0,
            xchips = 3
        }
    },
    loc_txt = {
        ['name'] = 'Eri',
        ['text'] = {
            [1] = '{X:blue,C:white}X3{} Chips',
            [2] = 'Set {C:attention}Consumable Slots{} to {C:red}0{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
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

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.xchips
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        original_slots = G.consumeables.config.card_limit
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = card.ability.extra.slot_change
            return true
        end }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        if original_slots then
            G.E_MANAGER:add_event(Event({func = function()
                G.consumeables.config.card_limit = original_slots
                return true
            end }))
        end
    end
}
SMODS.Joker{ --Speculation
    key = "speculation",
    config = {
        extra = {
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Speculation',
        ['text'] = {
            [1] = 'Sell this card to create',
            [2] = 'a free {C:attention}Investment tag{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.selling_self  then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag("tag_investment")
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                        end
                    }))
                    return true
                    end,
                    message = "Created Tag!"
                }
            end
        end
}
SMODS.Joker{ --Solomons seal
    key = "solomonsseal",
    config = {
        extra = {
            repetitions = 1,
            dollars = 3,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Solomons seal',
        ['text'] = {
            [1] = '{C:gold}Gold{}, {C:red}Red{} and {C:purple}Purple{} {C:attention}Seal{}',
            [2] = 'share their abilities'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_stargaze_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (context.other_card.seal == "Gold" or context.other_card.seal == "Purple") then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if (context.other_card.seal == "Red" or context.other_card.seal == "Purple") then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        if context.discard  then
            if (context.other_card.seal == "Gold" or context.other_card.seal == "Red") then
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', })                            
                                card:juice_up(0.3, 0.5)
                                return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                        end
                        return true
                        end
                    }
                end
            end
        end
}
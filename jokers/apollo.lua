
SMODS.Joker{ --Apollo
    key = "apollo",
    config = {
        extra = {
            times = 1,
            most = 0
        }
    },
    loc_txt = {
        ['name'] = 'Apollo',
        ['text'] = {
            [1] = 'When selecting {C:attention}Boss Blind{},',
            [2] = '{C:attention}Upgrade{} your most played',
            [3] = 'poker hand {C:attention}#1#{} time(s)',
            [4] = 'This amount increases by {C:attention}1{}',
            [5] = 'when{C:attention} Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.times}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            if G.GAME.blind.boss then
                local temp_played = 0
                local temp_order = math.huge
                local target_hand
                for hand, value in pairs(G.GAME.hands) do 
                    if value.played > temp_played and value.visible then
                        temp_played = value.played
                        temp_order = value.order
                        target_hand = hand
                    elseif value.played == temp_played and value.visible then
                        if value.order < temp_order then
                            temp_order = value.order
                            target_hand = hand
                        end
                    end
                end
                
                level_up_hand(card, target_hand, true, card.ability.extra.times)
                return {
                    message = localize('k_level_up_ex')
                }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            return {
                func = function()
                    card.ability.extra.times = (card.ability.extra.times) + 1
                    return true
                end,
                message = "Upgrade!"
            }
        end
    end
}
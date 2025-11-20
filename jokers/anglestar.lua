SMODS.Joker{ --Anglestar
    key = "anglestar",
    config = {
        extra = {
            chip = 0
        }
    },
    loc_txt = {
        ['name'] = 'Anglestar',
        ['text'] = {
            [1] = 'Gain {C:blue}+7{} Chips',
            [2] = 'if played hand',
            [3] = '{C:red}doesn\'t{} contain a {C:attention}Pair{}',
            [4] = '{C:inactive}(Currently{} {C:blue}+#1#{}{C:inactive} chips){}',
            [5] = '{s:0.8}It\'s not pair!!!!!!!!!!!!',
            [6] = '{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chip}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chip
            }
        end
        if context.before and context.cardarea == G.jokers  then
            if not (next(context.poker_hands["Pair"])) then
                return {
                    func = function()
                        card.ability.extra.chip = (card.ability.extra.chip) + 7
                        return true
                        end,
                        message = "Upgrade!"
                    }
                end
            end
        end
}
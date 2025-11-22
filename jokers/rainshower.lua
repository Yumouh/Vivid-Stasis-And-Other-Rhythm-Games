SMODS.Joker{ --Rainshower
    key = "rainshower",
    config = {
        extra = {
            Req = 5,
            left = 5,
            xchips = 2
        }
    },
    loc_txt = {
        ['name'] = 'Rainshower',
        ['text'] = {
            [1] = '{X:blue,C:white}X2{} Chips every {C:attention}#1#{} hands played',
            [2] = 'Hand requirement reduces by',
            [3] = '{C:attention}1{} after each time it triggers',
            [4] = '{C:inactive}#2# remaining{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
        
        return {vars = {card.ability.extra.Req, card.ability.extra.left}}
    end,

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if card.ability.extra.left >= 1 then
                return {
                    func = function()
                        card.ability.extra.left = math.max(0, (card.ability.extra.left) - 1)
                        return true
                        end
                    }
                end
            end
            if context.cardarea == G.jokers and context.joker_main  then
                if card.ability.extra.left <= 0 then
                    return {
                        x_chips = card.ability.extra.xchips
                    }
                end
            end
            if context.after and context.cardarea == G.jokers  then
                if (card.ability.extra.left <= 0 and card.ability.extra.Req >= 2) then
                    return {
                        func = function()
                            card.ability.extra.Req = math.max(0, (card.ability.extra.Req) - 1)
                            return true
                            end,
                            extra = {
                            func = function()
                                card.ability.extra.left = card.ability.extra.Req
                                return true
                                end,
                                colour = G.C.BLUE
                            }
                        }
                    end
                end
            end
}
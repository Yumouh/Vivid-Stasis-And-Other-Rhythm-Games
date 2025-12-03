SMODS.Joker{ --See You Move
    key = "seeyoumove",
    config = {
        extra = {
            chips = 15,
            mult = 3,
            scale = 2,
            rotation = 2,
            constant = 0
        }
    },
    loc_txt = {
        ['name'] = 'See You Move',
        ['text'] = {
            [1] = 'Played {C:attention}Jacks{} and {C:attention}8s{} give',
            [2] = '{C:red}+3{} Mult and {C:blue}+15{} Chips when scored',
            [3] = '{C:inactive}ANNOYING{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
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

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:get_id() == 8 or context.other_card:get_id() == 11) then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                    mult = card.ability.extra.mult
                }
            }
        end
    end
    if context.setting_blind  then
        local target_card = context.other_card
        local function juice_card_until_(card, eval_func, first, delay) -- balatro function doesn't allow for custom scale and rotation
            G.E_MANAGER:add_event(Event({
            trigger = 'after',delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
        func = (function() if eval_func(card) then if not first or first then card:juice_up(card.ability.extra.scale, card.ability.extra.rotation) end;juice_card_until_(card, eval_func, nil, 0.8) end return true end)
        }))
    end
    return {
        func = function()
        local eval = function() return not G.RESET_JIGGLES end
            juice_card_until_(card, eval, true)
            return true
            end
        }
    end
end
}
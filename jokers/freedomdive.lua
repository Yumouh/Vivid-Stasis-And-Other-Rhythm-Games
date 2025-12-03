
SMODS.Joker{ --Freedom Dive↓
    key = "freedomdive",
    config = {
        extra = {
            left = 10,
            swi = 0,
            start_dissolve = 0,
            n = 0,
            no = 0,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Freedom Dive↓',
        ['text'] = {
            [1] = '{C:money}-2${} {C:attention}cards{} and',
            [2] = '{C:attention}Boosters Packs{} cost',
            [3] = 'Consumed in {C:attention}#1#{} purchases',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.left, card.ability.extra.swi}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key ~= 'freedomdive' then
            if true then
                return {
                    func = function()
                        card.ability.extra.swi = 1
                        return true
                    end
                }
            elseif to_big(card.ability.extra.left) <= to_big(1) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            elseif true then
                return {
                    func = function()
                        card.ability.extra.left = math.max(0, (card.ability.extra.left) - 1)
                        return true
                    end,
                    message = "Dive↓↓↓"
                }
            end
        end
        if context.open_booster  then
            if to_big(card.ability.extra.left) <= to_big(1) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            else
                return {
                    func = function()
                        card.ability.extra.left = math.max(0, (card.ability.extra.left) - 1)
                        return true
                    end,
                    message = "Dive↓↓↓"
                }
            end
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}


local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    
    if next(SMODS.find_card("j_vsvsvsvs_freedomdive")) then
        if (self.ability.set == 'Joker' or self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Enhanced' or self.ability.set == 'Booster' or self.ability.set == 'Voucher') then
            self.cost = math.max(0, self.cost - (2))
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end
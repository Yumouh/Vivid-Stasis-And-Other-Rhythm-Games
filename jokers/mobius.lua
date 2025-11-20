SMODS.Joker{ --Möbius
    key = "mobius",
    config = {
        extra = {
            Yes = 1
        }
    },
    loc_txt = {
        ['name'] = 'Möbius',
        ['text'] = {
            [1] = 'When a {C:attention}voucher{} is redeemed,',
            [2] = 'also redeem its {C:attention}upgraded version{}',
            [3] = '{C:inactive}(Once per Ante){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
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
    pools = { ["vsvsvsvs_vsvsvsvs_jokers"] = true },

    add_to_deck = function(self, card, from_debuff)
        -- 保存原始的兑换函数到全局变量
        if not G.original_redeem then
            G.original_redeem = Card.redeem
        end
        
        -- 初始化每底注触发标志
        if not G.GAME.modifiers.mobius_used_this_ante then
            G.GAME.modifiers.mobius_used_this_ante = false
        end
        
        -- 重写兑换函数
        function Card:redeem()
            G.original_redeem(self)

            -- 检查是否已经在本底注中使用过
            if G.GAME.modifiers.mobius_used_this_ante then
                return
            end
            
            -- 直接应用效果，不检查Möbius是否在牌组中
            if
                #G.play.cards == 0
                and (not G.redeemed_vouchers_during_hand or #G.redeemed_vouchers_during_hand.cards == 0)
            then
                G.mobius_redeemed_buffer = {}
            end
            
            for k, v in pairs(G.P_CENTER_POOLS["Voucher"]) do
                if v.requires and not G.GAME.used_vouchers[v] then
                    for _, vv in pairs(v.requires) do
                        if vv == self.config.center.key then
                            -- 兑换额外优惠券的代码基于Betmma's Vouchers
                            local area
                            if G.STATE == G.STATES.HAND_PLAYED then
                                if not G.redeemed_vouchers_during_hand then
                                    G.redeemed_vouchers_during_hand = CardArea(
                                        G.play.T.x,
                                        G.play.T.y,
                                        G.play.T.w,
                                        G.play.T.h,
                                        { type = "play", card_limit = 5 }
                                    )
                                end
                                area = G.redeemed_vouchers_during_hand
                            else
                                area = G.play
                            end
                            
                            if not G.mobius_redeemed_buffer then
                                G.mobius_redeemed_buffer = {}
                            end
                            
                            if not G.mobius_redeemed_buffer[v.key] and v.unlocked then
                                local voucher_card = create_card("Voucher", area, nil, nil, nil, nil, v.key)
                                G.mobius_redeemed_buffer[v.key] = true
                                voucher_card:start_materialize()
                                area:emplace(voucher_card)
                                voucher_card.cost = 0
                                voucher_card.shop_voucher = false
                                local current_round_voucher = G.GAME.current_round.voucher
                                voucher_card:redeem()
                                G.GAME.current_round.voucher = current_round_voucher
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    delay = 0,
                                    func = function()
                                        voucher_card:start_dissolve()
                                        return true
                                    end,
                                }))
                                
                                -- 标记为已在本底注中使用
                                G.GAME.modifiers.mobius_used_this_ante = true
                                
                                -- 显示提示信息
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    func = function()
                                        card:juice_up(0.5, 0.5)
                                        return true
                                    end
                                }))
                            end
                        end
                    end
                end
            end
        end
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card:juice_up(0.5, 0.5)
                return true
            end
        }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        -- 恢复原始兑换函数
        if G.original_redeem then
            Card.redeem = G.original_redeem
            G.original_redeem = nil
        end
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                return true
            end
        }))
    end,
    
    calculate = function(self, card, context)
        -- 在底注变化时重置使用标志
        if context.ante_change then
            G.GAME.modifiers.mobius_used_this_ante = false
            return {

            }
        end
        
        return nil
    end
}
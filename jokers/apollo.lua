SMODS.Joker{ --Apollo
    key = "apollo",
    config = {
        extra = {
            levels = 1,
            most = 0
        }
    },
    loc_txt = {
        ['name'] = 'Apollo',
        ['text'] = {
            [1] = 'When selecting a {C:attention}blind{},',
            [2] = '{C:green}Upgrade{} your highest level',
            [3] = 'poker hand, {C:red}downgrade{}',
            [4] = 'your most played poker hand'
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

    
    calculate = function(self, card, context)
        if context.setting_blind then
            -- 找到等级最高的牌型（使用berry_juice_planet的方法）
            local temp_hands = {}
            local sort_function = function(hand1, hand2) return hand1.level >= hand2.level end
            for k, v in pairs(G.GAME.hands) do
                if v.visible then
                    local hand = v
                    hand.handname = k
                    table.insert(temp_hands, hand)
                end
            end
            table.sort(temp_hands, sort_function)
            local highest_level_hand = temp_hands[1].handname
            
            -- 找到打出次数最多的牌型（使用Apollo的方法）
            local temp_played = 0
            local temp_order = math.huge
            local most_played_hand
            for hand, value in pairs(G.GAME.hands) do 
                if value.played > temp_played and value.visible then
                    temp_played = value.played
                    temp_order = value.order
                    most_played_hand = hand
                elseif value.played == temp_played and value.visible then
                    if value.order < temp_order then
                        temp_order = value.order
                        most_played_hand = hand
                    end
                end
            end
            
            -- 升级等级最高的牌型
            if highest_level_hand then
                level_up_hand(card, highest_level_hand, nil, 1)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, 
                    {handname=localize(highest_level_hand, 'poker_hands'), 
                     chips = G.GAME.hands[highest_level_hand].chips, 
                     mult = G.GAME.hands[highest_level_hand].mult, 
                     level=G.GAME.hands[highest_level_hand].level})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end
            
            -- 降级打出次数最多的牌型
            if most_played_hand then
                level_up_hand(card, most_played_hand, nil, -1)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, 
                    {handname=localize(most_played_hand, 'poker_hands'), 
                     chips = G.GAME.hands[most_played_hand].chips, 
                     mult = G.GAME.hands[most_played_hand].mult, 
                     level=G.GAME.hands[most_played_hand].level})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end
            

            
            return {
               
            }
        end
    end
}
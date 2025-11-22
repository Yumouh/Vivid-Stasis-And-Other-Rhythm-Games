SMODS.Joker{ --stop-motion
    key = "stopmotion",
    config = {
        extra = {
            Xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'stop-motion',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult',
            [2] = 'All cards {C:red}cannot{} be {C:attention}moved{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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

    -- 保存原始移动函数的引用
    original_drag = nil,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        -- 保存原始移动函数
        if not self.original_drag then
            self.original_drag = Moveable.drag
        end
        
        -- 重写移动函数来禁止移动
        function Moveable.drag(self, offset)
            if self.is and type(self.is) == "function" and self:is(Card) then
                -- 如果是卡牌，禁止移动
                return
            end
            -- 对于其他可移动对象，使用原始函数
            return self.original_drag(self, offset)
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
        -- 恢复原始移动函数
        if self.original_drag then
            Moveable.drag = self.original_drag
            self.original_drag = nil
        end
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                return true
            end
        }))
    end
}
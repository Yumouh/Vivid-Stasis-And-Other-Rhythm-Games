SMODS.Joker{ --Second Heaven
    key = "secondheaven",
    config = {
        extra = {
            chips = 300
        }
    },
    loc_txt = {
        ['name'] = 'Second Heaven',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:blue}-15{} Chips for',
            [3] = 'every hand played',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
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
    in_pool = function(self, args)
          return (
          not args 
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and G.GAME.pool_flags.vsvsvsvs_ripdestroyed
      end,

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            local chips_value = card.ability.extra.chips
            card.ability.extra.chips = math.max(0, (card.ability.extra.chips) - 15)
            return {
                chips = chips_value,
                extra = {
                message = "-15",
                colour = G.C.RED
            }
        }
    end
end
}
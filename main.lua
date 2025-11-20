SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.current_mod.description_loc_vars = function()
    return {background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true}
end

SMODS.current_mod.custom_ui = function(nodes)
    local _, description = unpack(nodes)
    local wiki_deepfind = SMODS.deepfind(description, "https://balatromods.miraheze.org/wiki/Brook", true)[1]
    if wiki_deepfind then
        local wiki_link_table = wiki_deepfind.objtree[#wiki_deepfind.objtree-2]
        wiki_link_table.config.button = "open_brook_wiki"
        wiki_link_table.config.tooltip = {text = {localize("b_open_brook_wiki")}}
    end
    local wiki_deepfindvs = SMODS.deepfind(description, "https://balatromods.miraheze.org/wiki/VividStasisAndOtherRhythmGames", true)[1]
    if wiki_deepfindvs then
        local wiki_link_table = wiki_deepfindvs.objtree[#wiki_deepfindvs.objtree-2]
        wiki_link_table.config.button = "open_vsaorg_wiki"
        wiki_link_table.config.tooltip = {text = {localize("b_open_vsaorg_wiki")}}
    end
end

G.FUNCS.open_brook_wiki = function(e)
    love.system.openURL("https://balatromods.miraheze.org/wiki/Brook")
end

G.FUNCS.open_vsaorg_wiki = function(e)
    love.system.openURL("https://balatromods.miraheze.org/wiki/VividStasisAndOtherRhythmGames")
end

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {27,25,3,8,22,13,10,29,15,24,30,12,28,20,4,11,1,14,26,7,19,18,5,16,6,17,2,21,23,9}

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #jokerIndexList do
        local file_name = files[jokerIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end

load_jokers_folder()
SMODS.ObjectType({
    key = "vsvsvsvs_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "vsvsvsvs_vsvsvsvs_jokers",
    cards = {
        ["j_vsvsvsvs_abyssgazer"] = true,
        ["j_vsvsvsvs_aleph0"] = true,
        ["j_vsvsvsvs_anglestar"] = true,
        ["j_vsvsvsvs_apollo"] = true,
        ["j_vsvsvsvs_bbkkbkk"] = true,
        ["j_vsvsvsvs_chaos"] = true,
        ["j_vsvsvsvs_cutter"] = true,
        ["j_vsvsvsvs_dawn"] = true,
        ["j_vsvsvsvs_destruction321"] = true,
        ["j_vsvsvsvs_eri"] = true,
        ["j_vsvsvsvs_firstsnow"] = true,
        ["j_vsvsvsvs_freedomdive"] = true,
        ["j_vsvsvsvs_kotomi"] = true,
        ["j_vsvsvsvs_mobius"] = true,
        ["j_vsvsvsvs_mvurbd"] = true,
        ["j_vsvsvsvs_rainshower"] = true,
        ["j_vsvsvsvs_rgb"] = true,
        ["j_vsvsvsvs_rip"] = true,
        ["j_vsvsvsvs_secondheaven"] = true,
        ["j_vsvsvsvs_seeyoumove"] = true,
        ["j_vsvsvsvs_speculation"] = true,
        ["j_vsvsvsvs_stopmotion"] = true,
        ["j_vsvsvsvs_tsuki"] = true,
        ["j_vsvsvsvs_ultradiaxonn3"] = true
    },
})

SMODS.ObjectType({
    key = "vsvsvsvs_stargaze_jokers",
    cards = {
        ["j_vsvsvsvs_allison"] = true,
        ["j_vsvsvsvs_chiyo"] = true,
        ["j_vsvsvsvs_saturday"] = true,
        ["j_vsvsvsvs_solomonsseal"] = true
    },
})

SMODS.ObjectType({
    key = "vsvsvsvs_vividsta_jokers",
    cards = {
        ["j_vsvsvsvs_nhelv"] = true
    },
})

SMODS.ObjectType({
    key = "vsvsvsvs_mycustom_jokers",
    cards = {
        ["j_vsvsvsvs_stargazers"] = true
    },
})
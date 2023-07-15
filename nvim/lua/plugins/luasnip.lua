return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
    version = "1.2.*",
    build = "make install_jsregexp",
    config = function()
        -- Load snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()

        require("luasnip").filetype_extend("all", { "_" })
    end,
}

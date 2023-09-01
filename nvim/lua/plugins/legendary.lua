return {
    "mrjones2014/legendary.nvim",
    version = "v2.1.0",
    priority = 998,
    lazy = false,
    config = function()
        local legendary = require("legendary")
        local keymaps = require("keymaps")
        local autocmds = require("autocmd")

        legendary.setup({
            keymaps = keymaps.get_keymaps(),
            autocmds = autocmds.get_autocmds(),
            lazy_nvim = {
                auto_register = true,
            },
            extensions = {
                nvim_tree = true,
                smart_splits = true,
                op_nvim = false,
                diffview = false,
            },
        })
    end,
}

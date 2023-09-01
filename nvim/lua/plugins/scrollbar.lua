return {
    "petertriho/nvim-scrollbar",
    config = function()
        require("scrollbar").setup({
            excluded_buftypes = {
                "terminal",
                "neo-tree",
            },
            excluded_filetypes = {
                "cmp_docs",
                "cmp_menu",
                "noice",
                "prompt",
                "TelescopePrompt",
                "neo-tree",
            },
        })
    end,
}

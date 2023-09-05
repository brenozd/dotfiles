return {
    "williamboman/mason.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "p00f/clangd_extensions.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󱍷",
                    package_uninstalled = "",
                },
            },
        })
    end
}

return {
    "glepnir/dashboard-nvim",
    enabled = false,
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        local dashboard = require("dashboard")
        dashboard.setup({
            theme = "hyper",
            change_to_vcs_root = false,
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = "󰊳 Update",
                        group = "@property",
                        action = "Lazy update",
                        key = "u",
                    },
                    {
                        icon = " ",
                        icon_hl = "@variable",
                        desc = "files",
                        group = "label",
                        action = "telescope find_files",
                        key = "f",
                    },
                },
            },
        })
    end,
}

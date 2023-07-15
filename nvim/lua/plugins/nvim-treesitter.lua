return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    priority = 999,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            autotag = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            autopairs = { enable = true },
            indent = { enable = true },
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },
            sync_install = true,
            auto_install = true,
            incremental_selection = { enable = true },
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
                highlight_current_scope = { enable = true },
            },
        })
    end,
}

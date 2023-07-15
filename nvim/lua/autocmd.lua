M = {}

local function get_session_name()
    local name = vim.fn.getcwd()
    local branch = vim.fn.system("git branch --show-current")
    if vim.v.shell_error == 0 then
        return name .. branch
    else
        return name
    end
end

local function get_autocmds()
    return {
        {
            "VimEnter",
            function()
                vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
            end,
            descrption = "Changes automatically to execution directory",
        },
        {
            "VimEnter",
            function()
                if vim.fn.argc(-1) == 0 then
                    local session_name = get_session_name()
                    require("resession").load(session_name, { dir = "dirsession", silence_errors = true })
                else
                    vim.cmd(":enew|bd#")
                end
            end,
            descrption = "Changes automatically to execution directory",
        },
        {
            "VimLeavePre",
            function()
                local session_name = get_session_name()
                require("resession").save(session_name, { dir = "dirsession", notify = true })
            end,
            descrption = "Changes automatically to execution directory",
        },
        {
            "LspAttach",
            function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "A", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
                vim.keymap.set("n", "<C-f>", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end,
            description = "Enable LSP keymaps on LSP Attach",
        }
    }
end

M.get_autocmds = get_autocmds

return M

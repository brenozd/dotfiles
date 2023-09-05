vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gr", "<cmd>Glance references<cr>", opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>", opts)
        vim.keymap.set("n", "gi", "<CMD>Glance implementations<CR>", opts)
        vim.keymap.set("n", "<leader>d", "<CMD>Glance type_definitions<CR>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<C-f>", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
require("glance")

mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor() or vim.fn.getcwd()
            end,
        })
    end,

    ["lua_ls"] = function()
        capabilities = capabilities
        require("neodev").setup()
        lspconfig["lua_ls"].setup({
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })
    end,

    ["clangd"] = function()
        lspconfig["clangd"].setup({
            cmd = {
                "clangd",
                "--offset-encoding=utf-8",
                "--background-index",
                "--header-insertion=never",
            },
            root_dir = lspconfig.util.root_pattern(".git"),
        })
    end,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.completion.spell,
    },
})

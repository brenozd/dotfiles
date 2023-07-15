return {
	"jose-elias-alvarez/null-ls.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.diagnostics.eslint,
                -- null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.code_actions.shellcheck,
			},
			-- Format on saving
			-- on_attach = function(client, bufnr)
			--     if client.supports_method("textDocument/formatting") then
			--         vim.api.nvim_clear_autocmds({ buffer = bufnr })
			--         vim.api.nvim_create_autocmd("BufWritePre", {
			--             buffer = bufnr,
			--             callback = function()
			--                 vim.lsp.buf.format({ async = false })
			--             end,
			--         })
			--     end
			-- end,
		})
	end,
}

local function format(buf)
	local null_ls_sources = require("null-ls.sources")
	local ft = vim.bo[buf].filetype

	local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format({
		bufnr = buf,
		filter = function(client)
			if has_null_ls then
				return client.name == "null-ls"
			else
				return true
			end
		end,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", opts)
		vim.keymap.set("n", "gt", "<CMD>Lspsaga goto_type_definitions<CR>", opts)
		vim.keymap.set("n", "gf", "<CMD>Lspsaga finder ref+def+imp<CR>", opts)
		vim.keymap.set("n", "ga", "<CMD>Lspsaga code_action<CR>")
		vim.keymap.set("n", "gr", "<CMD>Lspsaga rename<CR>")
		vim.keymap.set("n", "A", "<CMD>Lspsaga hover_doc<CR>", opts)
		vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<C-f>", function() format(ev.buf) end, opts)
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			root_dir = function(_)
				return lspconfig.util.find_git_ancestor() or vim.fn.getcwd()
			end,
		})
	end,

	["lua_ls"] = function()
		capabilities = capabilities
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})
		lspconfig["lua_ls"].setup({
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,

	-- ["clangd"] = function()
	-- 	lspconfig["clangd"].setup({
	-- 		cmd = {
	-- 			"clangd",
	-- 			"--offset-encoding=utf-8",
	-- 			"--background-index",
	-- 			"--header-insertion=never",
	-- 		},
	-- 		root_dir = lspconfig.util.root_pattern(".git"),
	-- 	})
	-- end,
})

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
	handlers = {},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
    -- C/C++
    -- null_ls.builtins.diagnostics.clang_check,
    -- null_ls.builtins.diagnostics.cmake_lint,
    -- null_ls.builtins.diagnostics.cpplint,
    -- Python
		null_ls.builtins.formatting.autopep8,
    -- Lua
		null_ls.builtins.formatting.stylua,
    -- Shell
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
    -- Generic
		-- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.codespell,
		null_ls.builtins.completion.spell,
	},
})

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

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- External LSP applications driven by community
			"nvimtools/none-ls.nvim",
			-- Easy the configuration of LSPs
			"williamboman/mason-lspconfig.nvim",
			-- Quickstart configuration for LSP
			"neovim/nvim-lspconfig",
			{
				"jay-babu/mason-null-ls.nvim",
				event = { "BufReadPre", "BufNewFile" },
			},
		},
		config = function()
			local mason = require("mason")
			mason.setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "󱍷",
						package_uninstalled = "",
					},
				},
			})
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
	},
	{ -- Easy lua plugin development
		"folke/neodev.nvim",
	},
	{
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
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			lightbulb = {
				enable = false,
			},
		},
	},
}

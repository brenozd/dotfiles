return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-under-comparator",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"honza/vim-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		version = "2.*",
		build = "make install_jsregexp",
	},
}

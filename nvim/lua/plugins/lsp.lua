return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"nvim-lua/plenary.nvim",
	    "jose-elias-alvarez/null-ls.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"p00f/clangd_extensions.nvim",
        "folke/neodev.nvim",
	},
}

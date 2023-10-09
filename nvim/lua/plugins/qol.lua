return {
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"max397574/better-escape.nvim",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"willothy/moveline.nvim",
		build = "make",
		priority = 999,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
	},
	{
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
	},
	{ "sitiom/nvim-numbertoggle" },
	{
		"stevearc/stickybuf.nvim",
		config = function() end,
	},
	{
		"yamatsum/nvim-cursorline",
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"smjonas/inc-rename.nvim",
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
}
